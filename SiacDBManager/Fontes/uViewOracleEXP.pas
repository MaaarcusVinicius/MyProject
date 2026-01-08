unit uViewOracleEXP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.StrUtils, IdIPWatch, System.Net.Socket, IdStack, System.NetEncoding,
  System.RegularExpressions, Vcl.ExtCtrls, Vcl.Buttons, Classe.OracleExp,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.CheckLst, Datasnap.DBClient,
  Classe.funcoes, FireDAC.Comp.Client, Ora, uViewMain;

type
  TViewOracleEXP = class(TForm)
    pnl_containerFundo: TPanel;
    pnl_containerOpcoes: TPanel;
    pnl_container: TPanel;
    lbl_userExport: TLabel;
    edt_diretorioArquivoExp: TEdit;
    lbl_diretorioArquivo: TLabel;
    pnl_containerTabelas: TPanel;
    pnl_containerBotoes: TPanel;
    pnl_containerBtnProcessar: TPanel;
    btn_exportar: TSpeedButton;
    pnl_containerSalvarArquivo: TPanel;
    btn_salvarArquivo: TSpeedButton;
    chk_tabelasPersonalizadaExp: TCheckBox;
    lbl_statusExp: TLabel;
    cbx_tnsAlias: TComboBox;
    lbl_oracleServer: TLabel;
    pnl_containerAddTabelas: TPanel;
    btn_addTabelasExp: TSpeedButton;
    edt_inserirTabelasExp: TEdit;
    pnl_containerDbgrid: TPanel;
    pnl_containerBotoesLista: TPanel;
    btn_excluirItemExp: TSpeedButton;
    btn_addTabelasListaExp: TSpeedButton;
    dbgrd_containerTabelasPersonalizadasExp: TDBGrid;
    ds_dbgridExp: TDataSource;
    dataSet_dbgridExp: TClientDataSet;
    lbl_status_pastaExp: TLabel;
    chk_UtilizarExpDP: TCheckBox;
    cbb_addExcludeExp: TComboBox;
    cbb_userExport: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_salvarArquivoClick(Sender: TObject);
    procedure btn_exportarClick(Sender: TObject);
    procedure chk_tabelasPersonalizadaExpClick(Sender: TObject);
    procedure btn_addTabelasClick(Sender: TObject);
    procedure btn_excluirItemClick(Sender: TObject);
    procedure btn_addTabelasListaClick(Sender: TObject);
    procedure edt_inserirTabelasExpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd_containerTabelasPersonalizadasExpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chk_UtilizarExpDPClick(Sender: TObject);
    procedure btn_addTabelasExpClick(Sender: TObject);
    procedure btn_addTabelasListaExpClick(Sender: TObject);
    procedure btn_excluirItemExpClick(Sender: TObject);
  private
    FOracleExp: TOracleExp;
    FTabelasPersonalizadas: TStringList;
    procedure AdicionarTabelaPersonalizada(const NomeTabela: string);
  public
    procedure CarregarAliasesOracleExp;
    procedure CarregarListaUsuariosExport;
  end;

var
  ViewOracleEXP: TViewOracleEXP;

implementation

uses
  uDataModule;

{$R *.dfm}

procedure TViewOracleEXP.FormCreate(Sender: TObject);
begin
  FOracleExp := TOracleExp.Create;
  FTabelasPersonalizadas := TStringList.Create;
  CarregarListaUsuariosExport;

  ds_dbgridExp.DataSet := dataSet_dbgridExp;
  dbgrd_containerTabelasPersonalizadasExp.DataSource := ds_dbgridExp;

  dataSet_dbgridExp.Close;
  dataSet_dbgridExp.FieldDefs.Clear;
  dataSet_dbgridExp.FieldDefs.Add('NOME_TABELA', ftString, 100);
  dataSet_dbgridExp.CreateDataSet;
  dataSet_dbgridExp.Open;

  dbgrd_containerTabelasPersonalizadasExp.Columns.Clear;
  dbgrd_containerTabelasPersonalizadasExp.Columns.Add.FieldName := 'NOME_TABELA';
  dbgrd_containerTabelasPersonalizadasExp.Columns[0].Title.Caption := 'Tabela';
  dbgrd_containerTabelasPersonalizadasExp.Refresh;

  try
    FOracleExp.DetectarFerramentaOracle;
    CarregarAliasesOracleExp;

    lbl_statusExp.Caption := 'Ferramenta Oracle detectada: ' + ExtractFileName(FOracleExp.FerramentaExp);
  except
    on E: Exception do
      ShowMessage('Erro ao detectar ferramenta Oracle: ' + E.Message);
  end;
end;

procedure TViewOracleEXP.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FOracleExp);
  FreeAndNil(FTabelasPersonalizadas);
end;

procedure TViewOracleEXP.chk_tabelasPersonalizadaExpClick(Sender: TObject);
begin
  edt_inserirTabelasExp.Enabled := chk_tabelasPersonalizadaExp.Checked;
  dbgrd_containerTabelasPersonalizadasExp.Enabled := chk_tabelasPersonalizadaExp.Checked;
  btn_addTabelasExp.Enabled := chk_tabelasPersonalizadaExp.Checked;
  btn_addTabelasListaExp.Enabled := chk_tabelasPersonalizadaExp.Checked;
  btn_excluirItemExp.Enabled := chk_tabelasPersonalizadaExp.Checked;
  cbb_addExcludeExp.Enabled := chk_tabelasPersonalizadaExp.Checked;

  if chk_tabelasPersonalizadaExp.Checked then
    edt_inserirTabelasExp.SetFocus;
end;

procedure TViewOracleEXP.chk_UtilizarExpDPClick(Sender: TObject);
begin
  if chk_UtilizarExpDP.Checked then
  begin
    if cbb_addExcludeExp.Items.IndexOf('Exclude') = -1 then
      cbb_addExcludeExp.Items.Add('Exclude');
  end
  else
  begin
    if cbb_addExcludeExp.Items.IndexOf('Exclude') >= 0 then
      cbb_addExcludeExp.Items.Delete(cbb_addExcludeExp.Items.IndexOf('Exclude'));
    cbb_addExcludeExp.ItemIndex := 0;
  end;
end;

procedure TViewOracleEXP.btn_addTabelasClick(Sender: TObject);
var
  NomeTabela: string;
begin
  NomeTabela := Trim(edt_inserirTabelasExp.Text);

  if NomeTabela = '' then
  begin
    ShowMessage('Digite o nome de uma tabela antes de adicionar.');
    Exit;
  end;

  if FTabelasPersonalizadas.IndexOf(UpperCase(NomeTabela)) <> -1 then
  begin
    ShowMessage('A tabela "' + NomeTabela + '" já foi adicionada.');
    Exit;
  end;

  FTabelasPersonalizadas.Add(UpperCase(NomeTabela));
  dataSet_dbgridExp.Append;
  dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString := UpperCase(NomeTabela);
  dataSet_dbgridExp.Post;

  dbgrd_containerTabelasPersonalizadasExp.Refresh;
  edt_inserirTabelasExp.Clear;
  edt_inserirTabelasExp.SetFocus;
end;

procedure TViewOracleEXP.btn_addTabelasExpClick(Sender: TObject);
var
  NomeTabela: string;
begin
  NomeTabela := Trim(edt_inserirTabelasExp.Text);

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
  dataSet_dbgridExp.Append;
  dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString := UpperCase(NomeTabela);
  dataSet_dbgridExp.Post;

  // Atualiza a tela
  dbgrd_containerTabelasPersonalizadasExp.Refresh;

  // Limpa o campo
  edt_inserirTabelasExp.Clear;
  edt_inserirTabelasExp.SetFocus;
end;
procedure TViewOracleEXP.btn_addTabelasListaClick(Sender: TObject);
var
  MemoForm: TForm;
  MemoInput: TMemo;
  BtnOk, BtnCancel: TButton;
  Lista: TStringList;
  i: Integer;
  NomeTabela: string;
begin
  MemoForm := TForm.Create(nil);
  try
    MemoForm.Caption := 'Adicionar Lista de Tabelas';
    MemoForm.Position := poScreenCenter;
    MemoForm.Width := 600;
    MemoForm.Height := 400;

    MemoInput := TMemo.Create(MemoForm);
    MemoInput.Parent := MemoForm;
    MemoInput.Align := alClient;
    MemoInput.ScrollBars := ssVertical;

    BtnOk := TButton.Create(MemoForm);
    BtnOk.Parent := MemoForm;
    BtnOk.Caption := 'Confirmar';
    BtnOk.ModalResult := mrOk;
    BtnOk.Top := MemoForm.ClientHeight - 45;
    BtnOk.Left := MemoForm.ClientWidth - 180;
    BtnOk.Width := 80;
    BtnOk.Anchors := [akRight, akBottom];

    BtnCancel := TButton.Create(MemoForm);
    BtnCancel.Parent := MemoForm;
    BtnCancel.Caption := 'Cancelar';
    BtnCancel.ModalResult := mrCancel;
    BtnCancel.Cancel := True;
    BtnCancel.Top := BtnOk.Top;
    BtnCancel.Left := BtnOk.Left + BtnOk.Width + 10;
    BtnCancel.Width := 80;
    BtnCancel.Anchors := [akRight, akBottom];

    if MemoForm.ShowModal = mrOk then
    begin
      Lista := TStringList.Create;
      try
        Lista.Text := Trim(MemoInput.Lines.Text);

        for i := 0 to Lista.Count - 1 do
        begin
          NomeTabela := Trim(UpperCase(Lista[i]));
          if (NomeTabela = '') or (FTabelasPersonalizadas.IndexOf(NomeTabela) <> -1) then
            Continue;

          FTabelasPersonalizadas.Add(NomeTabela);
          dataSet_dbgridExp.Append;
          dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString := NomeTabela;
          dataSet_dbgridExp.Post;
        end;

        dbgrd_containerTabelasPersonalizadasExp.Refresh;
        lbl_statusExp.Caption := Format('%d tabelas adicionadas.', [Lista.Count]);
      finally
        Lista.Free;
      end;
    end;
  finally
    MemoForm.Free;
  end;
end;

procedure TViewOracleEXP.btn_addTabelasListaExpClick(Sender: TObject);
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
          if not dataSet_dbgridExp.Active then
          begin
            dataSet_dbgridExp.CreateDataSet;
            dataSet_dbgridExp.Active := True;
          end;

          dataSet_dbgridExp.Append;
          dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString := NomeTabela;
          dataSet_dbgridExp.Post;
        end;

        dbgrd_containerTabelasPersonalizadasExp.Refresh;
        lbl_statusExp.Caption := Format('%d tabelas adicionadas com sucesso.', [Lista.Count]);

      finally
        Lista.Free;
      end;
    end;

  finally
    MemoForm.Free;
  end;
end;

procedure TViewOracleEXP.btn_salvarArquivoClick(Sender: TObject);
var
  PastaInicial: string;
begin
  try
    // Define a pasta inicial padrão (pode ser o último local usado, ou vazia)
    PastaInicial := ExtractFilePath(edt_diretorioArquivoExp.Text);
    if PastaInicial = '' then
      PastaInicial := 'C:\';

    // Chama a função da classe responsável (EXP / EXPDP)
    FOracleExp.SelecionarArquivoDestino(PastaInicial, chk_UtilizarExpDP.Checked);

    // Atualiza a tela com o resultado
    if Trim(FOracleExp.DumpFile) <> '' then
    begin
      edt_diretorioArquivoExp.Text := FOracleExp.DumpFile;
      lbl_status_pastaExp.Caption := 'Arquivo de exportação definido: ' + FOracleExp.DumpFile;
      lbl_statusExp.Caption := 'Caminho definido com sucesso.';
    end
    else
    begin
      lbl_status_pastaExp.Caption := 'Operação cancelada pelo usuário.';
      lbl_statusExp.Caption := 'Nenhum caminho de arquivo definido.';
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao selecionar o local de exportação: ' + E.Message);
      lbl_status_pastaExp.Caption := 'Falha ao definir o arquivo de exportação.';
      lbl_statusExp.Caption := 'Erro detectado.';
    end;
  end;
end;


procedure TViewOracleEXP.btn_excluirItemClick(Sender: TObject);
begin
  if (not dataSet_dbgridExp.Active) or (dataSet_dbgridExp.IsEmpty) then
    Exit;
  FTabelasPersonalizadas.Delete(FTabelasPersonalizadas.IndexOf(dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString));
  dataSet_dbgridExp.Delete;
end;

procedure TViewOracleEXP.btn_excluirItemExpClick(Sender: TObject);
var
  NomeTabela: string;
  Confirmacao: Integer;
begin
  // Verifica se há algo selecionado no dataset
  if (not dataSet_dbgridExp.Active) or (dataSet_dbgridExp.IsEmpty) then
  begin
    ShowMessage('Nenhum item disponível para exclusão.');
    Exit;
  end;

  NomeTabela := dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString;

  // Confirma a exclusão
  Confirmacao := MessageDlg(
    Format('Deseja realmente remover a tabela "%s" da lista?', [NomeTabela]),
    mtConfirmation, [mbYes, mbNo], 0
  );

  if Confirmacao = mrNo then
    Exit;

  // Remove do ClientDataSet
  dataSet_dbgridExp.Delete;

  // Remove também da lista interna (se estiver usando FTabelasPersonalizadas)
  if Assigned(FTabelasPersonalizadas) then
    FTabelasPersonalizadas.Delete(FTabelasPersonalizadas.IndexOf(UpperCase(NomeTabela)));

  // Atualiza o grid
  dbgrd_containerTabelasPersonalizadasExp.Refresh;

  // Mensagem opcional de feedback
  lbl_statusExp.Caption := 'Tabela "' + NomeTabela + '" removida com sucesso.';
end;

procedure TViewOracleEXP.btn_exportarClick(Sender: TObject);
var
  CmdPreview: string;
  LogFileOracle, LogFileSIAC: string;
  ServicoOracle, AliasSelecionado: string;
  ListaTabelas: TStringList;
  ParamTabelas, ListaPreview: string;
  Resultado: Integer;
  LogHeader: TStringList;
  UsuarioSelecionado: string;
  NomeArquivoBase: string;
begin
  try
    // 1. Valida o caminho do arquivo
    if Trim(edt_diretorioArquivoExp.Text) = '' then
    begin
      ShowMessage('Selecione o local para salvar o arquivo .DMP antes de exportar.');
      Exit;
    end;

    // 2. Define propriedades básicas
    FOracleExp.DumpFile := edt_diretorioArquivoExp.Text;

    // Define o usuário selecionado no ComboBox como o usuário de exportação
    if (cbb_userExport.ItemIndex >= 0) and (Trim(cbb_userExport.Text) <> '') then
      FOracleExp.FromUser := Trim(cbb_userExport.Text)
    else
    begin
      ShowMessage('Selecione um usuário Oracle para exportar.');
      Exit;
    end;

    // 3. Determina o alias Oracle
    if cbx_tnsAlias.ItemIndex >= 0 then
    begin
      AliasSelecionado := cbx_tnsAlias.Items[cbx_tnsAlias.ItemIndex];
      ServicoOracle := Trim(Copy(AliasSelecionado, 1, Pos('|', AliasSelecionado) - 1));
    end
    else
      ServicoOracle := FOracleExp.ServidorDB;

    // 4. Define os logs locais
    if not DirectoryExists('C:\SiacDBManagerLogs') then
      ForceDirectories('C:\SiacDBManagerLogs');

    LogFileOracle := Format('C:\SiacDBManagerLogs\Export_%s.log', [FOracleExp.FromUser]);
    LogFileSIAC   := Format('C:\SiacDBManagerLogs\Export_%s_SIAC.log', [FOracleExp.FromUser]);

    // Corrige separadores para o Oracle
    FOracleExp.DumpFile := StringReplace(FOracleExp.DumpFile, '\', '/', [rfReplaceAll]);
    LogFileOracle := StringReplace(LogFileOracle, '\', '/', [rfReplaceAll]);

    // 5. Monta lista TABLES ou EXCLUDE se houver
    ParamTabelas := '';
    ListaPreview := '';

    if chk_tabelasPersonalizadaExp.Checked then
    begin
      if not dataSet_dbgridExp.IsEmpty then
      begin
        ListaTabelas := TStringList.Create;
        try
          dataSet_dbgridExp.First;
          while not dataSet_dbgridExp.Eof do
          begin
            if Trim(dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString) <> '' then
            begin
              // expdp precisa de prefixo com schema, exp não
              if chk_UtilizarExpDP.Checked then
                ListaTabelas.Add(UpperCase(Trim(FOracleExp.FromUser + '.' +
                                 dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString)))
              else
                ListaTabelas.Add(UpperCase(Trim(dataSet_dbgridExp.FieldByName('NOME_TABELA').AsString)));
            end;
            dataSet_dbgridExp.Next;
          end;

          if ListaTabelas.Count > 0 then
          begin
            ListaPreview := StringReplace(ListaTabelas.Text, sLineBreak, ', ', [rfReplaceAll]);

            if cbb_addExcludeExp.ItemIndex = 1 then
              begin
                // --- EXCLUDE ---
                // Apenas para Data Pump (expdp)
                var ListaNomes := TStringList.Create;
                try
                  for var i := 0 to ListaTabelas.Count - 1 do
                    ListaNomes.Add(
                      Copy(ListaTabelas[i], Pos('.', ListaTabelas[i]) + 1, MaxInt)
                    );

                  ParamTabelas := ''; // zera o parâmetro antes de concatenar

                  if chk_UtilizarExpDP.Checked then
                  begin
                    // Gera um EXCLUDE individual para cada tabela no formato correto:
                    // EXCLUDE=TABLE:"IN('CADASTROS')" EXCLUDE=TABLE:"IN('CADASTROS1')"
                    for var i := 0 to ListaNomes.Count - 1 do
                      ParamTabelas := ParamTabelas + ' EXCLUDE=TABLE:"IN(''' + ListaNomes[i] + ''')"';
                  end
                  else
                  begin
                    // Para o modo EXP clássico, ignora o EXCLUDE (não suportado)
                    ParamTabelas := '';
                  end;
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


    // 6. Monta o comando conforme o modo de exportação

    begin
      // Obtém o usuário selecionado no ComboBox
      UsuarioSelecionado := Trim(UpperCase(cbb_userExport.Text));
      if UsuarioSelecionado = '' then
      begin
        ShowMessage('Selecione um usuário Oracle para exportar.');
        Exit;
      end;

      // Cria o nome padrão do arquivo com prefixo EXPORT_
      NomeArquivoBase := Format('EXPORT_%s.DP', [UsuarioSelecionado]);

      // Atualiza o caminho do arquivo .DMP no objeto principal
      FOracleExp.DumpFile := IncludeTrailingPathDelimiter(ExtractFilePath(edt_diretorioArquivoExp.Text)) + NomeArquivoBase;

      // Caso seja modo Data Pump (EXPDP)
      if chk_UtilizarExpDP.Checked then
      begin
        CmdPreview := Format(
          '%s userid=%s/%s@%s DIRECTORY=DATA_PUMP_DIR DUMPFILE=%s LOGFILE=Export_%s.log%s EXCLUDE=STATISTICS EXCLUDE=INDEX EXCLUDE=CONSTRAINT REUSE_DUMPFILES=Y',
        [
          FOracleExp.FerramentaExpDP,
          UsuarioSelecionado,
          DmModule.orsConexao.Password,
          ServicoOracle,
          NomeArquivoBase,
          UsuarioSelecionado,
          ParamTabelas
        ]
        );
      end
      else
      begin
        // Modo EXP (Convencional)
        CmdPreview := Format(
          '%s userid=%s/%s@%s FILE=%s LOG=%s%s BUFFER=65536 COMPRESS=Y GRANTS=Y STATISTICS=NONE INDEXES=N CONSTRAINTS=N ROWS=Y',
          [
            FOracleExp.FerramentaExp,
            UsuarioSelecionado,
            DmModule.orsConexao.Password,
            ServicoOracle,
            FOracleExp.DumpFile,
            LogFileOracle,
            ParamTabelas
          ]
        );
      end;
    end;


    // 7. Cria e registra o cabeçalho do log SIAC
    LogHeader := TStringList.Create;
    try
      if FileExists(LogFileSIAC) then
      begin
        LogHeader.Add('');
        LogHeader.Add('---------------------- NOVA EXECUÇÃO ----------------------');
      end;

      LogHeader.Add('==========================================================');
      LogHeader.Add(' SIAC DB MANAGER - EXPORTAÇÃO DE DADOS ORACLE ');
      LogHeader.Add(' Data/Hora início: ' + DateTimeToStr(Now));
      LogHeader.Add(' Usuário Oracle: ' + DmModule.orsConexao.Username);
      LogHeader.Add(' Servidor: ' + ServicoOracle);
      LogHeader.Add(' Schema Exportado: ' + FOracleExp.FromUser);

      if ListaPreview <> '' then
        LogHeader.Add(' Tabelas selecionadas: ' + ListaPreview);

      if chk_UtilizarExpDP.Checked then
        LogHeader.Add(' Modo: EXPDP (Data Pump)')
      else
        LogHeader.Add(' Modo: EXP (Convencional)');

      LogHeader.Add('----------------------------------------------------------');
      LogHeader.Add(' Comando executado:');
      LogHeader.Add(CmdPreview);
      LogHeader.Add('==========================================================');
      LogHeader.Add('');

      AppendToFile(LogFileSIAC, LogHeader);
    finally
      LogHeader.Free;
    end;

    // 8. Exibe preview e confirmação
    Resultado := MessageDlg(
      'O seguinte comando será executado:' + sLineBreak + sLineBreak +
      CmdPreview + sLineBreak + sLineBreak +
      'Deseja continuar?',
      mtConfirmation, [mbYes, mbNo], 0
    );

    if Resultado = mrNo then
    begin
      ShowMessage('Operação cancelada pelo usuário.');
      Exit;
    end;

    // 9. Executa o comando visivelmente
    FOracleExp.ExecutarComandoVisivel(CmdPreview);

    // 10. Acrescenta rodapé ao log SIAC
    LogHeader := TStringList.Create;
    try
      LogHeader.Add('');
      LogHeader.Add('==========================================================');
      LogHeader.Add(' Procedimento Finalizado com sucesso!');
      LogHeader.Add(' Data/Hora término: ' + DateTimeToStr(Now));
      LogHeader.Add('==========================================================');
      AppendToFile(LogFileSIAC, LogHeader);
    finally
      LogHeader.Free;
    end;

    // 11. Feedback final
    ShowMessage(
      'Exportação concluída com sucesso!' + sLineBreak +
      'Verifique os logs:' + sLineBreak +
      '- Oracle: ' + LogFileOracle + sLineBreak +
      '- SIAC: ' + LogFileSIAC
    );

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao iniciar exportação: ' + E.Message);
      lbl_statusExp.Caption := 'Erro durante o processo de exportação.';
    end;
  end;
end;



procedure TViewOracleEXP.dbgrd_containerTabelasPersonalizadasExpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    btn_excluirItemClick(btn_excluirItemExp);
end;

procedure TViewOracleEXP.edt_inserirTabelasExpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_addTabelasClick(btn_addTabelasExp);
end;

procedure TViewOracleEXP.CarregarAliasesOracleExp;
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
  ListaTNS := FOracleExp.GetTnsAliases;
  FoundIndex := -1;

  try
    if ListaTNS.Count = 0 then
    begin
      ShowMessage('Nenhum alias Oracle encontrado no arquivo TNSNAMES.ORA.');
      Exit;
    end;

    // Pega o servidor atual (onde o Delphi está conectado)
    ServidorAtual := Trim(FOracleExp.ServidorDB);
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
    lbl_statusExp.Caption := Format(
      'Servidor logado: %s  →  TNS selecionado: %s',
      [ServidorAtual, cbx_tnsAlias.Text]
    );

  finally
    ListaTNS.Free;
  end;
end;

procedure TViewOracleEXP.CarregarListaUsuariosExport;
var
  Qry: TOraQuery;
  UsuarioLogado, UsuarioLista: string;
  ListaUsuarios: TStringList;
  i: Integer;
begin
  // Limpa o ComboBox antes de popular
  cbb_userExport.Clear;

  ListaUsuarios := TStringList.Create;
  Qry := TOraQuery.Create(nil);
  try
    try
      Qry.Session := DmModule.orsConexao;

      // Executa a consulta SQL para buscar todos os usuários válidos
      Qry.SQL.Text :=
        'SELECT C.USERNAME ' +
        '  FROM DBA_USERS C ' +
        ' WHERE C.DEFAULT_TABLESPACE NOT IN (''SYSTEM'', ''SYSAUX'') ' +
        '   AND C.USER_ID BETWEEN 100 AND 700 ' +
        ' ORDER BY C.USERNAME';
      Qry.Open;

      // Captura o nome do usuário atualmente logado
      UsuarioLogado := UpperCase(Trim(DmModule.orsConexao.Username));

      // Adiciona o usuário logado como o primeiro item do ComboBox
      if UsuarioLogado <> '' then
        cbb_userExport.Items.Add(UsuarioLogado);

      // Percorre o resultado da query e adiciona os demais usuários à lista temporária
      while not Qry.Eof do
      begin
        UsuarioLista := UpperCase(Trim(Qry.FieldByName('USERNAME').AsString));

        // Evita adicionar novamente o usuário logado
        if not SameText(UsuarioLista, UsuarioLogado) then
          ListaUsuarios.Add(UsuarioLista);

        Qry.Next;
      end;

      // Adiciona os usuários restantes ao ComboBox
      for i := 0 to ListaUsuarios.Count - 1 do
        cbb_userExport.Items.Add(ListaUsuarios[i]);

      // Define o primeiro item (usuário logado) como selecionado por padrão
      if cbb_userExport.Items.Count > 0 then
        cbb_userExport.ItemIndex := 0;

      // Exibe um status informativo na tela
      lbl_statusExp.Caption :=
        Format('Foram carregados %d usuários Oracle. (Padrão: %s)',
          [cbb_userExport.Items.Count, UsuarioLogado]);

    except
      on E: Exception do
      begin
        ShowMessage('Erro ao carregar lista de usuários Oracle: ' + E.Message);
        lbl_statusExp.Caption := 'Falha ao carregar usuários.';
      end;
    end;

  finally
    Qry.Free;
    ListaUsuarios.Free;
  end;
end;


procedure TViewOracleEXP.AdicionarTabelaPersonalizada(const NomeTabela: string);
begin
  if Trim(NomeTabela) = '' then
    Exit;
  if FTabelasPersonalizadas.IndexOf(UpperCase(NomeTabela)) = -1 then
  begin
    FTabelasPersonalizadas.Add(UpperCase(NomeTabela));
    dbgrd_containerTabelasPersonalizadasExp.DataSource.DataSet.AppendRecord([UpperCase(NomeTabela)]);
  end;
end;

end.

