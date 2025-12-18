unit Classe.LimparMovimento;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.StrUtils,
  Vcl.Dialogs, Data.DB, DBAccess, Ora, MemDS,
  classe.BancoDados, uDataModule, Classe.ProgressHelper, Vcl.Controls,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.StdCtrls;

type
  TClasseLimparMovimento = class
  private
    //  Acesso ao banco
    FConsulta: TClasseBancoDados;
    FQueryTela: TOraQuery;
    FDataSourceTela: TOraDataSource;

    FDataSourceProtegidas: TDataSource;
    FClientDataSetProtegidas: TClientDataSet;
    FListaProtegidasPersonalizadas: TStringList;

    //  Listas internas
    FListaProtegidas: TStringList;
    FListaTodasTabelas: TStringList;
    FListaDeletaveis: TStringList;

    //  Variáveis coesas (para rastreio)
    FSQLTodasTabelas: string;
    FSQLProtegidas: string;

    //  Métodos internos
    procedure GerarListaTabelasProtegidas;
    procedure CarregarTodasTabelasBanco;
    procedure GerarListaTabelasDeletaveis;
    function  GerarSQLContagemTabelas: string;

  public
    constructor Create;
    destructor Destroy; override;

    //  Métodos principais
    procedure ExecutarAnaliseTabelas;
    procedure TruncarTabelasDeletaveis(ADBGrid: TDBGrid);
    procedure CarregarTabelasComDados(ADBGrid: TDBGrid);
    procedure CarregarListaProtegidas(ADBGrid: TDBGrid);
    procedure AtualizarResumoLabels(ALabelProtegidas, ALabelDeletadas: TLabel);
    procedure AdicionarTabelasProtegidasPersonalizadas(const Tabelas: TStringList);

    //  Acesso externo às listas
    function GetListaProtegidas: TStringList;
    function GetListaTodas: TStringList;
    function GetListaDeletaveis: TStringList;
    function GetListaProtegidasPersonalizadas: TStringList;

    procedure FecharQuery();
  end;

implementation

uses
  Vcl.Forms, uViewMain;

{ ===========================================================
  CONSTRUTOR / DESTRUTOR
  =========================================================== }
constructor TClasseLimparMovimento.Create;
begin
  inherited;

  // 🔹 Inicializa listas
  FListaProtegidas := TStringList.Create;
  FListaTodasTabelas := TStringList.Create;
  FListaDeletaveis := TStringList.Create;
  FListaProtegidasPersonalizadas := TStringList.Create;

  // 🔹 Inicializa os datasets como nil
  FClientDataSetProtegidas := nil;
  FDataSourceProtegidas := nil;

  // 🔹 Cria conexão ao banco apenas se disponível
  if Assigned(DmModule) and Assigned(DmModule.orsConexao)
     and DmModule.orsConexao.Connected then
    FConsulta := TClasseBancoDados.Create(DmModule.orsConexao)
  else
    FConsulta := nil;
end;

destructor TClasseLimparMovimento.Destroy;
begin
  FreeAndNil(FClientDataSetProtegidas);
  FreeAndNil(FDataSourceProtegidas);
  FreeAndNil(FListaProtegidas);
  FreeAndNil(FListaTodasTabelas);
  FreeAndNil(FListaDeletaveis);
  FreeAndNil(FListaProtegidasPersonalizadas);
  FreeAndNil(FConsulta);
  inherited;
end;

{ ===========================================================
  1. Gera lista de tabelas protegidas (não podem ser truncadas)
  =========================================================== }
procedure TClasseLimparMovimento.GerarListaTabelasProtegidas;
begin
  FListaProtegidas.Clear;

  // 🔹 Lista base — Tabelas essenciais fixas do sistema
  FListaProtegidas.Add('PARAMETROS');                   FListaProtegidas.Add('PARAMETROS1');
  FListaProtegidas.Add('PARAMETROS2');                  FListaProtegidas.Add('PARAMETROS3');
  FListaProtegidas.Add('PARAMETROS_ECOMMERCE');         FListaProtegidas.Add('EMPRESAS');
  FListaProtegidas.Add('EMPRESA_PADRAO');               FListaProtegidas.Add('SIAC_CFO');
  FListaProtegidas.Add('SIAC_CFO_EMPRESA');             FListaProtegidas.Add('SIAI_PROD_TERC_RELACIONA');
  FListaProtegidas.Add('SIAI_RELACIONA_DECOMPOSICAO');  FListaProtegidas.Add('SIAI_RELACIONAMENTO_ITENS');
  FListaProtegidas.Add('SIAI_RELACIONAMENTO_PRODUTO');  FListaProtegidas.Add('RELACIONA_CLIENTE_AVALISTA');
  FListaProtegidas.Add('RELACIONAMENTO_NIVEIS');        FListaProtegidas.Add('RELACIONAMENTOS');
  FListaProtegidas.Add('RELACIONAMENTOS_APLICACAO');    FListaProtegidas.Add('RELACIONAMENTOS_UTILIZACAO');
  FListaProtegidas.Add('ACESSO_EMPRESA');               FListaProtegidas.Add('REL_CONFIGURACOES');
  FListaProtegidas.Add('SIAC_CONFIG_BLOQUEIO');         FListaProtegidas.Add('RELACIONAMENTO_NIVEIS');
  FListaProtegidas.Add('AUTORIZACAO_RELACAO_VENDAS');   FListaProtegidas.Add('AUTORIZACAO');
  FListaProtegidas.Add('SIAC_LOG_SENHAS');              FListaProtegidas.Add('PRODUTOS');
  FListaProtegidas.Add('PRODUTOS_EMPRESAS');            FListaProtegidas.Add('UNIDADES');
  FListaProtegidas.Add('CODIGO_BARRAS');                FListaProtegidas.Add('CODIGOS_FISCAIS');
  FListaProtegidas.Add('CODIGOS_CEST');                 FListaProtegidas.Add('FATORES_CONVERSAO');
  FListaProtegidas.Add('GRUPOS');                       FListaProtegidas.Add('LINHAS');
  FListaProtegidas.Add('MARCAS');                       FListaProtegidas.Add('PRODUTOS_FAMILIAS');
  FListaProtegidas.Add('CAPA_KITS ');                   FListaProtegidas.Add('ITENS_KITS ');
  FListaProtegidas.Add('CARACTERISTICAS_PRODUTO');      FListaProtegidas.Add('SIMILARES');
  FListaProtegidas.Add('CLASSIFICACAO_PRODUTOS');       FListaProtegidas.Add('TABELA_PRECOS');
  FListaProtegidas.Add('SIAC_PRODUTOS_FORNECEDORES');   FListaProtegidas.Add('IMAGENS_PRODUTOS');
  FListaProtegidas.Add('ENDERECO_ESTOQUE_EMPRESA');     FListaProtegidas.Add('CODIGO_ORIGINAIS');
  FListaProtegidas.Add('CORES');                        FListaProtegidas.Add('FATORES_CONVERSAO_GRADES');
  FListaProtegidas.Add('ITENS_GRADE');                  FListaProtegidas.Add('CAPA_GRADE');
  FListaProtegidas.Add('CARACTERISTICAS_GRADE');        FListaProtegidas.Add('ESTOQUES');
  FListaProtegidas.Add('LOTE_PRODUTO');                 FListaProtegidas.Add('ESTOQUES_LOTE');
  FListaProtegidas.Add('SERIAIS');                      FListaProtegidas.Add('ESTOQUES_SERIAL');
  FListaProtegidas.Add('GRUPO_IBSCBS');                 FListaProtegidas.Add('ITENS_GRUPO_IBSCBS');
  FListaProtegidas.Add('GRUPO_ICMS');                   FListaProtegidas.Add('ITENS_GRUPO_ICMS');
  FListaProtegidas.Add('GRUPO_IPI');                    FListaProtegidas.Add('ITENS_GRUPO_IPI');
  FListaProtegidas.Add('GRUPO_IS');                     FListaProtegidas.Add('ITENS_GRUPO_IS');
  FListaProtegidas.Add('GRUPO_ISSQN');                  FListaProtegidas.Add('ITENS_GRUPO_ISSQN');
  FListaProtegidas.Add('NEW_GRUPO_PISCOFINS');          FListaProtegidas.Add('NEW_ITENS_GRUPO_PISCOFINS');
  FListaProtegidas.Add('CONFIG_LISTAPRECO  ');          FListaProtegidas.Add('UTILIZACOES_CADASTROS');
  FListaProtegidas.Add('UTILIZACOES');                  FListaProtegidas.Add('CADASTROS');
  FListaProtegidas.Add('CADASTROS_AUD_JN');             FListaProtegidas.Add('CADASTROS_COMPL');
  FListaProtegidas.Add('CADASTROS_EMPRESAS');           FListaProtegidas.Add('CADASTROS_HIST');
  FListaProtegidas.Add('CADASTROS1');                   FListaProtegidas.Add('IMAGENS_CLIENTES');
  FListaProtegidas.Add('GRUPO_CLIENTES');               FListaProtegidas.Add('TIPOS_FORNECEDORES');
  FListaProtegidas.Add('SITUACAO_ESPECIAL');            FListaProtegidas.Add('SIAC_INDICACOES');
  FListaProtegidas.Add('PRODUTOS_CLIENTES');            FListaProtegidas.Add('CLIENTES_AUTORIZACAO_NFE');
  FListaProtegidas.Add('SEGMENTOS');                    FListaProtegidas.Add('RELACIONAMENTOS');
  FListaProtegidas.Add('RELACIONA_CLIENTE_AVALISTA');   FListaProtegidas.Add('SIAC_AGENDAMENTO_CLIENTE');
  FListaProtegidas.Add('SIAC_CLIENTE_OCORRENCIAS');     FListaProtegidas.Add('CONTATOS_CLIENTES');
  FListaProtegidas.Add('ITENS_GRUPO_CLIENTES');         FListaProtegidas.Add('CLIENTE_OBSERVACAO');
  FListaProtegidas.Add('CLIENTES_VENDEDORES');          FListaProtegidas.Add('TIPOS_FUNCIONARIOS');
  FListaProtegidas.Add('FUNCIONARIOS');                 FListaProtegidas.Add('VENDEDORES');
  FListaProtegidas.Add('PAISES');                       FListaProtegidas.Add('ESTADOS');
  FListaProtegidas.Add('CIDADES');                      FListaProtegidas.Add('ROTAS');
  FListaProtegidas.Add('REGIOES');                      FListaProtegidas.Add('RETENCOES_FEDERAIS');
  FListaProtegidas.Add('BAN_PARAMETROS');               FListaProtegidas.Add('BAN_PLANO_CENTRO');
  FListaProtegidas.Add('BAN_PLANO_CONTAS');             FListaProtegidas.Add('BAN_CENTRO_CUSTOS');
  FListaProtegidas.Add('BAN_CONTAS_CORRENTES');         FListaProtegidas.Add('BAN_CONFIGURACOES');
  FListaProtegidas.Add('PORTADORES');                   FListaProtegidas.Add('CONDICOES');
  FListaProtegidas.Add('CONDICOES_FLUXO');              FListaProtegidas.Add('CONDICOES_EMPRESAS');
  FListaProtegidas.Add('MOTIVOS_RETIRADA');             FListaProtegidas.Add('CONTAS_BOLETOS');
  FListaProtegidas.Add('SIAC_LEMBRETES');               FListaProtegidas.Add('CARTAO');
  FListaProtegidas.Add('CARTAO_ITENS_TAXAS');           FListaProtegidas.Add('REGRAS_DESCONTOS');
  FListaProtegidas.Add('REL_AUTORIZACAO');              FListaProtegidas.Add('REL_GRUPOS');
  FListaProtegidas.Add('REL_PESQUISAS');                FListaProtegidas.Add('REL_RELATORIOS');
  FListaProtegidas.Add('AUTORIZACAO_RELACAO_VENDAS');   FListaProtegidas.Add('SIAC_RELATORIOS_COMANDOS');
  FListaProtegidas.Add('SIAC_RELATORIOS_DINAMICOS');    FListaProtegidas.Add('FILTROS_GER_REL_GRAF');
  FListaProtegidas.Add('SIAC_AUTORIZACAO_REL_DINAMICOS');

  FSQLProtegidas := 'Lista estática local definida pelo sistema.';
end;

{ ===========================================================
  2. Consulta todas as tabelas do banco (USER_TABLES)
  =========================================================== }
procedure TClasseLimparMovimento.CarregarTodasTabelasBanco;
var
  Query: TOraQuery;
begin
  // 🔹 Garante que a conexão está ativa e recria FConsulta se necessário
  if (not Assigned(DmModule)) or
     (not Assigned(DmModule.orsConexao)) or
     (not DmModule.orsConexao.Connected) then
  begin
    MessageDlg('Conexão com o banco de dados não está ativa.' + sLineBreak +
               'Conecte-se ao banco antes de continuar.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not Assigned(FConsulta) then
    FConsulta := TClasseBancoDados.Create(DmModule.orsConexao);

  // 🔹 Limpa e executa consulta
  FListaTodasTabelas.Clear;

  FSQLTodasTabelas :=
    'SELECT TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME';

  FConsulta.SetSQL(FSQLTodasTabelas);
  FConsulta.ExecutarConsulta();
  try
    Query := FConsulta.GetQuery;
    while not Query.Eof do
    begin
      FListaTodasTabelas.Add(UpperCase(Query.FieldByName('TABLE_NAME').AsString));
      Query.Next;
    end;
  finally

  end;
end;


{ ===========================================================
  3. Calcula diferença → Tabelas deletáveis
  =========================================================== }
procedure TClasseLimparMovimento.GerarListaTabelasDeletaveis;
var
  NomeTabela: string;
  i: Integer;
begin
  FListaDeletaveis.Clear;

  for i := 0 to FListaTodasTabelas.Count - 1 do
  begin
    NomeTabela := FListaTodasTabelas[i];

    // 🔹 Se não estiver em nenhuma lista protegida (fixa ou personalizada), é deletável
    if (FListaProtegidas.IndexOf(NomeTabela) = -1) and
       (FListaProtegidasPersonalizadas.IndexOf(NomeTabela) = -1) then
      FListaDeletaveis.Add(NomeTabela);
  end;
end;


{ ===========================================================
  4. Executa análise completa
  =========================================================== }
procedure TClasseLimparMovimento.ExecutarAnaliseTabelas;
var
  ListaBackupPersonalizadas: TStringList;
begin
  //  Faz backup das tabelas personalizadas antes de recriar listas
  ListaBackupPersonalizadas := TStringList.Create;
  try
    ListaBackupPersonalizadas.Assign(FListaProtegidasPersonalizadas);

    // 🔹 Regenera listas padrão (sistema)
    GerarListaTabelasProtegidas;
    CarregarTodasTabelasBanco;

    //  Reinsere as tabelas personalizadas do usuário
    if ListaBackupPersonalizadas.Count > 0 then
      AdicionarTabelasProtegidasPersonalizadas(ListaBackupPersonalizadas);

    //  Finalmente recalcula as deletáveis com base na lista atualizada
    GerarListaTabelasDeletaveis;
  finally
    ListaBackupPersonalizadas.Free;
  end;
end;


{ ===========================================================
  5. Truncar tabelas deletáveis
  =========================================================== }
procedure TClasseLimparMovimento.TruncarTabelasDeletaveis(ADBGrid: TDBGrid);
var
  Progress: TProgressHelper;
  NomeTabela, SQLTruncate: string;
  DataSet: TDataSet;
  TotalTabelas: Integer;
begin
  // 🔹 Verifica parâmetros
  if (not Assigned(ADBGrid)) or (not Assigned(ADBGrid.DataSource)) or
     (not Assigned(ADBGrid.DataSource.DataSet)) then
  begin
    MessageDlg('Grid de tabelas deletáveis não está associado a um DataSet válido.',
               mtWarning, [mbOK], 0);
    Exit;
  end;

  DataSet := ADBGrid.DataSource.DataSet;

  if DataSet.IsEmpty then
  begin
    MessageDlg('Nenhuma tabela foi listada para truncar.', mtWarning, [mbOK], 0);
    Exit;
  end;

  //  Conta total de tabelas
  TotalTabelas := DataSet.RecordCount;

  //  Confirma truncamento com o usuário
  if MessageDlg(Format('Foram encontradas %d tabelas no grid.' + sLineBreak +
                       'Deseja realmente executar o truncamento?' + sLineBreak +
                       '⚠️ Esta ação é irreversível!',
                       [TotalTabelas]),
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  Exit;

  // Por algum motivo a classe do banco de dados esta sendo deletada
  // Adicionei o codigo abaixo como solução paliativa até resolver o caso.
  if Assigned(DmModule) and Assigned(DmModule.orsConexao)
   and (DmModule.orsConexao.Connected) and (FConsulta= nil) then
  FConsulta := TClasseBancoDados.Create(DmModule.orsConexao);



  // Inicializa progresso
  Progress := TProgressHelper.Create;
  try
    Progress.Start(TotalTabelas, 'Executando truncamento das tabelas do grid...');

    DataSet.DisableControls;
    try
      DataSet.First;
      while not DataSet.Eof do
      begin
        NomeTabela := Trim(DataSet.FieldByName('TABELA').AsString);

        if NomeTabela <> '' then
        begin
          SQLTruncate := Format('TRUNCATE TABLE %s', [NomeTabela]);
          try
            FConsulta.SetSQL(SQLTruncate);
            FConsulta.ExecutarComando;
            Progress.Step(Format('Truncada: %s', [NomeTabela]));
          except
            on E: Exception do
              Progress.Step(Format('Erro ao truncar %s: %s', [NomeTabela, E.Message]));
          end;
        end;

        DataSet.Next;
      end;
    finally
      DataSet.EnableControls;
    end;

  finally
    Progress.Finish;
    Progress.Free;
  end;
end;


{ ===========================================================
  6. SQL de contagem de registros
  =========================================================== }
function TClasseLimparMovimento.GerarSQLContagemTabelas: string;
var
  Query: TOraQuery;
  SQLBuilder: TStringBuilder;
  Tabela: string;
begin
  Result := '';

  // 🔹 Garante conexão ativa e recria FConsulta se necessário
  if (not Assigned(DmModule)) or
     (not Assigned(DmModule.orsConexao)) or
     (not DmModule.orsConexao.Connected) then
  begin
    MessageDlg('Conexão com o banco de dados não está ativa.' + sLineBreak +
               'Conecte-se ao banco antes de continuar.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not Assigned(FConsulta) then
    FConsulta := TClasseBancoDados.Create(DmModule.orsConexao);

  SQLBuilder := TStringBuilder.Create;
  try
    FConsulta.SetSQL('SELECT TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME');
    FConsulta.ExecutarConsulta();

    Query := FConsulta.GetQuery;
    Query.First;

    while not Query.Eof do
    begin
      Tabela := Query.FieldByName('TABLE_NAME').AsString;
      if FListaProtegidas.IndexOf(Tabela) = -1 then
        SQLBuilder.AppendFormat(
          'SELECT COUNT(*) AS QTD_LINHAS, ''%s'' AS TABELA FROM %s UNION ALL' + sLineBreak,
          [Tabela, Tabela]);
      Query.Next;
    end;

    Result := SQLBuilder.ToString.Trim;
    if Result.EndsWith('UNION ALL', True) then
      Delete(Result, Length(Result) - 8, 9);
  finally
    SQLBuilder.Free;
  end;
end;


procedure TClasseLimparMovimento.CarregarTabelasComDados(ADBGrid: TDBGrid);
var
  SQLContagem, SQLFinal: string;
  Query: TOraQuery;
  CDS: TClientDataSet;
  DS: TDataSource;
  Tabela: string;
  QtdLinhas: Integer;
  MaiorQtdLinhas: Integer;
  NomeMaiorTabela: string;
begin
  if (not Assigned(ADBGrid)) or (not Assigned(FConsulta)) then
    Exit;

  if not DmModule.orsConexao.Connected then
  begin
    MessageDlg('Conexão com o banco de dados não está ativa. Conecte-se antes de continuar.',
               mtWarning, [mbOK], 0);
    Exit;
  end;

  FListaDeletaveis.Clear;

  SQLContagem := GerarSQLContagemTabelas;

  if SQLContagem.Trim = '' then
  begin
    MessageDlg('Nenhum SQL de contagem pôde ser gerado.', mtWarning, [mbOK], 0);
    Exit;
  end;

  SQLFinal :=
    'SELECT TABELA, QTD_LINHAS FROM (' + sLineBreak +
     SQLContagem + sLineBreak +
    ') WHERE QTD_LINHAS > 0 ORDER BY QTD_LINHAS DESC';

  try
    FConsulta.SetSQL(SQLFinal);
    FConsulta.ExecutarConsulta();

    Query := FConsulta.GetQuery;

    // 🔹 Cria ClientDataSet temporário para exibir no grid
    CDS := TClientDataSet.Create(nil);
    DS := TDataSource.Create(nil);

    // 🔹 Define campos manualmente
    CDS.FieldDefs.Clear;
    CDS.FieldDefs.Add('TABELA', ftString, 200);
    CDS.FieldDefs.Add('QTD_LINHAS', ftInteger);
    CDS.FieldDefs.Add('TIPO_ITEM', ftString, 20);
    CDS.CreateDataSet;

    // 🔹 Preenche o ClientDataSet com os dados do Oracle
    Query.First;
    MaiorQtdLinhas := -1;
    NomeMaiorTabela := '';

    while not Query.Eof do
    begin
      Tabela := UpperCase(Trim(Query.FieldByName('TABELA').AsString));
      QtdLinhas := Query.FieldByName('QTD_LINHAS').AsInteger;

      if QtdLinhas > MaiorQtdLinhas then
      begin
        MaiorQtdLinhas := QtdLinhas;
        NomeMaiorTabela := Tabela;
      end;

      if (FListaProtegidas.IndexOf(Tabela) = -1) and
         (FListaProtegidasPersonalizadas.IndexOf(Tabela) = -1) then
      begin
        CDS.Append;
        CDS.FieldByName('TABELA').AsString := Tabela;
        CDS.FieldByName('QTD_LINHAS').AsInteger := QtdLinhas;
        CDS.FieldByName('TIPO_ITEM').AsString := 'SISTEMA'; // 🔹 Campo novo adicionado com sucesso
        CDS.Post;

        FListaDeletaveis.Add(Tabela);
      end;

      Query.Next;
    end;

    // 🔹 Vincula o dataset ao grid
    DS.DataSet := CDS;
    ADBGrid.DataSource := DS;

    // 🔹 Mantém foco no item de maior volume de registros
    if (NomeMaiorTabela <> '') and (not CDS.IsEmpty) then
    begin
      CDS.Locate('TABELA', NomeMaiorTabela, []);
      Application.ProcessMessages;
      if ADBGrid.Visible then
      begin
        ADBGrid.SetFocus;
        ADBGrid.Refresh;
      end;
    end;

  except
    on E: Exception do
      MessageDlg('Erro ao carregar tabelas com dados: ' + E.Message, mtError, [mbOK], 0);
  end;
end;




procedure TClasseLimparMovimento.CarregarListaProtegidas(ADBGrid: TDBGrid);
var
  i: Integer;
begin
  if not Assigned(ADBGrid) then Exit;

  if not Assigned(FClientDataSetProtegidas) then
    FClientDataSetProtegidas := TClientDataSet.Create(nil)
  else
    FClientDataSetProtegidas.Close;

  if not Assigned(FDataSourceProtegidas) then
    FDataSourceProtegidas := TDataSource.Create(nil);

  FClientDataSetProtegidas.FieldDefs.Clear;
  FClientDataSetProtegidas.FieldDefs.Add('TABELA_PROTEGIDA', ftString, 100);
  FClientDataSetProtegidas.FieldDefs.Add('TIPO_ORIGEM', ftString, 20); // NOVO CAMPO
  FClientDataSetProtegidas.CreateDataSet;

  // =====================================================
  // 1 Primeiro adiciona as tabelas personalizadas (usuário)
  // =====================================================
  for i := 0 to FListaProtegidasPersonalizadas.Count - 1 do
  begin
    FClientDataSetProtegidas.Append;
    FClientDataSetProtegidas.FieldByName('TABELA_PROTEGIDA').AsString :=
      FListaProtegidasPersonalizadas[i];
    FClientDataSetProtegidas.FieldByName('TIPO_ORIGEM').AsString := 'PERSONALIZADA';
    FClientDataSetProtegidas.Post;
  end;

  // =====================================================
  // 2 Depois adiciona as tabelas padrão do sistema
  // =====================================================
  for i := 0 to FListaProtegidas.Count - 1 do
  begin
    // Evita duplicar tabelas que já estejam na lista personalizada
    if FListaProtegidasPersonalizadas.IndexOf(FListaProtegidas[i]) = -1 then
    begin
      FClientDataSetProtegidas.Append;
      FClientDataSetProtegidas.FieldByName('TABELA_PROTEGIDA').AsString :=
        FListaProtegidas[i];
      FClientDataSetProtegidas.FieldByName('TIPO_ORIGEM').AsString := 'SISTEMA';
      FClientDataSetProtegidas.Post;
    end;
  end;

  FDataSourceProtegidas.DataSet := FClientDataSetProtegidas;
  ADBGrid.DataSource := FDataSourceProtegidas;

  // =====================================================
  // 3 NOVO: Foca automaticamente no primeiro registro
  // =====================================================
  if Assigned(FClientDataSetProtegidas) and (FClientDataSetProtegidas.RecordCount > 0) then
  begin
    FClientDataSetProtegidas.First;  // Garante que o dataset esteja no primeiro registro
    if Assigned(ADBGrid) and ADBGrid.Visible then
    begin
      ADBGrid.SetFocus;              // Dá foco ao grid
      ADBGrid.SelectedIndex := 0;    // Foca na primeira coluna
    end;
  end;
end;


procedure TClasseLimparMovimento.AtualizarResumoLabels(ALabelProtegidas, ALabelDeletadas: TLabel);
var
  Query: TOraQuery;
  TotalLinhas: Int64;
begin
  if Assigned(ALabelProtegidas) then
    ALabelProtegidas.Caption := Format('Tabelas protegidas: %d', [FListaProtegidas.Count]);

  TotalLinhas := 0;
  Query := FConsulta.GetQuery;

  if Assigned(Query) and Query.Active and (Query.RecordCount > 0) then
  begin
    Query.First;
    while not Query.Eof do
    begin
      if not Query.FieldByName('QTD_LINHAS').IsNull then
        Inc(TotalLinhas, Query.FieldByName('QTD_LINHAS').AsInteger);
      Query.Next;
    end;
  end;

  if Assigned(ALabelDeletadas) then
    ALabelDeletadas.Caption := Format(
      'Tabelas deletáveis: %d | Total de linhas: %s',
      [FListaDeletaveis.Count, FormatFloat('#,##0', TotalLinhas)]);
end;

{ ===========================================================
  10. Adiciona tabelas protegidas personalizadas (usuário)
  =========================================================== }
procedure TClasseLimparMovimento.AdicionarTabelasProtegidasPersonalizadas(const Tabelas: TStringList);
var
  NomeTabela: string;
  i: Integer;
begin
  if not Assigned(Tabelas) then Exit;

  for i := 0 to Tabelas.Count - 1 do
  begin
    NomeTabela := Trim(UpperCase(Tabelas[i]));
    if NomeTabela = '' then Continue;

    if FListaProtegidas.IndexOf(NomeTabela) = -1 then
      FListaProtegidas.Add(NomeTabela);

    if FListaProtegidasPersonalizadas.IndexOf(NomeTabela) = -1 then
      FListaProtegidasPersonalizadas.Add(NomeTabela);
  end;
end;

{ ===========================================================
  11. Getters das listas
  =========================================================== }
function TClasseLimparMovimento.GetListaProtegidas: TStringList;
begin
  Result := FListaProtegidas;
end;

function TClasseLimparMovimento.GetListaTodas: TStringList;
begin
  Result := FListaTodasTabelas;
end;

function TClasseLimparMovimento.GetListaDeletaveis: TStringList;
begin
  Result := FListaDeletaveis;
end;

function TClasseLimparMovimento.GetListaProtegidasPersonalizadas: TStringList;
begin
  Result := FListaProtegidasPersonalizadas;
end;

procedure TClasseLimparMovimento.FecharQuery;
begin
  FConsulta.GetQuery.Close;
end;

end.

