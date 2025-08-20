unit LimpaBaseUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, xmldom, DB,
  MensagensUnt, Menus, TabelaUnt, ExtDlgs, CustomizeDlg, Math, ShellAPI;

type
  TLimpaBaseFrm = class(TForm)
    TabelasPgCtrl: TPageControl;
    EmpresaLbl: TLabel;
    DataInicialMskEdt: TMaskEdit;
    DataFinalMskEdt: TMaskEdit;
    DataInicialLbl: TLabel;
    DataFinalLbl: TLabel;
    EmpresaLkpCmbx: TDBLookupComboBox;
    TopBvl: TBevel;
    ExecutarBtn: TBitBtn;
    EmpresasDtSrc: TDataSource;
    MenuMn: TMainMenu;
    ArquivoMnItm: TMenuItem;
    SalvarStatusMnItm: TMenuItem;
    SalvarHistoricoMsgMnItm: TMenuItem;
    ExibirMnItm: TMenuItem;
    StatusProcessoMnItm: TMenuItem;
    HistoricoMsgMnItm: TMenuItem;
    AjudaMnItm: TMenuItem;
    SalvarSelecoesMnItm: TMenuItem;
    CarregarSelecoesMnItm: TMenuItem;
    SelecoesMnItm: TMenuItem;
    LimparSelecoesMnItm: TMenuItem;
    AbrirSelecoesDlg: TOpenDialog;
    BarraSts: TStatusBar;
    BuscarTabelaMnItm: TMenuItem;
    SequenciaisMnItm: TMenuItem;
    TrocaEmpresaMnItm: TMenuItem;
    ManualMnItm: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ExecutarBtnClick(Sender: TObject);
    procedure DataInicialMskEdtExit(Sender: TObject);
    procedure DataFinalMskEdtExit(Sender: TObject);
    procedure DataInicialMskEdtEnter(Sender: TObject);
    procedure DataFinalMskEdtEnter(Sender: TObject);
    procedure StatusProcessoMnItmClick(Sender: TObject);
    procedure SalvarStatusMnItmClick(Sender: TObject);
    procedure HistoricoMsgMnItmClick(Sender: TObject);
    procedure SalvarHistoricoMsgMnItmClick(Sender: TObject);
    procedure SalvarSelecoesMnItmClick(Sender: TObject);
    procedure CarregarSelecoesMnItmClick(Sender: TObject);
    procedure SelecoesMnItmClick(Sender: TObject);
    procedure LimparSelecoesMnItmClick(Sender: TObject);
    procedure BuscarTabelaMnItmClick(Sender: TObject);
    procedure SequenciaisMnItmClick(Sender: TObject);
    procedure TrocaEmpresaMnItmClick(Sender: TObject);
    procedure ManualMnItmClick(Sender: TObject);
  private
    { Private declarations }
    Selecoes: TStringList;
    TabelasFrm: array of TTabelaFrm;
    PaginasTbSt: array of TTabSheet;
    function ValidaPeriodoMskEdt(DataInicial: String; DataFinal: String):Boolean;
    function ValidarDataMskEdt(Data: String): Boolean;
    procedure AppMessage(var Msg: TMSG; var HAndled: Boolean);
    procedure CarregarSelecoes;
    function LimparSelecoes: Boolean;
  public
    { Public declarations }
    procedure CriarPaginas;
    procedure SetSelecoes(Tabela: String; Select: String; Selecionado: Boolean);
    function GerarSelecaoPadrao(Tabela: String; PrimaryKey: String;
                                CampoEmpresa: String; CampoData: String): String;
    function ToDateOracle(Data: String): String;
    function ValidarSelecao(Tabela: String; PrimaryKey: String;
                            Selecao: String): Integer;
    procedure SetBarraSts(const PanelIndex: Integer; const Texto: String);
  end;

const
  DATA_NULA_MSK_EDT = '  /  /    ';
  MSG_VALIDA_PERIODO = 'Data inicial deve ser menor ou igual a data final!';

var
  LimpaBaseFrm: TLimpaBaseFrm;

implementation
uses
  LoginUnt, BancoDadosUnt, StatusUnt, SelecoesUnt, ConectadosUnt,
  LocalizarTabelaUnt, SequenciaisUnt, TrocaEmpresaUnt;
{$R *.dfm}

procedure TLimpaBaseFrm.DataFinalMskEdtEnter(Sender: TObject);
{Seleciona todo texto ao entrar no campo.}
begin
  DataFinalMskEdt.SelectAll;
end;

procedure TLimpaBaseFrm.DataFinalMskEdtExit(Sender: TObject);
{Valida data e período ao sair do campo.}
begin
  if not ValidarDataMskEdt(DataFinalMskEdt.Text) then
    begin
      DataFinalMskEdt.SetFocus;
    end
  else
    begin
      if not ValidaPeriodoMskEdt(DataInicialMskEdt.Text,
                                  DataFinalMskEdt.Text) then
        begin
          DataFinalMskEdt.SetFocus;
        end;
    end;
end;

procedure TLimpaBaseFrm.DataInicialMskEdtEnter(Sender: TObject);
{Seleciona todo texto ao entrar no campo.}
begin
  DataInicialMskEdt.SelectAll;
end;

procedure TLimpaBaseFrm.DataInicialMskEdtExit(Sender: TObject);
{Valida data e período ao sair do campo.}
begin
  if not ValidarDataMskEdt(DataInicialMskEdt.Text) then
    begin
      DataInicialMskEdt.SetFocus;
    end
  else
    begin
      if not ValidaPeriodoMskEdt(DataInicialMskEdt.Text,
                                 DataFinalMskEdt.Text) then
        begin
          DataInicialMskEdt.SetFocus;
        end;
    end;
end;

procedure TLimpaBaseFrm.ExecutarBtnClick(Sender: TObject);
{Verifica se tem usuários conectados e deleta os dados.}
var
  ConectadosFrm: TConectadosFrm;
begin
  ConectadosFrm:= TConectadosFrm.Create(Application);
  if BancoDadosDtMdl.UsuariosConectados then
    begin
      ConectadosFrm.ShowModal;
    end
  else
    begin
      ConectadosFrm.SetConfirmado(True);
    end;
  if ConectadosFrm.GetConfirmado then
    begin
      if MensagensFrm.MsgBox(QUESTAO_DELETAR_REGISTROS,'') = ID_YES then
      begin
        BancoDadosDtMdl.DeletarDados(Selecoes);
      end;
    end;
  ConectadosFrm.FreeOnRelease;
end;

procedure TLimpaBaseFrm.FormCreate(Sender: TObject);
{Ao criar atribui AppMessage e cria Selecoes.}
begin
  Application.OnMessage := AppMessage;
  Selecoes:= TStringList.Create;
end;

procedure TLimpaBaseFrm.BuscarTabelaMnItmClick(Sender: TObject);
{Chama LocalizarTabelaFrm para apresentação modal.}
begin
  if Visible then
    begin
      LocalizarTabelaFrm.ShowModal;
    end;
end;

procedure TLimpaBaseFrm.CarregarSelecoes;
{Carrega arquivo com nome das tabelas para serem selecionadas para exclusão.}
var
  I: Integer;
  SelecoesIni: TStringList;
begin
  if AbrirSelecoesDlg.Execute then
    begin
      LimparSelecoes;
      SelecoesIni:= TStringList.Create;
      SelecoesIni.LoadFromFile(AbrirSelecoesDlg.Files[0]);
      for I := 0 to Length(TabelasFrm) - 1 do
        begin
          if SelecoesIni.IndexOf(TabelasFrm[I].GetNomeTabela) > -1 then
            begin
              TabelasFrm[I].SelecionarSpdBtn.Down:=True;
              TabelasFrm[I].SelecionarSpdBtnClick(Self);
            end;
        end;
      SelecoesFrm.ShowModal;
    end;
end;

procedure TLimpaBaseFrm.CarregarSelecoesMnItmClick(Sender: TObject);
{Executa CarregarSelecoes.}
begin
 CarregarSelecoes;
end;

procedure TLimpaBaseFrm.CriarPaginas();
{Cria os componentes TabelaFrm e TabSheet de acordo com TabelasXML do módulo
  BancoDadosDtMdl, incluindo-os no componente TabelasPgCrl.}
var
  ConfigTabelas: IDOMNodeList;
  ConfigTabelasCount: Integer;
  ConfigTabelaNode: IDOMNode;
  AttrTabSheetCaption: IDOMNode;
  AttrTabSheetHint: IDOMNode;
  I: Integer;
  I1: Integer;
  Tabela: String;
  RelacoesCount: TStringList;
  RelacoesMax: Integer;
begin
  ConfigTabelas:= BancoDadosDtMdl.RetornaTabelas;
  ConfigTabelasCount:= ConfigTabelas.length;
  ConfigTabelaNode:= nil;
  AttrTabSheetCaption:= nil;
  AttrTabSheetHint:= nil;
  Tabela:= '';
  SetLength(TabelasFrm, ConfigTabelasCount);
  SetLength(PaginasTbSt, ConfigTabelasCount);
  RelacoesMax:= 0;
  RelacoesCount:= TStringList.Create;
  for I := 0 to ConfigTabelasCount - 1 do
    begin
      TabelasFrm[I]:= TTabelaFrm.Create(Self);
      PaginasTbSt[I]:= TTabSheet.Create(Self);
      ConfigTabelaNode:= ConfigTabelas.item[I];
      Tabela:= ConfigTabelaNode.nodeName;
      TabelasFrm[I].Name:= Tabela+'Frm';
      TabelasFrm[I].SetNomeTabela(Tabela);
      TabelasFrm[I].SetPrimaryKey(BancoDadosDtMdl.RetornaPrimaryKey(Tabela));
      TabelasFrm[I].CarregarRelacoesTrVw(ConfigTabelas.item[I]);
      if TabelasFrm[I].RelacoesCount > RelacoesMax then
          begin
            RelacoesMax:= TabelasFrm[I].RelacoesCount;
          end;
      PaginasTbSt[I].Name:= Tabela+'TbSt';
      PaginasTbSt[I].Caption:= Tabela;
      AttrTabSheetCaption:= ConfigTabelaNode.attributes.getNamedItem('CAMPO_EMPRESA');
      if AttrTabSheetCaption <> nil then
        begin
          TabelasFrm[I].SetCampoEmpresa(AttrTabSheetCaption.firstChild.nodeValue);
        end;
      AttrTabSheetCaption:= ConfigTabelaNode.attributes.getNamedItem('CAMPO_DATA');
      if AttrTabSheetCaption <> nil then
        begin
          TabelasFrm[I].SetCampoData(AttrTabSheetCaption.firstChild.nodeValue);
        end;
      Tabela:= '';
    end;
    for I := 0 to ConfigTabelasCount - 1 do
      begin
        RelacoesCount.Add(Format('%.'+inttostr(RelacoesMax.Size-1)+'d',
                                  [TabelasFrm[I].RelacoesCount])
                          + '=' + TabelasFrm[I].GetNomeTabela);
      end;
    RelacoesCount.Sort;
    for I := 0 to Length(TabelasFrm) - 1 do
      begin
        TabelasFrm[I].Parent:= PaginasTbSt[I];
      end;
    for I := RelacoesCount.Count - 1 downto 0 do
      begin
        for I1 := 0 to Length(PaginasTbSt) - 1 do
          begin
            if RelacoesCount.ValueFromIndex[I] = PaginasTbSt[I1].Caption then
              begin
                PaginasTbSt[I1].PageControl:= TabelasPgCtrl;
                LocalizarTabelaFrm.AddTabela(PaginasTbSt[I1].Caption);
              end;
          end;
      end;
end;

procedure TLimpaBaseFrm.SalvarHistoricoMsgMnItmClick(Sender: TObject);
{Executa MensagensFrm.Salvar.}
begin
  MensagensFrm.Salvar;
end;

procedure TLimpaBaseFrm.SalvarSelecoesMnItmClick(Sender: TObject);
{Executa SelecoesFrm.Salvar.}
begin
  SelecoesFrm.Salvar;
end;

procedure TLimpaBaseFrm.SalvarStatusMnItmClick(Sender: TObject);
{Executa StatusFrm.Salvar.}
begin
  StatusFrm.Salvar;
end;

procedure TLimpaBaseFrm.SelecoesMnItmClick(Sender: TObject);
{Chama SelecoesFrm para apresentação modal.}
begin
  SelecoesFrm.ShowModal;
end;

procedure TLimpaBaseFrm.SequenciaisMnItmClick(Sender: TObject);
{Chama SequenciaisFrm para apresentação modal.}
var
  SequenciaisFrm: TSequenciaisFrm;
begin
  if Visible then
    begin
      SequenciaisFrm:= TSequenciaisFrm.Create(Self);
      SequenciaisFrm.ShowModal;
    end;
end;

procedure TLimpaBaseFrm.SetBarraSts(const PanelIndex: Integer;
  const Texto: String);
{Atribui texto na BarraSts.}
begin
  BarraSts.Panels[PanelIndex].Text:= Texto;
end;

procedure TLimpaBaseFrm.SetSelecoes(Tabela: string; Select: String;
                                    Selecionado: Boolean);
{Inclui ou exclui valor na StringList Selecoes e bloqueia os campos
  EmpresaLkpCmbx, DataInicialMskEdt e DataFinalMskEdt caso tenha algum valor
  na lista.}
var
  I: Integer;
  TabelaFrm: TTabelaFrm;
  PaginaTbSt: TTabSheet;
  Relacionadas: TStringList;
  PagRelTbSt: TTabSheet;
  I1: Integer;
  TabIndex: Integer;
begin
  TabelaFrm:= nil;
  PaginaTbSt:= nil;
  TabIndex:= 0;
  Relacionadas:= TStringList.Create;
  Relacionadas.Sorted:= True;
  Relacionadas.Duplicates:= dupIgnore;
  for I := 0 to Length(TabelasFrm) - 1 do
    begin
      if TabelasFrm[I].GetNomeTabela = Tabela then
        begin
          TabelaFrm:= TabelasFrm[I];
          PaginaTbSt:= TTabSheet(TabelaFrm.Parent);
          TabIndex:= PaginaTbSt.TabIndex;
        end;
    end;
  for I := 0 to TabelaFrm.RelacoesTrVw.Items.Count - 1 do
    begin
      Relacionadas.Add(TabelaFrm.RelacoesTrVw.Items[I].Text);
    end;
  I:= Selecoes.IndexOfName(Tabela);
  if I > -1 then
    begin
      Selecoes.Delete(I);
      SelecoesFrm.SelecoesMmo.Lines.Delete(I);
      PaginaTbSt.Highlighted:= False;
      LocalizarTabelaFrm.MarcarDesmarcarTabela(PaginaTbSt.Caption,False,
                                                '*',TabIndex);
      for I := 0 to Relacionadas.Count - 1 do
        begin
             for I1 := 0 to Length(TabelasFrm) - 1 do
              begin
                if (TabelasFrm[I1].GetNomeTabela = Relacionadas[I])
                    and (TabelasFrm[I1].GetNomeTabela <> Tabela) then
                  begin
                    TabelaFrm:= TabelasFrm[I1];
                    PagRelTbSt:= TTabSheet(TabelaFrm.Parent);
                    TabelaFrm.SetReferenciasCasc(Tabela, False);
                    if TabelaFrm.GetReferenciasCasc.Count = 0 then
                      begin
                        if PagRelTbSt.Highlighted then
                          begin
                            LocalizarTabelaFrm.MarcarDesmarcarTabela(Relacionadas[I],
                                                True,'*',PagRelTbSt.TabIndex);
                          end
                        else
                          begin
                            LocalizarTabelaFrm.MarcarDesmarcarTabela(Relacionadas[I],
                                                False,'**',PagRelTbSt.TabIndex);
                          end;
                      end;
                  end;
              end;
        end;
    end
  else
    begin
      if Selecionado then
        begin
          Selecoes.Values[Tabela]:=Select;
          SelecoesFrm.SelecoesMmo.Lines.Add(Tabela);
          PaginaTbSt.Highlighted:= True;
          LocalizarTabelaFrm.MarcarDesmarcarTabela(PaginaTbSt.Caption,True,
          '*',TabIndex);
          for I := 0 to Relacionadas.Count - 1 do
            begin
             for I1 := 0 to Length(TabelasFrm) - 1 do
              begin
                if (TabelasFrm[I1].GetNomeTabela = Relacionadas[I])
                    and (TabelasFrm[I1].GetNomeTabela <> Tabela) then
                  begin
                    TabelaFrm:= TabelasFrm[I1];
                    PagRelTbSt:= TTabSheet(TabelaFrm.Parent);
                    TabelaFrm.SetReferenciasCasc(Tabela, True);
                    LocalizarTabelaFrm.MarcarDesmarcarTabela(Relacionadas[I]
                                                ,True,'**',PagRelTbSt.TabIndex);
                  end;
              end;
            end;
        end;
    end;
  EmpresaLkpCmbx.Enabled:= Selecoes.Count = 0;
  DataInicialMskEdt.Enabled:= Selecoes.Count = 0;
  DataFinalMskEdt.Enabled:= Selecoes.Count = 0;
end;

procedure TLimpaBaseFrm.StatusProcessoMnItmClick(Sender: TObject);
{Executa StatusFrm.Visualizar.}
begin
  StatusFrm.Visualizar;

end;

function TLimpaBaseFrm.ValidarDataMskEdt(Data: string): Boolean;
{Valida data utlizando StrToDate retornando verdadeiro caso conversão ocorra ou
  caso o valor seja DATA_NULA_MSK_EDT, retorna falso para erro na conversão.}
begin
  try
    if Data <> DATA_NULA_MSK_EDT then
      begin
        StrToDate (Data);
        result := true;
      end
    else
      begin
        result:= true;
      end;
  except
    on E : Exception do
    begin
      MensagensFrm.MsgBox(ERRO_VALIDAR_DATA, E.Message);
      result := false;
    end;
  end;
end;

function TLimpaBaseFrm.ValidaPeriodoMskEdt(DataInicial: string;
                                            DataFinal: string): Boolean;
{Valida período retornando verdadeiro se um ou os dois parametros forem igual a
DATA_NULA_MSK_EDT e caso ValorInicial seja menor ou igual a ValorFinal, retorna
falso para os demais casos.}
var
  ValorInicial: TDate;
  ValorFinal: TDate;
begin
  ValorInicial:= 0;
  ValorFinal:= 0;
  if (DataInicial = DATA_NULA_MSK_EDT) or (DataFinal = DATA_NULA_MSK_EDT)  then
    begin
      result:= True;
    end
  else
    begin
      if DataInicial <> DATA_NULA_MSK_EDT then
        begin
          ValorInicial:= StrToDate(DataInicial);
        end;
      if DataFinal <> DATA_NULA_MSK_EDT then
        begin
          ValorFinal:= StrToDate(DataFinal);
        end;
      result:= ValorInicial <= ValorFinal;
    end;
  if not Result then
    begin
      MensagensFrm.MsgBox(ERRO_VALIDAR_PERIODO, MSG_VALIDA_PERIODO);
    end;
end;

function TLimpaBaseFrm.GerarSelecaoPadrao(Tabela: String; PrimaryKey: String;
                                CampoEmpresa: String; CampoData: String): String;
{Retorna string com SELECT preenchido respeitando os parametros e filtros
informados EmpresaLkpCmbx, DataInicialMskEdt e DataFinalMskEdt.}
begin
  Result:= 'SELECT ' + PrimaryKey + ' FROM ' + Tabela;
  if (CampoEmpresa <> '') and (EmpresaLkpCmbx.KeyValue <> null) then
    begin
      Result:= Result + ' WHERE ' + CampoEmpresa + ' = '
                + QuotedStr(EmpresaLkpCmbx.KeyValue);
    end;
  if (CampoData <> '') and ((DataInicialMskEdt.Text <> DATA_NULA_MSK_EDT) or
                            (DataFinalMskEdt.Text <> DATA_NULA_MSK_EDT)) then
    begin
      if  Length(StrPos(PChar(Result), PChar('WHERE'))) = 0 then
        begin
          Result:= Result + ' WHERE ';
        end
      else
        begin
          Result:= Result + ' AND ';
        end;
      Result:= Result + CampoData;
      if (DataInicialMskEdt.Text <> DATA_NULA_MSK_EDT) and
                            (DataFinalMskEdt.Text <> DATA_NULA_MSK_EDT) then
        begin
          Result:= Result + ' BETWEEN ' + ToDateOracle(DataInicialMskEdt.Text)
                    + ' AND ' + ToDateOracle(DataFinalMskEdt.Text);
        end
      else
        begin
          if DataInicialMskEdt.Text <> DATA_NULA_MSK_EDT then
            begin
              Result:= Result + ' >= ' + ToDateOracle(DataInicialMskEdt.Text);
            end
          else
            begin
              Result:= Result + ' <= ' + ToDateOracle(DataFinalMskEdt.Text);
            end;
        end;
    end;
end;

procedure TLimpaBaseFrm.HistoricoMsgMnItmClick(Sender: TObject);
{Chama MensagensFrm para apresentação modal.}
begin
  MensagensFrm.ShowModal;
end;

function TLimpaBaseFrm.LimparSelecoes: Boolean;
var
  I: Integer;
begin
  if MensagensFrm.MsgBox(QUESTAO_LIMPAR_SELECOES, 'Seleções personalinadas'
                            + ' serão perdidas!') = ID_YES then
    begin
      for I := 0 to Length(TabelasFrm) - 1 do
        begin
          TabelasFrm[I].SelecionarSpdBtn.Down:=False;
          TabelasFrm[I].SelecionarSpdBtnClick(Self);
        end;
      EmpresaLkpCmbx.KeyValue:= null;
      DataInicialMskEdt.Clear;
      DataFinalMskEdt.Clear;
      Result:= True;
    end
  else
    begin
      Result:= False;
    end;
end;

procedure TLimpaBaseFrm.LimparSelecoesMnItmClick(Sender: TObject);
{Executa LimparSelecoes.}
begin
  LimparSelecoes;
end;

procedure TLimpaBaseFrm.ManualMnItmClick(Sender: TObject);
var
  RStream: TResourceStream;
  Arquivo: String;
begin
  Arquivo:= Application.ExeName.Replace('.exe','.pdf');
  if not FileExists(Arquivo) then
    begin
      RStream := TResourceStream.Create(HInstance, 'LimpaBaseRscPdf', RT_RCDATA);
        try
          RStream.SaveToFile(Arquivo);
        except on E : Exception do
          begin
            MensagensFrm.MsgBox(ERRO_SALVAR_ARQUIVO, Arquivo);
          end;
        end;
      RStream.Free;
    end;
  ShellExecute(Handle, nil, Pchar(Arquivo), nil, nil, SW_SHOWNORMAL);
end;

function TLimpaBaseFrm.ToDateOracle(Data: String): String;
{Retorna string com função do oracle preenchida conforme parametro.
Formato: DD/MM/YYYY}
  begin
    Result:= 'TO_DATE(' + QuotedStr(Data) + ','
                    + QuotedStr('DD/MM/YYYY') + ')';
  end;

procedure TLimpaBaseFrm.TrocaEmpresaMnItmClick(Sender: TObject);
var
  TrocaEmpresaFrm: TTrocaEmpresaFrm;
  Confirma: Boolean;
begin
  if Visible then
    begin
  if Selecoes.Count > 0 then
    begin
      if MensagensFrm.MsgBox(ATENCAO_QUESTAO_DIVERSA, 'Para acessar o Troca'
                            + ' Empresa é necessário limpar as seleções,'
                            + ' deseja continuar?') = ID_YES then
        begin
          Confirma:= LimparSelecoes;
        end
      else
        begin
          Confirma:= False;
        end;
    end
  else
    begin
      Confirma:= True;
    end;
  if Confirma then
    begin
      TrocaEmpresaFrm:= TTrocaEmpresaFrm.Create(Self);
      TrocaEmpresaFrm.ShowModal;
    end;
  end;
end;

function TLimpaBaseFrm.ValidarSelecao(Tabela: String; PrimaryKey: String;
                                      Selecao: String): Integer;
{Valida seleção de registros retornando a quantidade de registros
  selecionados ou -1 em caso de erro}
begin
  BancoDadosDtMdl.SelecaoQry.Close;
  BancoDadosDtMdl.SelecaoQry.SQL.Text:= 'SELECT ' + PrimaryKey + ' FROM '
   + Tabela + ' WHERE (' + PrimaryKey + ') IN(' + Selecao + ')';
  try
    BancoDadosDtMdl.SelecaoQry.Open;
    BancoDadosDtMdl.SelecaoQry.FetchAll;
    Result:= BancoDadosDtMdl.SelecaoQry.RecordCount;
  except
    on E : Exception do
      begin
        Result:= -1;
        MensagensFrm.MsgBox(ERRO_VALIDAR_SELECAO, E.Message + sLineBreak
                            + Selecao);
      end;
  end;
end;
procedure TLimpaBaseFrm.AppMessage(var Msg: TMSG; var HAndled: Boolean);
{Pede confirmação para ALT+F4 e termina a aplicação.}
begin
  Handled := False;
  case Msg.Message of
    WM_SYSKEYDOWN:
      begin
      if Msg.wParam = VK_F4 then
        begin
          Handled := MensagensFrm.MsgBox(ATENCAO_ALT_F4, '') = ID_NO;
          if not HAndled then
            begin
              Application.Terminate;
            end;
        end;
      end;
  end;
end;

end.
