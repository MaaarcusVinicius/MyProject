unit BancoDadosUnt;
interface

uses
  Forms, SysUtils, Classes, WideStrings, DBXOracle, DB, SqlExpr, Dialogs, xmldom,
  XMLIntf, XMLDoc, msxmldom, DBClient, SimpleDS, FMTBcd, MensagensUnt,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, IniFiles, Windows;

type
  TBancoDadosDtMdl = class(TDataModule)
    TabelasXML: TXMLDocument;
    FDConnection: TFDConnection;
    EmpresasQry: TFDQuery;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    RelacoesQry: TFDQuery;
    DDLFKQry: TFDQuery;
    SelecaoQry: TFDQuery;
    ConectadosQry: TFDQuery;
    PrimaryKeyQry: TFDQuery;
    UtilizadasQry: TFDQuery;
    SequenciaisQry: TFDQuery;
    FKTabelaQry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    //XmlPadrao: TXMLDocument;
    ConfigIni: TMemIniFile;
    function HabDesabTriggers(Valor: Boolean; Tabelas: TStringList):Boolean;
    function RetornaTabRelacionadas(Tabela: String): TStringList;
    function HabDesabDeletarCascata(Valor: Boolean; Tabelas: TStringList): Boolean;
    function HabDesabChavesEstrangeiras(Valor: Boolean; Tabelas: TStringList): Boolean;
    procedure CarregarTabelas;

  public
    { Public declarations }
    function Conectar(Usuario:String; Senha:String; BancoDados:String): Boolean;
    function RetornaTabelas: IDOMNodeList;
    function RetornaPrimaryKey(Tabela: String): String;
    procedure AposConectar;
    function UsuariosConectados: Boolean;
    procedure DeletarDados(Selecoes: TStringList);
    procedure TrocaEmpresa(EmpresaAntiga: String; EmpresaNova: String);
    function GetConfigIni: TMemIniFile;
    procedure SetConfigIni(Arquivo: String);
    function GetTabUtilizadas: Integer;
  end;

const
  SQL_RETORNA_COLUNAS_FK = 'CREATE OR REPLACE FUNCTION'
    + ' RETORNA_COLUNAS_FK(NOME_FK IN VARCHAR2) RETURN VARCHAR2 IS'
    + ' COLUNAS VARCHAR2(1000); BEGIN select wm_concat(column_name)'
    + ' into COLUNAS from (select column_name from user_cons_columns where'
    + ' constraint_name = NOME_FK order by position); RETURN (COLUNAS);'
    + ' END RETORNA_COLUNAS_FK;';
  SQL_COUNT_ROWS = 'create or replace function COUNT_ROWS(TABELA IN VARCHAR2)'
    + ' return integer is Result integer; begin EXECUTE IMMEDIATE ''SELECT'
    + ' COUNT(*) FROM '' || TABELA INTO Result; return Result; EXCEPTION WHEN'
    + ' OTHERS THEN return -1; end COUNT_ROWS;';
  PROCESSO_ABORTADO = 'Processo abortado por apresentar erros! Verifique os'
    + ' log''s do processo e caso necessário execute o Atua.exe para recriar'
    + ' as chaves estrangeiras.';

var
  BancoDadosDtMdl: TBancoDadosDtMdl;

implementation

uses
  StatusUnt;
{$R *.dfm}

function TBancoDadosDtMdl.Conectar(Usuario:String; Senha:String;
                                    BancoDados:String): Boolean;
{Conecta ao banco de dados de acordo com os parametros informados,
  retornando a confirmação da conexão.}
  begin
    try
      FDConnection.Close;
      FDConnection.Params.Values['User_Name']:= Usuario;
      FDConnection.Params.Values['Password']:= Senha;
      FDConnection.Params.Values['Database']:= BancoDados;
      FDConnection.Open;
      Result:= true;
    except
      on E : Exception do
        begin
          Result:= false;
          MensagensFrm.MsgBox(ERRO_ACESSO_BD, E.Message);
        end;
    end;
    Result:= Result;
  end;

procedure TBancoDadosDtMdl.DataModuleCreate(Sender: TObject);
{Executa configurações iniciais necessárias.}
begin
  TabelasXML.Active:= True;
  SetConfigIni(Application.ExeName.Replace('.exe','.ini'));
end;

function TBancoDadosDtMdl.RetornaPrimaryKey(Tabela: String): String;
{Retorna chave primária da tabela.}
begin
    PrimaryKeyQry.Filtered:= False;
    PrimaryKeyQry.Filter:= 'TABLE_NAME = ' + QuotedStr(Tabela);
    PrimaryKeyQry.Filtered:= True;
    if PrimaryKeyQry.RecordCount > 0 then
      begin
        Result:= PrimaryKeyQry.Fields[0].AsString;
      end
    else
      begin
        Result:= 'ROWID';
      end;
end;

procedure TBancoDadosDtMdl.TrocaEmpresa(EmpresaAntiga, EmpresaNova: String);
var
  Tabelas: TStringList;
  I: Integer;
  Sql: String;
begin
    Tabelas:= TStringList.Create;
    UtilizadasQry.Close;
    UtilizadasQry.Open();
    UtilizadasQry.FetchAll;
    UtilizadasQry.Filter:= 'COUNT > 0 AND CAMPO_EMPRESA IS NOT NULL';
    UtilizadasQry.Filtered:=True;
    while not UtilizadasQry.Eof do
      begin
        Tabelas.Add(UtilizadasQry.Fields[0].AsString);
        UtilizadasQry.Next;
      end;
    HabDesabTriggers(False, Tabelas);
    HabDesabChavesEstrangeiras(False, Tabelas);
    for I := 0 to Tabelas.Count - 1 do
      begin
        Sql:= '';
        try
          StatusFrm.Status('Trocando empresa na tabela ' + Tabelas[I] + '...');
          if Tabelas[I] = 'EMPRESAS' then
            begin
              Sql:= 'UPDATE ' + Tabelas[I] + ' SET EMPRESA_ID ='
                + QuotedStr(EmpresaNova) + ', EMPRESA_USO ='
                + QuotedStr(EmpresaNova) + ' WHERE EMPRESA_ID ='
                + QuotedStr(EmpresaAntiga);
            end
          else
            begin
            Sql:= 'UPDATE ' + Tabelas[I] + ' SET EMPRESA_ID ='
                + QuotedStr(EmpresaNova) + ' WHERE EMPRESA_ID ='
                + QuotedStr(EmpresaAntiga);
            end;
          FDConnection.ExecSQL(Sql);
        except
          on E : Exception do
            begin
              StatusFrm.Status(E.Message);
              MensagensFrm.MsgBox(ERRO_TROCA_EMPRESA, 'Tabela: ' + Tabelas[I]
                                  + sLineBreak + E.Message + sLineBreak
                                  + 'SQL:' + Sql);
            end;
        end;
      end;
    HabDesabTriggers(True, Tabelas);
    HabDesabChavesEstrangeiras(True, Tabelas);
    EmpresasQry.Refresh;
    StatusFrm.Hide;
end;

function TBancoDadosDtMdl.UsuariosConectados: Boolean;
{Verifica se existe usuários conectados e retorna True ou False.}
begin
  ConectadosQry.Close;
  ConectadosQry.ParamByName('USUARIO').AsString:= FDConnection.Params.Values['User_Name'];
  ConectadosQry.ParamByName('PROGRAMA').AsString:= ExtractFileName(Application.ExeName);
  ConectadosQry.Open;
  Result:= ConectadosQry.RecordCount > 0;
end;

function TBancoDadosDtMdl.RetornaTabelas: IDOMNodeList;
{Retorna NodeList com os nós principais do componente ConfigTabelasXML.}
begin
  Result:= TabelasXML.DOMDocument.firstChild.childNodes;
end;

function TBancoDadosDtMdl.RetornaTabRelacionadas(Tabela: String): TStringList;
{Retorna StringList com todas as tabelas relacionadas da tabela solicitada.}
var
  iNode: IDOMNode;
  procedure ProcessNode(Node: IDOMNode);
  var
    cNode: IDOMNode;
  begin
    if (Node = nil) then
      begin
        Exit;
      end;
    Result.Add(Node.nodeName);
    cNode := Node.firstChild;
    while (cNode <> nil) do
      begin
        ProcessNode(cNode);
        cNode := cNode.nextSibling;
      end;
  end;
begin
  Result:= TStringList.Create;
  iNode:= TabelasXML.DOMDocument.getElementsByTagName(Tabela).item[0];
  if iNode <> nil then
    begin
      ProcessNode(iNode);
    end;
end;

procedure TBancoDadosDtMdl.SetConfigIni(Arquivo: String);
{Verifica se arquivo existe e atribui valor a ConfigIni, caso não exista
  cria o arquivo com a resource ConfigPardao. Exceções não usam
  Application.MessageBox.}
var
  RStream: TResourceStream;
begin
  if not FileExists(Arquivo) then
    begin
      RStream := TResourceStream.Create(HInstance, 'LimpaBaseRscIni', RT_RCDATA);
        try
          RStream.SaveToFile(Arquivo);
        except on E : Exception do
          begin
            Application.MessageBox(PChar('Erro ao gravar arquivo ' + Arquivo
              +'!' + sLineBreak + E.Message),PChar('Erro'), MB_ICONERROR + MB_OK);
          end;
        end;
      RStream.Free;
    end;
  try
    ConfigIni:= TMemIniFile.Create(Arquivo);
  except on E : Exception do
    begin
      Application.MessageBox(PChar('Erro ao ler arquivo ' + Arquivo +'!'
        + sLineBreak + E.Message),PChar('Erro'), MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TBancoDadosDtMdl.CarregarTabelas;
{Carrega ramificação dos relacionamentos das tabelas por chave estrangeira.}
var
  iNode: IDOMNode;
  iNode1: IDOMNode;
  DOMDoc: IDOMDocument;
  Tabela: String;
  CampoData: String;
  CampoEmpresa: String;
  {Procedure interna para executar a recursão}
  procedure ProcessNode(Node: IDOMNode);
  var
    cNode: IDOMNode;
    Tabela: String;
    TabelaRel: String;
  begin
    if Node = nil then
      begin
        Exit; {Sai da recursão ao atingir último nó.}
      end;
    TabelaRel:= Node.nodeName;
    Application.ProcessMessages;
    StatusFrm.Status('Verificando relações entre as tabelas ' + Tabela
                      + ' e ' + TabelaRel + '...');
    RelacoesQry.Filtered:= false;
    RelacoesQry.Filter:= 'TABELA =' + QuotedStr(TabelaRel)
                          + ' AND TABELA_REL <>' + QuotedStr(TabelaRel);
    RelacoesQry.Filtered:= true;
    while not RelacoesQry.Eof do
      begin
        TabelaRel:= RelacoesQry.Fields[1].AsString;
        Node.appendChild(DOMDoc.createElement(TabelaRel));
        RelacoesQry.Next;
      end;
    cNode := Node.firstChild;
    while (cNode <> nil) do
      begin
        ProcessNode(cNode);
        cNode := cNode.nextSibling;
      end;
  end;
begin
  DOMDoc:= TabelasXML.DOMDocument;
  iNode:= DOMDoc.firstChild;
  iNode1:= nil;
  Tabela:= '';
  CampoData:= '';
  CampoEmpresa:= '';
  UtilizadasQry.Filter:= 'COUNT > 0';
  UtilizadasQry.Filtered:= True;
  while not UtilizadasQry.Eof do
    begin
      Tabela:= UtilizadasQry.Fields[0].AsString;
      CampoEmpresa:= UtilizadasQry.Fields[2].AsString;
      iNode1:= iNode.appendChild(DOMDoc.createElement(Tabela));
      if CampoEmpresa <> '' then
        begin
          iNode1.attributes.setNamedItem(DOMDoc.createAttribute(
            'CAMPO_EMPRESA')).nodeValue:= CampoEmpresa;
        end;
      CampoData:= ConfigIni.ReadString('Tabelas',Tabela+'.CAMPO_DATA','');
      if CampoData <> '' then
        begin
          iNode1.attributes.setNamedItem(DOMDoc.createAttribute(
            'CAMPO_DATA')).nodeValue:= CampoData;
        end;
      UtilizadasQry.Next;
    end;
  iNode:= iNode.firstChild;
    while (iNode <> nil) do
      begin
        ProcessNode(iNode); {Entra na recursão.}
        iNode := iNode.NextSibling;
      end;
  StatusFrm.Hide;
end;

procedure TBancoDadosDtMdl.AposConectar;
{Após conectar deve executar para carregar as consultas necessárias para execução
  do sistema e a procedure CarregarTabelas.}
begin
  try
    Application.ProcessMessages;
    StatusFrm.Status('Consultando chaves primárias...');
    PrimaryKeyQry.Open;
    PrimaryKeyQry.FetchAll;
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Consulta Chaves Primárias'
                            + sLineBreak + E.Message);
      end;
  end;
  try
    Application.ProcessMessages;
    StatusFrm.Status('Consultando tabela EMPRESAS...');
    EmpresasQry.Open;
    EmpresasQry.FetchAll;
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Consulta Empresas' + sLineBreak
                            + E.Message);
      end;
  end;
  try
    Application.ProcessMessages;
    StatusFrm.Status('Criando função COUNT_ROWS...');
    FDConnection.ExecSQL(SQL_COUNT_ROWS);
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CRIAR_FUNCAO, 'COUNT_ROWS' + sLineBreak
                            + E.Message);
      end;
  end;
  try
    Application.ProcessMessages;
    StatusFrm.Status('Consultando tabelas com dados...');
    UtilizadasQry.Open;
    UtilizadasQry.FetchAll;
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Tabelas Utilizadas' + sLineBreak
                            + E.Message);
      end;
  end;
  try
    Application.ProcessMessages;
    StatusFrm.Status('Criando função RETORNA_COLUNAS_FK...');
    FDConnection.ExecSQL(SQL_RETORNA_COLUNAS_FK);
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CRIAR_FUNCAO, 'RETORNA_COLUNAS_FK'+ sLineBreak
                            + E.Message);
      end;
  end;
  try
      Application.ProcessMessages;
      StatusFrm.Status('Consultando relações por chaves estrangeiras...');
      RelacoesQry.Open;
      RelacoesQry.FetchAll;
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Consulta Relações' + sLineBreak
                            + E.Message);
      end;
  end;
  try
    Application.ProcessMessages;
    StatusFrm.Status('Exportando chaves estrangeiras para memória...');
    DDLFKQry.Open;
    DDLFKQry.FetchAll;
  except
    on E : Exception do
      begin
        StatusFrm.Status(E.Message);
        MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Exportação Chaves Estrangeiras'
                            + sLineBreak + E.Message);
      end;
  end;
  CarregarTabelas;
end;
function TBancoDadosDtMdl.HabDesabTriggers(Valor: Boolean;
                                            Tabelas: TStringList): Boolean;
{Habilita/Desabilita triggers das tabelas informadas no parametro, retorna
  False em caso de erro e True no caso de sucesso.}
var
  ValorString: String;
  ValorString1: String;
  Sql: String;
  I: Integer;
begin
  if Valor then
    begin
      ValorString:= 'ENABLE';
      ValorString1:= 'Habilitando';
    end
  else
    begin
      ValorString:= 'DISABLE';
      ValorString1:= 'Desabilitando';
    end;
  for I := 0 to Tabelas.Count - 1 do
    begin
      try
        Application.ProcessMessages;
        StatusFrm.Status(ValorString1 + ' Triggers da tabela ' + Tabelas[I] + '...');
        Sql:= 'ALTER TABLE ' + Tabelas[I] + ' ' + ValorString + ' ALL TRIGGERS';
        FDConnection.ExecSQL(Sql);
      except
        on E : Exception do
          begin
            Result:= False;
            StatusFrm.Status(E.Message);
            MensagensFrm.MsgBox(ERRO_HAB_DESAB_TRIGGERS, 'Triggers da Tabela: ' +
                                Tabelas[I] + sLineBreak +
                                E.Message + sLineBreak + Sql);
            Exit;
          end;
      end;
    end;
  Result:= True;
end;
function TBancoDadosDtMdl.HabDesabChavesEstrangeiras(Valor: Boolean;
                                                Tabelas: TStringList): Boolean;
{Habilita/Desabilita chaves estrangeiras das tabelas informadas no parametro,
  retorna False em caso de erro e True no caso de sucesso.}
var
  ValorString: String;
  ValorString1: String;
  Sql: String;
  I: Integer;
begin
  if Valor then
    begin
      ValorString:= 'ENABLE';
      ValorString1:= 'Habilitando';
    end
  else
    begin
      ValorString:= 'DISABLE';
      ValorString1:= 'Desabilitando';
    end;
  for I := 0 to Tabelas.Count - 1 do
    begin
      try
        FKTabelaQry.Close;
        FKTabelaQry.ParamByName('TABELA').AsString:= Tabelas[I];
        FKTabelaQry.Open();
        FKTabelaQry.FetchAll;
        while not FKTabelaQry.Eof do
          begin
            Application.ProcessMessages;
            StatusFrm.Status(ValorString1 + ' chave estrangeira '
              + FKTabelaQry.Fields[0].AsString + ' da tabela ' + Tabelas[I] + '...');
            Sql:= 'ALTER TABLE ' + Tabelas[I] + ' ' + ValorString + ' CONSTRAINT '
                  + FKTabelaQry.Fields[0].AsString;
            try
              FDConnection.ExecSQL(Sql);
            except
              on E : Exception do
                begin
                  StatusFrm.Status(E.Message);
                  MensagensFrm.MsgBox(ERRO_HAB_DESAB_FK, 'Chave estrangeira '
                    + FKTabelaQry.Fields[0].AsString + ' da tabela '
                    + Tabelas[I] + sLineBreak + E.Message + sLineBreak + Sql);
                end;
            end;
            FKTabelaQry.Next;
          end;
      except
        on E : Exception do
          begin
            StatusFrm.Status(E.Message);
            MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Chaves estrangeiras da tabela '
              + Tabelas[I] + sLineBreak + E.Message + sLineBreak + Sql);
          end;
      end;
    end;
  Result:= True;

end;

function TBancoDadosDtMdl.HabDesabDeletarCascata(Valor: Boolean;
                                                Tabelas: TStringList): Boolean;
{Habilita/Desabilita chaves estrangeiras  para deletar em cascata das tabelas
  informadas no parametro, retorna False em caso de erro e True no caso de
  sucesso.}
var
  I: Integer;
  ValorStrCriando: String;
  ValorStrDeletando: String;
  Sql: String;
begin
  Result:= False;
  if Valor then
    begin
      ValorStrCriando:= ' ON DELETE CASCADE';
      ValorStrDeletando:=  '';
    end
  else
    begin
      ValorStrCriando:= '';
      ValorStrDeletando:=  ' ON DELETE CASCADE';
    end;
  for I := 0 to Tabelas.Count - 1 do
    begin
      DDLFKQry.Filtered:= False;
      DDLFKQry.Filter:= 'TABLE_NAME = ' + QuotedStr(Tabelas[I]);
      DDLFKQry.Filtered:= True;
      while not DDLFKQry.Eof do
        begin
          try
            Application.ProcessMessages;
            StatusFrm.Status('Deletando chave estrangeira' + ValorStrDeletando
              + ': ' + DDLFKQry.Fields[1].AsString + '...');
            Sql:= DDLFKQry.Fields[2].AsString;
            FDConnection.ExecSQL(Sql);
            try
              Application.ProcessMessages;
              StatusFrm.Status('Criando chave estrangeira' + ValorStrCriando
              + ': ' + DDLFKQry.Fields[1].AsString + '...');
              if Valor then
                begin
                  Sql:= DDLFKQry.Fields[3].AsString + ' ON DELETE CASCADE';
                end
              else
                begin
                  Sql:= DDLFKQry.Fields[3].AsString + DDLFKQry.Fields[4].AsString;
                end;
              FDConnection.ExecSQL(Sql);
            except
            on E : Exception do
              begin
                Result:= False;
                StatusFrm.Status(E.Message);
                MensagensFrm.MsgBox(ERRO_ALTERAR_FK, 'Criar chave estrangeira'
                  + ValorStrCriando + ': ' + DDLFKQry.Fields[1].AsString
                  + sLineBreak + E.Message + sLineBreak + Sql);
                Exit;
              end;
            end;
          except
            on E : Exception do
              begin
                Result:= False;
                StatusFrm.Status(E.Message);
                MensagensFrm.MsgBox(ERRO_ALTERAR_FK, 'Deletar chave estrangeira'
                 + ValorStrDeletando + ': ' + DDLFKQry.Fields[1].AsString
                 + sLineBreak + E.Message + sLineBreak + Sql);
                Exit;
              end;
          end;
          DDLFKQry.Next;
        end;
        Result:= True;
    end;
end;
procedure TBancoDadosDtMdl.DeletarDados(Selecoes: TStringList);
{Deleta os dados conforme as seleções informadas no parametro.}
var
  I: Integer;
  Tabelas: TStringList;
  Tabela: String;
  Selecao: String;
  Sql: String;
begin
  Tabelas:= TStringList.Create;
  Tabelas.Sorted:= True;
  Tabelas.Duplicates:= dupIgnore;
  for I := 0 to Selecoes.Count - 1 do
    begin
      Tabelas.AddStrings(RetornaTabRelacionadas(Selecoes.Names[I]));
    end;
  if not HabDesabDeletarCascata(True, Tabelas) then
    begin
      StatusFrm.Hide;
      MensagensFrm.MsgBox(ERRO_ALTERAR_FK, PROCESSO_ABORTADO);
      Exit;
    end;
  if not HabDesabTriggers(False, Tabelas) then
    begin
      StatusFrm.Hide;
      MensagensFrm.MsgBox(ERRO_HAB_DESAB_TRIGGERS, PROCESSO_ABORTADO);
      Exit;
    end;
  for I := 0 to Selecoes.Count - 1 do
    begin
      Tabela:= Selecoes.Names[I];
      Selecao:= Selecoes.ValueFromIndex[I];
      Application.ProcessMessages;
      StatusFrm.Status('Deletando dados da tabela ' + Tabela + ' e dados'
        + ' relacionados...');
      Sql:= 'DELETE FROM ' + Tabela + ' WHERE (' + RetornaPrimaryKey(Tabela)
        + ') IN(' + Selecao + ')';
      try
        FDConnection.ExecSQL(Sql);
      except
        on E : Exception do
          begin
            StatusFrm.Status(E.Message);
            MensagensFrm.MsgBox(ERRO_DELETAR_REGISTROS, E.Message + sLineBreak
            + Sql);
          end;
      end;
    end;
  if not HabDesabDeletarCascata(False, Tabelas) then
    begin
      StatusFrm.Hide;
      MensagensFrm.MsgBox(ERRO_ALTERAR_FK, PROCESSO_ABORTADO);
      Exit;
    end;
  if not HabDesabTriggers(True, Tabelas) then
    begin
      StatusFrm.Hide;
      MensagensFrm.MsgBox(ERRO_HAB_DESAB_TRIGGERS, PROCESSO_ABORTADO);
      Exit;
    end;
  MensagensFrm.MsgBox(INF_PROC_CONCLUIDO, 'Exclusão de dados.' + sLineBreak +
                      'Caso tenha dúvidas verifique o status do processo.');
  StatusFrm.Hide;
end;
function TBancoDadosDtMdl.GetConfigIni: TMemIniFile;
{Retorna ConfigIni}
begin
  Result:= ConfigIni;
end;

function TBancoDadosDtMdl.GetTabUtilizadas: Integer;
{Retorna quantidade de tabelas utilizadas.}
begin
  Result:= UtilizadasQry.RecordCount;
end;

end.
