unit uViewOracleIMP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.StrUtils, IdIPWatch, System.Net.Socket, IdStack, System.NetEncoding,
  System.RegularExpressions, Vcl.ExtCtrls, Vcl.Buttons, uViewMain,
  Classe.OracleImp, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.CheckLst, Datasnap.DBClient, Classe.funcoes, FireDAC.Comp.Client, Ora;

type
  TViewOracleIMP = class(TForm)
    pnl_containerFundo: TPanel;
    pnl_containerOpcoes: TPanel;
    pnl_container: TPanel;
    lbl_userExport: TLabel;
    edt_userExport: TEdit;
    edt_diretorioArquivo: TEdit;
    lbl_diretorioArquivo: TLabel;
    pnl_containerTabelas: TPanel;
    pnl_containerBotoes: TPanel;
    pnl_containerBtnProcessar: TPanel;
    btn_importar: TSpeedButton;
    pnl_containerBuscarArquivo: TPanel;
    btn_carregarArquivo: TSpeedButton;
    edt_userDestino: TEdit;
    lbl_usuarioDestino: TLabel;
    chk_UtilizarImpDP: TCheckBox;
    lbl_status: TLabel;
    cbx_tnsAlias: TComboBox;
    lbl_oracleServer: TLabel;
    pnl_containerAddTabelas: TPanel;
    chk_tabelasPersonalizada: TCheckBox;
    btn_addTabelas: TSpeedButton;
    edt_inserirTabelas: TEdit;
    pnl_containerDbgrid: TPanel;
    pnl_containerBotoesLista: TPanel;
    btn_excluirItem: TSpeedButton;
    btn_addTabelasLista: TSpeedButton;
    dbgrd_containerTabelasPersonalizadas: TDBGrid;
    ds_dbgridImp: TDataSource;
    dataSet_dbgridImp: TClientDataSet;
    lbl_status_pasta: TLabel;
    cbb_addExclude: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_carregarArquivoClick(Sender: TObject);
    procedure btn_importarClick(Sender: TObject);
    procedure chk_tabelasPersonalizadaClick(Sender: TObject);
    procedure btn_addTabelasClick(Sender: TObject);
    procedure btn_excluirItemClick(Sender: TObject);
    procedure btn_addTabelasListaClick(Sender: TObject);
    procedure edt_inserirTabelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrd_containerTabelasPersonalizadasKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure chk_UtilizarImpDPClick(Sender: TObject);
  private
    FOracleImpExp: TOracleImpExp;
    FTabelasPersonalizadas: TStringList;

    procedure AdicionarTabelaPersonalizada(const NomeTabela: string);
    //function MontarParametroTabelas: string;
  public
    procedure CarregarAliasesOracle;
  end;

var
  ViewOracleIMP: TViewOracleIMP;

implementation

uses
  uDataModule;

{$R *.dfm}

procedure TViewOracleIMP.FormCreate(Sender: TObject);
begin
  FOracleImpExp := TOracleImpExp.Create;
  FTabelasPersonalizadas := TStringList.Create;

  // Vincula o datasource ao grid (somente se não estiver feito no DFM)
  ds_dbgridImp.DataSet := dataSet_dbgridImp;
  dbgrd_containerTabelasPersonalizadas.DataSource := ds_dbgridImp;

  // Configura o ClientDataSet para o Grid
  dataSet_dbgridImp.Close;
  dataSet_dbgridImp.FieldDefs.Clear;
  dataSet_dbgridImp.FieldDefs.Add('NOME_TABELA', ftString, 100);
  dataSet_dbgridImp.CreateDataSet;
  dataSet_dbgridImp.Open;

  // Força atualização de colunas
  dbgrd_containerTabelasPersonalizadas.Columns.Clear;
  dbgrd_containerTabelasPersonalizadas.Columns.Add.FieldName := 'NOME_TABELA';
  dbgrd_containerTabelasPersonalizadas.Columns[0].Title.Caption := 'Tabela';
  dbgrd_containerTabelasPersonalizadas.Refresh;

  try
    // Detecta automaticamente a ferramenta Oracle via WHERE CMD
    FOracleImpExp.DetectarFerramentaOracle;

    // Carrega aliases TNS
    CarregarAliasesOracle;

    lbl_status.Caption := 'Ferramenta Oracle detectada: ' +
                          ExtractFileName(FOracleImpExp.FerramentaImp);
  except
    on E: Exception do
      ShowMessage('Erro ao detectar ferramenta Oracle: ' + E.Message);
  end;

end;

procedure TViewOracleIMP.chk_tabelasPersonalizadaClick(Sender: TObject);
begin
  if chk_tabelasPersonalizada.Checked then
  begin
    edt_inserirTabelas.Enabled := True;
    dbgrd_containerTabelasPersonalizadas.Enabled := True;
    btn_addTabelas.Enabled := True;
    btn_addTabelasLista.Enabled := True;
    btn_excluirItem.Enabled := True;
    cbb_addExclude.Enabled := True;
     // Apos habilitar tudo vamos levar o foco para digitação
    edt_inserirTabelas.SetFocus;
  end
  else
  begin
    edt_inserirTabelas.Enabled := False;
    dbgrd_containerTabelasPersonalizadas.Enabled := False;
    btn_addTabelas.Enabled := False;
    btn_addTabelasLista.Enabled := False;
    btn_excluirItem.Enabled := False;
    cbb_addExclude.Enabled := False;
  end;
end;

procedure TViewOracleIMP.chk_UtilizarImpDPClick(Sender: TObject);
begin
  if chk_UtilizarImpDP.Checked then
  begin
    // Adiciona a opção EXCLUDE se ainda não existir
    if cbb_addExclude.Items.IndexOf('Exclude') = -1 then
      cbb_addExclude.Items.Add('Exclude');
  end
  else
  begin
    // Remove a opção EXCLUDE quando desmarcado
    cbb_addExclude.Items.Delete(cbb_addExclude.Items.IndexOf('Exclude'));
    cbb_addExclude.ItemIndex := 0; // volta para TABLES
  end;
end;

procedure TViewOracleIMP.btn_addTabelasClick(Sender: TObject);
var
  NomeTabela: string;
begin
  NomeTabela := Trim(edt_inserirTabelas.Text);

  if NomeTabela = '' then
  begin
    ShowMessage('Digite o nome de uma tabela antes de adicionar.');
    Exit;
  end;

  // Evita duplicadas
  if FTabelasPersonalizadas.IndexOf(UpperCase(NomeTabela)) <> -1 then
  begin
    ShowMessage('A tabela "' + NomeTabela + '" já foi adicionada.');
    Exit;
  end;

  // Adiciona na lista interna
  FTabelasPersonalizadas.Add(UpperCase(NomeTabela));

  // Adiciona no dataset (exibido no grid)
  dataSet_dbgridImp.Append;
  dataSet_dbgridImp.FieldByName('NOME_TABELA').AsString := UpperCase(NomeTabela);
  dataSet_dbgridImp.Post;

  // Atualiza a tela
  dbgrd_containerTabelasPersonalizadas.Refresh;

  // Limpa o campo
  edt_inserirTabelas.Clear;
  edt_inserirTabelas.SetFocus;
end;

procedure TViewOracleIMP.btn_addTabelasListaClick(Sender: TObject);
var
  MemoForm: TForm;
  MemoInput: TMemo;
  BtnOk, BtnCancel: TButton;
  Lista: TStringList;
  i: Integer;
  NomeTabela: string;
begin
  // Cria form temporário
  MemoForm := TForm.Create(nil);
  try
    MemoForm.Caption := 'Adicionar Lista de Tabelas';
    MemoForm.BorderStyle := bsSizeable;
    MemoForm.Position := poScreenCenter;
    MemoForm.Width := 600;
    MemoForm.Height := 400;
    MemoForm.Color := clTeal;
    MemoForm.Font.Name := 'Segoe UI';
    MemoForm.Font.Size := 10;

    // Cria o TMemo para digitação
    MemoInput := TMemo.Create(MemoForm);
    MemoInput.Parent := MemoForm;
    MemoInput.Align := alClient;
    MemoInput.ScrollBars := ssVertical;
    MemoInput.WordWrap := False;
    MemoInput.Font.Name := 'Consolas';
    MemoInput.Font.Size := 11;
    MemoInput.Font.Color := clGreen;
    MemoInput.Lines.Add('Digite aqui as tabelas que deseja importar...');
    MemoInput.Lines.Add('Um nome de tabela por linha.');
    MemoInput.Lines.Add('');
    MemoInput.SelStart := 0;

    // Botão OK
    BtnOk := TButton.Create(MemoForm);
    BtnOk.Parent := MemoForm;
    BtnOk.Caption := 'Confirmar';
    BtnOk.ModalResult := mrOk;
    BtnOk.Default := True;
    BtnOk.Top := MemoForm.ClientHeight - 45;
    BtnOk.Left := MemoForm.ClientWidth - 180;
    BtnOk.Width := 80;
    BtnOk.Anchors := [akRight, akBottom];

    // Botão Cancelar
    BtnCancel := TButton.Create(MemoForm);
    BtnCancel.Parent := MemoForm;
    BtnCancel.Caption := 'Cancelar';
    BtnCancel.ModalResult := mrCancel;
    BtnCancel.Cancel := True;
    BtnCancel.Top := BtnOk.Top;
    BtnCancel.Left := BtnOk.Left + BtnOk.Width + 10;
    BtnCancel.Width := 80;
    BtnCancel.Anchors := [akRight, akBottom];

    // Mostra o formulário de forma modal
    if MemoForm.ShowModal = mrOk then
    begin
      Lista := TStringList.Create;
      try
        Lista.Text := Trim(MemoInput.Lines.Text);
        Lista.StrictDelimiter := True;

        // Adiciona as tabelas digitadas ao DataSet e à lista interna
        for i := 0 to Lista.Count - 1 do
        begin
          NomeTabela := Trim(UpperCase(Lista[i]));
          if NomeTabela = '' then
            Continue;

          // Evita duplicados
          if FTabelasPersonalizadas.IndexOf(NomeTabela) <> -1 then
            Continue;

          // Adiciona na lista
          FTabelasPersonalizadas.Add(NomeTabela);

          // Adiciona ao DataSet visual
          if not dataSet_dbgridImp.Active then
          begin
            dataSet_dbgridImp.CreateDataSet;
            dataSet_dbgridImp.Active := True;
          end;

          dataSet_dbgridImp.Append;
          dataSet_dbgridImp.FieldByName('NOME_TABELA').AsString := NomeTabela;
          dataSet_dbgridImp.Post;
        end;

        dbgrd_containerTabelasPersonalizadas.Refresh;
        lbl_status.Caption := Format('%d tabelas adicionadas com sucesso.', [Lista.Count]);

      finally
        Lista.Free;
      end;
    end;

  finally
    MemoForm.Free;
  end;
end;

procedure TViewOracleIMP.btn_carregarArquivoClick(Sender: TObject);
var
  CaminhoArquivo, PastaDataPump: string;
  Query: TOraQuery;
begin
  try
    PastaDataPump := '';

    // 1. Verifica se está em modo Data Pump (impdp)
    if chk_UtilizarImpDP.Checked then
    begin
      lbl_status_pasta.Caption := 'Buscando diretório do Oracle Data Pump...';
      Application.ProcessMessages;

      try
        Query := TOraQuery.Create(nil);
        try
          Query.Session := DmModule.orsConexao;
          Query.SQL.Text :=
            'SELECT DIRECTORY_PATH ' +
            'FROM dba_directories ' +
            'WHERE DIRECTORY_NAME = ''DATA_PUMP_DIR'' OR DIRECTORY_NAME LIKE ''%PUMP%''';

          Query.Open;

          if not Query.IsEmpty then
          begin
            PastaDataPump := Trim(Query.FieldByName('DIRECTORY_PATH').AsString);
            lbl_status_pasta.Caption := 'Pasta: ' + PastaDataPump;
          end
          else
          begin
            lbl_status_pasta.Caption :=
              'Nenhum diretório "DATA_PUMP_DIR" encontrado no banco de dados.';
          end;
        finally
          Query.Free;
        end;
      except
        on E: Exception do
        begin
          lbl_status_pasta.Caption :=
            'Erro ao consultar DBA_DIRECTORIES: ' + E.Message +
            sLineBreak + 'Tentando fallback padrão...';
        end;
      end;

    end
    else
    begin
      lbl_status_pasta.Caption := 'Modo Data Pump não selecionado.';
    end;

    // 3. Abre o seletor de arquivo (usando o diretório detectado)
    FOracleImpExp.SelecionarArquivoDump(PastaDataPump, chk_UtilizarImpDP.Checked);

    // 4. Recupera o caminho completo selecionado
    CaminhoArquivo := FOracleImpExp.DumpFile;

    // 5. Atualiza interface
    if Trim(CaminhoArquivo) <> '' then
    begin
      edt_diretorioArquivo.Text := CaminhoArquivo;
      lbl_status_pasta.Caption := 'Abrindo seletor em: ' + PastaDataPump;
      lbl_status.Caption := 'Arquivo selecionado com sucesso!';
    end
    else
      lbl_status.Caption := 'Nenhum arquivo selecionado.';

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao selecionar o arquivo DMP: ' + E.Message);
      lbl_status.Caption := 'Erro ao selecionar arquivo.';
    end;
  end;
end;

procedure TViewOracleIMP.btn_excluirItemClick(Sender: TObject);
var
  NomeTabela: string;
  Confirmacao: Integer;
begin
  // Verifica se há algo selecionado no dataset
  if (not dataSet_dbgridImp.Active) or (dataSet_dbgridImp.IsEmpty) then
  begin
    ShowMessage('Nenhum item disponível para exclusão.');
    Exit;
  end;

  NomeTabela := dataSet_dbgridImp.FieldByName('NOME_TABELA').AsString;

  // Confirma a exclusão
  Confirmacao := MessageDlg(
    Format('Deseja realmente remover a tabela "%s" da lista?', [NomeTabela]),
    mtConfirmation, [mbYes, mbNo], 0
  );

  if Confirmacao = mrNo then
    Exit;

  // Remove do ClientDataSet
  dataSet_dbgridImp.Delete;

  // Remove também da lista interna (se estiver usando FTabelasPersonalizadas)
  if Assigned(FTabelasPersonalizadas) then
    FTabelasPersonalizadas.Delete(FTabelasPersonalizadas.IndexOf(UpperCase(NomeTabela)));

  // Atualiza o grid
  dbgrd_containerTabelasPersonalizadas.Refresh;

  // Mensagem opcional de feedback
  lbl_status.Caption := 'Tabela "' + NomeTabela + '" removida com sucesso.';
end;

procedure TViewOracleIMP.btn_importarClick(Sender: TObject);
var
  CmdPreview: string;
  LogFileOracle, LogFileSIAC: string;
  Resultado: Integer;
  ServicoOracle, AliasSelecionado: string;
  ListaTabelas: TStringList;
  ParamTabelas, ListaPreview: string;
  LogHeader: TStringList;
  StartTime: TDateTime;
begin
  try
    // 1. Valida se o arquivo foi selecionado
    if Trim(edt_diretorioArquivo.Text) = '' then
    begin
      ShowMessage('Selecione um arquivo .DMP antes de importar.');
      Exit;
    end;

    // 2. Define o dump file na classe
    FOracleImpExp.DumpFile := edt_diretorioArquivo.Text;

    // 3. Define os usuários envolvidos
    FOracleImpExp.FromUser := edt_userExport.Text;
    FOracleImpExp.ToUser   := edt_userDestino.Text;

    // 4. Obtém o alias Oracle selecionado no ComboBox
    if cbx_tnsAlias.ItemIndex >= 0 then
    begin
      AliasSelecionado := cbx_tnsAlias.Items[cbx_tnsAlias.ItemIndex];
      ServicoOracle := Trim(Copy(AliasSelecionado, 1, Pos('|', AliasSelecionado) - 1));
    end
    else
      ServicoOracle := Trim(FOracleImpExp.ServidorDB); // fallback se nada selecionado

    // 5. Define os caminhos dos logs
    LogFileOracle := Format('C:\SiacDBManagerLogs\Import_%s.log', [FOracleImpExp.ToUser]);
    LogFileSIAC   := Format('C:\SiacDBManagerLogs\Import_%s_SIAC.log', [FOracleImpExp.ToUser]);

    if not DirectoryExists('C:\SiacDBManagerLogs') then
      ForceDirectories('C:\SiacDBManagerLogs');

    // 6. Monta lista TABLES ou EXCLUDE se houver
    ParamTabelas := '';
    ListaPreview := '';

    if chk_tabelasPersonalizada.Checked then
    begin
      if not dataSet_dbgridImp.IsEmpty then
      begin
        ListaTabelas := TStringList.Create;
        try
          dataSet_dbgridImp.First;
          while not dataSet_dbgridImp.Eof do
          begin
            if Trim(dataSet_dbgridImp.FieldByName('NOME_TABELA').AsString) <> '' then
            begin
              // impdp precisa de prefixo com schema, imp não
              if chk_UtilizarImpDP.Checked then
                ListaTabelas.Add(UpperCase(Trim(FOracleImpExp.FromUser + '.' +
                                 dataSet_dbgridImp.FieldByName('NOME_TABELA').AsString)))
              else
                ListaTabelas.Add(UpperCase(Trim(dataSet_dbgridImp.FieldByName('NOME_TABELA').AsString)));
            end;
            dataSet_dbgridImp.Next;
          end;

          if ListaTabelas.Count > 0 then
          begin
            ListaPreview := StringReplace(ListaTabelas.Text, sLineBreak, ', ', [rfReplaceAll]);

            if cbb_addExclude.ItemIndex = 1 then
            begin
              // --- EXCLUDE ---
              // remove schema se impdp (somente o nome da tabela deve ir na cláusula IN)
              var ListaNomes := TStringList.Create;
              try
                for var i := 0 to ListaTabelas.Count - 1 do
                  ListaNomes.Add(
                    Copy(ListaTabelas[i], Pos('.', ListaTabelas[i]) + 1, MaxInt)
                  );

                ParamTabelas := ' EXCLUDE=TABLE:"IN(''' +
                                StringReplace(ListaNomes.CommaText, ',', ''',''', [rfReplaceAll]) +
                                ''')"';
              finally
                ListaNomes.Free;
              end;
            end
            else
            begin
              // --- TABLES ---
              ParamTabelas := ' TABLES=(' + ListaTabelas.CommaText + ')';
            end;
          end
          else
          begin
            ShowMessage('O modo "Tabelas Personalizadas" está ativo, mas nenhuma tabela foi adicionada.');
            Exit;
          end;
        finally
          ListaTabelas.Free;
        end;
      end
      else
      begin
        ShowMessage('O modo "Tabelas Personalizadas" está ativo, mas nenhuma tabela foi adicionada.');
        Exit;
      end;
    end;



    // 7. Monta o comando completo (Oracle log)
      if chk_UtilizarImpDP.Checked then
      begin
        //  Versão Data Pump (impdp.exe)
        CmdPreview := Format(
          '%s userid=%s/%s@%s DIRECTORY=DATA_PUMP_DIR DUMPFILE=%s TABLE_EXISTS_ACTION=REPLACE LOGFILE=%s REMAP_SCHEMA=%s:%s%s',
          [
            FOracleImpExp.FerramentaImpDP,                     // Caminho do impdp.exe
            DmModule.orsConexao.Username,                      // Usuário Oracle logado
            DmModule.orsConexao.Password,                      // Senha
            ServicoOracle,                                     // Serviço TNS (ex: MASTER)
            ExtractFileName(FOracleImpExp.DumpFile),           // Apenas o nome do arquivo (ex: IMPORT.DP)
            'Import_' + FOracleImpExp.ToUser + '.log',         // Logfile criado automaticamente no diretório Oracle
            FOracleImpExp.FromUser,                            // Usuário origem
            FOracleImpExp.ToUser,                              // Usuário destino
            ParamTabelas                                       // Se houver TABLES=(...)
          ]
        );
      end
      else
      begin
        //  Versão clássica (imp.exe)
        CmdPreview := Format(
          '%s log=%s file=%s userid=%s/%s@%s fromuser=%s touser=%s%s buffer=30720 commit=no grants=yes ignore=yes indexes=no rows=yes show=no constraints=no',
          [
            FOracleImpExp.FerramentaImp,
            LogFileOracle,
            FOracleImpExp.DumpFile,
            DmModule.orsConexao.Username,
            DmModule.orsConexao.Password,
            ServicoOracle,
            FOracleImpExp.FromUser,
            FOracleImpExp.ToUser,
            ParamTabelas
          ]
        );
      end;


    // 8. Cria cabeçalho SIAC (em arquivo separado)
    LogHeader := TStringList.Create;
    try
      if FileExists(LogFileSIAC) then
      begin
        LogHeader.Add('');
        LogHeader.Add('---------------------- NOVA EXECUÇÃO ----------------------');
      end;

      LogHeader.Add('===============================================');
      LogHeader.Add(' SIAC DB MANAGER - IMPORTAÇÃO DE DADOS ORACLE ');
      LogHeader.Add(' Data/Hora início: ' + DateTimeToStr(Now));
      LogHeader.Add(' Usuário Oracle: ' + DmModule.orsConexao.Username);
      LogHeader.Add(' Servidor: ' + ServicoOracle);
      LogHeader.Add(' FromUser: ' + FOracleImpExp.FromUser);
      LogHeader.Add(' ToUser: ' + FOracleImpExp.ToUser);
      if ListaPreview <> '' then
        LogHeader.Add(' Tabelas personalizadas: ' + ListaPreview);
      if chk_UtilizarImpDP.Checked then
        LogHeader.Add(' Modo: IMPDP (Data Pump)')
      else
        LogHeader.Add(' Modo: IMP (Convencional)');
      LogHeader.Add('-----------------------------------------------');
      LogHeader.Add(' Comando executado:');
      LogHeader.Add(CmdPreview);
      LogHeader.Add('===============================================');
      LogHeader.Add('');
      AppendToFile(LogFileSIAC, LogHeader);
    finally
      LogHeader.Free;
    end;

    // 9. Mostra o preview antes de executar
    Resultado := MessageDlg(
      'O seguinte comando será executado:' + sLineBreak + sLineBreak +
      CmdPreview + sLineBreak + sLineBreak +
      'Deseja continuar?',
      mtConfirmation, [mbOK, mbCancel], 0
    );

    if Resultado = mrCancel then
    begin
      ShowMessage('Operação cancelada pelo usuário.');
      Exit;
    end;

    // 10. Executa e mede tempo
    StartTime := Now;
    FOracleImpExp.ExecutarComandoVisivel(CmdPreview);

    // 11. Acrescenta rodapé ao log SIAC
    LogHeader := TStringList.Create;
    try
      LogHeader.Add('');
      LogHeader.Add('===============================================');
      LogHeader.Add(' Procedimento Finalizado!');
      LogHeader.Add('===============================================');
      AppendToFile(LogFileSIAC, LogHeader);
    finally
      LogHeader.Free;
    end;

    ShowMessage(
      'Processo de importação finalizado com sucesso!' + sLineBreak +
      'Verifique os logs:' + sLineBreak +
      '- Oracle: ' + LogFileOracle + sLineBreak +
      '- SIAC: ' + LogFileSIAC
    );

  except
    on E: Exception do
      ShowMessage('Erro ao iniciar importação: ' + E.Message);
  end;
end;


procedure TViewOracleIMP.dbgrd_containerTabelasPersonalizadasKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Confirmacao: Integer;
begin
  // Excluir item individual (tecla Delete)
  if Key = VK_DELETE then
  begin
    btn_excluirItemClick(btn_excluirItem);
    Key := 0;
    Exit;
  end;

  // Limpar tudo (Ctrl + A)
  if (Key = Ord('A')) and (ssCtrl in Shift) then
  begin
    if (not dataSet_dbgridImp.Active) or (dataSet_dbgridImp.IsEmpty) then
    begin
      ShowMessage('Não há tabelas para limpar.');
      Exit;
    end;

    Confirmacao := MessageDlg(
      'Tem certeza que deseja remover **todas as tabelas personalizadas** da lista?',
      mtWarning, [mbYes, mbNo], 0
    );

    if Confirmacao = mrYes then
    begin
      dataSet_dbgridImp.EmptyDataSet;

      // Sincroniza com a lista interna também
      if Assigned(FTabelasPersonalizadas) then
        FTabelasPersonalizadas.Clear;

      dbgrd_containerTabelasPersonalizadas.Refresh;
      lbl_status.Caption := 'Todas as tabelas foram removidas com sucesso.';
    end;

    Key := 0; // evita qualquer outro processamento
  end;
end;

procedure TViewOracleIMP.edt_inserirTabelasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    btn_addTabelasClick(btn_addTabelas); // chama o evento do botão
    Key := 0; // impede o beep padrão do Enter
  end;
end;

procedure TViewOracleIMP.CarregarAliasesOracle;
var
  ListaTNS: TStringList;
  i: Integer;
  AliasName, Host, ServidorAtual, ServidorBase: string;
  FoundIndex: Integer;

  function LimparServidor(const Valor: string): string;
  var
    Temp: string;
  begin
    Temp := Trim(UpperCase(Valor));
    // Remove sufixos :PORT e /SERVICE_NAME
    if Pos(':', Temp) > 0 then
      Temp := Copy(Temp, 1, Pos(':', Temp) - 1);
    if Pos('/', Temp) > 0 then
      Temp := Copy(Temp, 1, Pos('/', Temp) - 1);
    Result := Temp;
  end;

begin
  cbx_tnsAlias.Clear;
  ListaTNS := FOracleImpExp.GetTnsAliases;
  FoundIndex := -1;

  try
    if ListaTNS.Count = 0 then
    begin
      ShowMessage('Nenhum alias Oracle encontrado no arquivo TNSNAMES.ORA.');
      Exit;
    end;

    // Pega o servidor atual (onde o Delphi está conectado)
    ServidorAtual := Trim(FOracleImpExp.ServidorDB);
    ServidorBase := LimparServidor(ServidorAtual);

    for i := 0 to ListaTNS.Count - 1 do
    begin
      // Separa o alias e o host
      AliasName := Trim(Copy(ListaTNS[i], 1, Pos('|', ListaTNS[i]) - 1));
      Host := Trim(Copy(ListaTNS[i], Pos('|', ListaTNS[i]) + 1, MaxInt));

      cbx_tnsAlias.Items.Add(AliasName + ' | ' + Host);

      // Normaliza os nomes para comparação
      if SameText(ServidorBase, UpperCase(AliasName)) or
         SameText(ServidorBase, UpperCase(Host)) then
        FoundIndex := i;
    end;

    // Seleciona automaticamente o alias detectado
    if FoundIndex >= 0 then
      cbx_tnsAlias.ItemIndex := FoundIndex
    else
      cbx_tnsAlias.ItemIndex := 0;

    // Atualiza o status visual
    lbl_status.Caption := Format(
      'Servidor logado: %s  →  TNS selecionado: %s',
      [ServidorAtual, cbx_tnsAlias.Text]
    );

  finally
    ListaTNS.Free;
  end;
end;



procedure TViewOracleIMP.FormDestroy(Sender: TObject);
begin
  // Libera a memória
  if Assigned(FOracleImpExp) then
    FreeAndNil(FOracleImpExp);
    FreeAndNil(FTabelasPersonalizadas);
end;

procedure TViewOracleIMP.AdicionarTabelaPersonalizada(const NomeTabela: string);
begin
  if Trim(NomeTabela) = '' then
    Exit;

  // Evita duplicadas
  if FTabelasPersonalizadas.IndexOf(UpperCase(NomeTabela)) = -1 then
  begin
    FTabelasPersonalizadas.Add(UpperCase(NomeTabela));

    // Atualiza visual no grid (se tiver DataSource ou lista vinculada)
    if dbgrd_containerTabelasPersonalizadas.DataSource <> nil then
      dbgrd_containerTabelasPersonalizadas.DataSource.DataSet.AppendRecord([UpperCase(NomeTabela)]);
  end;

  edt_inserirTabelas.Clear;
end;

end.
