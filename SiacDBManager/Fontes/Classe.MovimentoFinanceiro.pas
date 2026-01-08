unit Classe.MovimentoFinanceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.StrUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask, classe.BancoDados,
  uViewlogin, Classe.ProgressHelper, uViewMensagens, uViewProgressBar, Classe.EmailLogs;

type
  TClasseMovimentoFinanceiro = class
  private
    FCarregarMovimentoFinanceiro: TClasseBancoDados;
    FCarregarCreditoFinanceiro  : TClasseBancoDados;
    class var FInstance: TClasseMovimentoFinanceiro;

    FRgModo: TRadioGroup;
    FRgStatus: TRadioGroup;
    FChecks: array[0..3] of TCheckBox;
    FMaskEdits: array[0..3, 0..1] of TMaskEdit;

    procedure HandleRadioModoClick(Sender: TObject);
    procedure HandleCheckBoxClick(Sender: TObject);
    procedure AtualizarMaskEdits;
    procedure AssignCheckHandlers(AOn: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    class procedure InicializarComportamentos(
      rgStatus: TRadioGroup;
      const CheckBoxes: array of TCheckBox;
      const MaskEdits: array of TMaskEdit);
    class procedure FinalizarComportamentos;
    class function ObterPeriodoSelecionado: string;

    procedure CarregarMovimentoFinanceiro(ADBGrid: TDBGrid; const AEmpresaID: String;
      const ATipoContaIndex: Integer; const AStatusIndex: Integer;
      const AFiltroPeriodoIndex: Integer);

    procedure LimparPedidoTitulos(const ARowID: String);
    procedure LimparNossoNumero(const ARowID: String);
    procedure AlterarDocumentoID(const ARowID, ADocumentoAtual, ATextoAdicional: String;
      const AModoTexto: Integer);

    procedure AplicarAlteracoesEmLote(
      ADataset: TDataSet;
      const ALimparPedido, ALimparNossoNumero, AAlterarDoc: Boolean;
      const ATextoAdicional: String; const AModoTexto: Integer);
    procedure ExcluirRegistrosFinanceiro(ADataset: TDataSet);
    procedure CarregarCreditosFinanceiro(
      const AEmpresaID: string;
      const FiltroData: Boolean;
      const ADataIni, ADataFim: TDateTime);
    procedure ExcluirCreditosFinanceiro(const FiltroData: Boolean);
  end;

implementation

uses
  uDataModule, uViewMain, Classe.funcoes;

{ TClasseMovimentoFinanceiro }

constructor TClasseMovimentoFinanceiro.Create;
begin
  FCarregarMovimentoFinanceiro := TClasseBancoDados.Create(DmModule.orsConexao);
  FCarregarCreditoFinanceiro := TClasseBancoDados.Create(DmModule.orsConexao);
  inherited;
end;

destructor TClasseMovimentoFinanceiro.Destroy;
begin
  FCarregarMovimentoFinanceiro.Free;
  FCarregarCreditoFinanceiro.Free;
  inherited;
end;

procedure TClasseMovimentoFinanceiro.AssignCheckHandlers(AOn: Boolean);
var
  i: Integer;
begin
  for i := 0 to 3 do
  begin
    if Assigned(FChecks[i]) then
    begin
      if AOn then
        FChecks[i].OnClick := HandleCheckBoxClick
      else
        FChecks[i].OnClick := nil;
    end;
  end;
end;

procedure TClasseMovimentoFinanceiro.HandleRadioModoClick(Sender: TObject);
begin
  if Assigned(FRgStatus) and Assigned(FRgModo) then
    FRgStatus.Enabled := (FRgModo.ItemIndex = 1);
end;

procedure TClasseMovimentoFinanceiro.HandleCheckBoxClick(Sender: TObject);
var
  Clicked: TCheckBox;
  i: Integer;
begin
  if not (Sender is TCheckBox) then Exit;
  Clicked := TCheckBox(Sender);

  AssignCheckHandlers(False);
  try
    if Clicked.Checked then
    begin
      for i := 0 to 3 do
        FChecks[i].Checked := (FChecks[i] = Clicked);
    end
    else
    begin
      for i := 0 to 3 do
        FChecks[i].Checked := False;
    end;
  finally
    AssignCheckHandlers(True);
  end;

  AtualizarMaskEdits;
end;

procedure TClasseMovimentoFinanceiro.AtualizarMaskEdits;
var
  i: Integer;
begin
  for i := 0 to 3 do
  begin
    if Assigned(FMaskEdits[i, 0]) then
      FMaskEdits[i, 0].Enabled := FChecks[i].Checked;
    if Assigned(FMaskEdits[i, 1]) then
      FMaskEdits[i, 1].Enabled := FChecks[i].Checked;
  end;
end;

class procedure TClasseMovimentoFinanceiro.InicializarComportamentos(
  rgStatus: TRadioGroup;
  const CheckBoxes: array of TCheckBox;
  const MaskEdits: array of TMaskEdit);
var
  inst: TClasseMovimentoFinanceiro;
  i: Integer;
begin
  if (Length(CheckBoxes) <> 4) or (Length(MaskEdits) <> 8) then
    raise Exception.Create('Número incorreto de controles informados.');

  if Assigned(FInstance) then
    FreeAndNil(FInstance);

  inst := TClasseMovimentoFinanceiro.Create;
  FInstance := inst;

  inst.FRgStatus := rgStatus;

  for i := 0 to 3 do
    inst.FChecks[i] := CheckBoxes[i];

  for i := 0 to 3 do
  begin
    inst.FMaskEdits[i, 0] := MaskEdits[i * 2];
    inst.FMaskEdits[i, 1] := MaskEdits[i * 2 + 1];
  end;

  inst.AssignCheckHandlers(True);
  inst.AtualizarMaskEdits;
end;

class procedure TClasseMovimentoFinanceiro.FinalizarComportamentos;
begin
  if Assigned(FInstance) then
  begin
    if Assigned(FInstance.FRgModo) then
      FInstance.FRgModo.OnClick := nil;
    FInstance.AssignCheckHandlers(False);
    FreeAndNil(FInstance);
  end;
end;

class function TClasseMovimentoFinanceiro.ObterPeriodoSelecionado: string;
begin
  Result := '';
  if not Assigned(FInstance) then Exit;

  if FInstance.FChecks[0].Checked then Result := 'CADASTRAMENTO'
  else if FInstance.FChecks[1].Checked then Result := 'EMISSAO'
  else if FInstance.FChecks[2].Checked then Result := 'VENCIMENTO'
  else if FInstance.FChecks[3].Checked then Result := 'BAIXA';
end;

procedure TClasseMovimentoFinanceiro.CarregarMovimentoFinanceiro(
  ADBGrid: TDBGrid; const AEmpresaID: String; const ATipoContaIndex,
  AStatusIndex, AFiltroPeriodoIndex: Integer);
var
  LDataIni, LDataFim: TDateTime;
  HasAnyCheck, HasAnyDate: Boolean;
  i: Integer;
begin
  FCarregarMovimentoFinanceiro.SetSQL(
    ' SELECT F.EMPRESA_ID, ' +
    '        F.TIPO_CONTA, ' +
    '        F.TIPO_DOC, ' +
    '        F.CADASTRO_ID, ' +
    '        F.COMPL_CADASTRO_ID AS COMPL, ' +
    '        NVL(NVL(C.FANTASIA,C.RAZAO_SOCIAL),''CADASTRO NÃO ENCONTRADO'') AS CLIENTE, ' +
    '        F.DOCUMENTO_ID, ' +
    '        F.PEDIDO_ID, ' +
    '        F.VLR_TITULO, ' +
    '        F.STATUS, ' +
    '        trunc(F.DT_CADASTRAMENTO) as DT_CADASTRAMENTO, ' +
    '        F.DT_EMISSAO, ' +
    '        F.DT_VENCTO, ' +
    '        F.DT_BAIXA, ' +
    '        F.ROWID ' +
    '   FROM FINANCEIRO F, CADASTROS C ' +
    '  WHERE F.CADASTRO_ID = C.CADASTRO_ID (+) ' +
    '    AND F.COMPL_CADASTRO_ID = C.COMPL_CADASTRO_ID (+) ' +
    '    AND F.EMPRESA_ID = :vEMPRESA_ID ');

  FCarregarMovimentoFinanceiro.AddParam('vEMPRESA_ID', AEmpresaID);

  // Tipo de conta
  case ATipoContaIndex of
    0: FCarregarMovimentoFinanceiro.AddSQL('AND F.TIPO_CONTA IN (''CR'',''CP'')');
    1: FCarregarMovimentoFinanceiro.AddSQL('AND F.TIPO_CONTA = ''CR''');
    2: FCarregarMovimentoFinanceiro.AddSQL('AND F.TIPO_CONTA = ''CP''');
  end;

  // Status
  case AStatusIndex of
    1: FCarregarMovimentoFinanceiro.AddSQL('AND F.STATUS = ''A''');
    2: FCarregarMovimentoFinanceiro.AddSQL('AND F.STATUS IN (''B'',''C'')');
    3: FCarregarMovimentoFinanceiro.AddSQL('AND F.STATUS = ''D''');
    4: FCarregarMovimentoFinanceiro.AddSQL('AND F.STATUS = ''P''');
  end;

  //  Filtro por período (agora funcional)
  if AFiltroPeriodoIndex = 1 then
  begin
    if Assigned(FInstance) then
    begin
      HasAnyCheck := False;
      HasAnyDate := False;

      for i := 0 to 3 do
        if FInstance.FChecks[i].Checked then
          HasAnyCheck := True;

      if not HasAnyCheck then
      begin
        MessageDlg('Selecione pelo menos um tipo de data.', mtWarning, [mbOK], 0);
        Exit;
      end;

      for i := 0 to 3 do
      begin
        if FInstance.FChecks[i].Checked then
        begin
          if TryStrToDate(FInstance.FMaskEdits[i, 0].Text, LDataIni) and
             TryStrToDate(FInstance.FMaskEdits[i, 1].Text, LDataFim) then
          begin
            HasAnyDate := True;

            case i of
              0: FCarregarMovimentoFinanceiro.AddSQL('AND F.DT_CADASTRAMENTO BETWEEN :pDataIni AND :pDataFim');
              1: FCarregarMovimentoFinanceiro.AddSQL('AND F.DT_EMISSAO BETWEEN :pDataIni AND :pDataFim');
              2: FCarregarMovimentoFinanceiro.AddSQL('AND F.DT_VENCTO BETWEEN :pDataIni AND :pDataFim');
              3: FCarregarMovimentoFinanceiro.AddSQL('AND F.DT_BAIXA BETWEEN :pDataIni AND :pDataFim');
            end;

            FCarregarMovimentoFinanceiro.AddParam('pDataIni', LDataIni);
            FCarregarMovimentoFinanceiro.AddParam('pDataFim', LDataFim);
            Break; // só um tipo de data será usado
          end;
        end;
      end;

      if not HasAnyDate then
      begin
        MessageDlg('Informe uma data inicial e final válidas.', mtError, [mbOK], 0);
        Exit;
      end;
    end;
  end;

  FCarregarMovimentoFinanceiro.AddSQL('ORDER BY F.DT_VENCTO');
  FCarregarMovimentoFinanceiro.ExecutarConsulta;
  ADBGrid.DataSource := FCarregarMovimentoFinanceiro.GetDataSource;
end;


procedure TClasseMovimentoFinanceiro.CarregarCreditosFinanceiro(
  const AEmpresaID: string;
  const FiltroData: Boolean;
  const ADataIni, ADataFim: TDateTime);
begin
  if not Assigned(FCarregarCreditoFinanceiro) then
    FCarregarCreditoFinanceiro := TClasseBancoDados.Create(DmModule.orsConexao);

  if FCarregarCreditoFinanceiro.GetQuery.Active then
    FCarregarCreditoFinanceiro.GetQuery.Close;

  FCarregarCreditoFinanceiro.SetSQL(
    'SELECT C.CREDITO_ID ' +
    '  FROM CREDITOS C ' +
    ' WHERE C.EMPRESA_ID = :vEMPRESA_ID ');

  FCarregarCreditoFinanceiro.AddParam('vEMPRESA_ID', AEmpresaID);

  if FiltroData then
  begin
    FCarregarCreditoFinanceiro.AddSQL('AND C.DATA_CADASTRO BETWEEN :pDataIni AND :pDataFim');
    FCarregarCreditoFinanceiro.AddParam('pDataIni', ADataIni);
    FCarregarCreditoFinanceiro.AddParam('pDataFim', ADataFim);
  end
  else
    FCarregarCreditoFinanceiro.AddSQL('-- Filtro de data desativado');

  FCarregarCreditoFinanceiro.AddSQL('ORDER BY C.DATA_CADASTRO DESC');
  FCarregarCreditoFinanceiro.ExecutarConsulta;

  // Garantia adicional
  if not FCarregarCreditoFinanceiro.GetQuery.Active then
    FCarregarCreditoFinanceiro.GetQuery.Open;
end;

procedure TClasseMovimentoFinanceiro.LimparPedidoTitulos(const ARowID: String);
begin
  if Trim(ARowID) = '' then
  begin
    MessageDlg('Nenhum registro selecionado para limpar o campo PEDIDO_ID.', mtWarning, [mbOK], 0);
    Exit;
  end;

  try
    FCarregarMovimentoFinanceiro.SetSQL(
      'UPDATE FINANCEIRO F SET F.PEDIDO_ID = '''' WHERE F.ROWID = :AROWID');
    FCarregarMovimentoFinanceiro.AddParam('AROWID', ARowID);
    FCarregarMovimentoFinanceiro.ExecutarComando;
  except
    on E: Exception do
      MessageDlg('Erro ao limpar o campo PEDIDO_ID: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TClasseMovimentoFinanceiro.LimparNossoNumero(const ARowID: String);
begin
  if Trim(ARowID) = '' then
  begin
    MessageDlg('Nenhum registro selecionado para limpar o campo NOSSO_NUMERO.', mtWarning, [mbOK], 0);
    Exit;
  end;

  try
    FCarregarMovimentoFinanceiro.SetSQL(
      'UPDATE FINANCEIRO F SET F.NOSSO_NUMERO = '''' WHERE F.ROWID = :AROWID');
    FCarregarMovimentoFinanceiro.AddParam('AROWID', ARowID);
    FCarregarMovimentoFinanceiro.ExecutarComando;
  except
    on E: Exception do
      MessageDlg('Erro ao limpar o campo NOSSO_NUMERO: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TClasseMovimentoFinanceiro.AlterarDocumentoID(
  const ARowID, ADocumentoAtual, ATextoAdicional: String;
  const AModoTexto: Integer);
var
  NovoDocumento: String;
begin
  if Trim(ARowID) = '' then
  begin
    MessageDlg('Nenhum registro selecionado para alterar o DOCUMENTO_ID.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if Trim(ATextoAdicional) = '' then
  begin
    MessageDlg('Digite um texto adicional.', mtWarning, [mbOK], 0);
    Exit;
  end;

  case AModoTexto of
    0: NovoDocumento := ADocumentoAtual + ' ' + ATextoAdicional;
    1: NovoDocumento := ATextoAdicional + ' ' + ADocumentoAtual;
  else
    NovoDocumento := ADocumentoAtual;
  end;

  try
    FCarregarMovimentoFinanceiro.SetSQL(
      'UPDATE FINANCEIRO F SET F.DOCUMENTO_ID = :PDOCUMENTO_ID WHERE F.ROWID = :AROWID');
    FCarregarMovimentoFinanceiro.AddParam('PDOCUMENTO_ID', NovoDocumento);
    FCarregarMovimentoFinanceiro.AddParam('AROWID', ARowID);
    FCarregarMovimentoFinanceiro.ExecutarComando;
  except
    on E: Exception do
      MessageDlg('Erro ao alterar DOCUMENTO_ID: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TClasseMovimentoFinanceiro.AplicarAlteracoesEmLote(
  ADataset: TDataSet; const ALimparPedido, ALimparNossoNumero, AAlterarDoc: Boolean;
  const ATextoAdicional: String; const AModoTexto: Integer);
var
  RowID, DocumentoAtual: String;
begin
  if not Assigned(ADataset) or ADataset.IsEmpty then
  begin
    MessageDlg('Nenhum registro disponível para processamento.', mtWarning, [mbOK], 0);
    Exit;
  end;

  try
    FCarregarMovimentoFinanceiro.IniciarTransacao;
    ADataset.DisableControls;
    ADataset.First;

    while not ADataset.Eof do
    begin
      RowID := ADataset.FieldByName('ROWID').AsString;
      DocumentoAtual := ADataset.FieldByName('DOCUMENTO_ID').AsString;

      if ALimparPedido then
        LimparPedidoTitulos(RowID);

      if ALimparNossoNumero then
        LimparNossoNumero(RowID);

      if AAlterarDoc then
        AlterarDocumentoID(RowID, DocumentoAtual, ATextoAdicional, AModoTexto);

      ADataset.Next;
    end;

    FCarregarMovimentoFinanceiro.ConfirmarTransacao;
    MessageDlg('Alterações aplicadas com sucesso a todos os registros exibidos.', mtInformation, [mbOK], 0);
  except
    on E: Exception do
    begin
      FCarregarMovimentoFinanceiro.CancelarTransacao;
      MessageDlg('Erro ao aplicar alterações: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;

  ADataset.EnableControls;
end;

procedure TClasseMovimentoFinanceiro.ExcluirRegistrosFinanceiro(ADataset: TDataSet);
var
  RowID, EmpresaID, DocumentoID: String;
  Total, Contador, Percentual: Integer;
  Progress: TProgressHelper;
  StartTime, Elapsed: TDateTime;
  RemainingSecs, EstimatedTotalSecs: Double;
  MsgStatus, MsgCaption: String;
  ResultUser: Boolean;
begin
  if not Assigned(ADataset) or ADataset.IsEmpty then
  begin
    MessageDlg('Nenhum registro encontrado para exclusão.', mtWarning, [mbOK], 0);
    Abort;
  end;

  Total := ADataset.RecordCount;
  {
  if MessageDlg(Format('Deseja realmente excluir %d registro(s)?', [Total]),
     mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Abort;    }

  ResultUser := fnc_criar_menssagem('ALERTA',
                                    'EXCLUIR TÍTULOS',
                                    'DESEJA REALMENTE EXLUIR, '+ IntToStr(Total) + ' REGISTRO(s)?',
                                    ExtractFilePath(Application.ExeName) +
                                    'Arquivos\icones\icon_aviso.png', 'ERRO');

  // Se o usuário clicou em "Não" ou "Cancelar", interrompe todo fluxo
  if not ResultUser then
   Abort;


  Progress := TProgressHelper.Create;
  try
    Progress.Start(Total, 'Excluindo registros financeiros...');

    try
      FCarregarMovimentoFinanceiro.IniciarTransacao;
      ADataset.DisableControls;
      ADataset.First;
      Contador := 0;
      StartTime := Now;

      while not ADataset.Eof do
      begin
        Inc(Contador);

        RowID := ADataset.FieldByName('ROWID').AsString;
        EmpresaID := ADataset.FieldByName('EMPRESA_ID').AsString;
        DocumentoID := ADataset.FieldByName('DOCUMENTO_ID').AsString;

        if (Trim(RowID) <> '') and (Trim(EmpresaID) <> '') and (Trim(DocumentoID) <> '') then
        begin
          //  Primeiro: remove os registros vinculados na tabela FINANCEIRO_FLUXO
          FCarregarMovimentoFinanceiro.SetSQL(
            'DELETE FROM FINANCEIRO_FLUXO ' +
            ' WHERE EMPRESA_ID = :PEMPRESA_ID ' +
            '   AND DOCUMENTO_ID = :PDOCUMENTO_ID'
          );
          FCarregarMovimentoFinanceiro.AddParam('PEMPRESA_ID', EmpresaID);
          FCarregarMovimentoFinanceiro.AddParam('PDOCUMENTO_ID', DocumentoID);
          FCarregarMovimentoFinanceiro.ExecutarComando;

          //  Depois: exclui o registro principal da tabela FINANCEIRO
          FCarregarMovimentoFinanceiro.SetSQL(
            'DELETE FROM FINANCEIRO WHERE ROWID = :AROWID'
          );
          FCarregarMovimentoFinanceiro.AddParam('AROWID', RowID);
          FCarregarMovimentoFinanceiro.ExecutarComando;
        end;

        //  Atualização visual do progresso
        if Contador > 1 then
        begin
          Elapsed := (Now - StartTime) * 24 * 60 * 60;
          EstimatedTotalSecs := (Elapsed / Contador) * Total;
          RemainingSecs := EstimatedTotalSecs - Elapsed;

          Percentual := Round((Contador / Total) * 100);
          MsgStatus := Format('Excluindo registro %d de %d...', [Contador, Total]);
          MsgCaption := Format('Excluindo registros... %d%% concluído (~%ds restantes)',
                               [Percentual, Round(RemainingSecs)]);
        end
        else
        begin
          Percentual := 0;
          MsgStatus := Format('Excluindo registro %d de %d...', [Contador, Total]);
          MsgCaption := 'Iniciando exclusão...';
        end;

        Progress.Step(MsgStatus);
        Progress.UpdateCaption(MsgCaption);

        ADataset.Next;
      end;

      FCarregarMovimentoFinanceiro.ConfirmarTransacao;
      MessageDlg('Todos os registros foram excluídos com sucesso.', mtInformation, [mbOK], 0);
    except
      on E: Exception do
      begin
        FCarregarMovimentoFinanceiro.CancelarTransacao;
        MessageDlg('Erro ao excluir registros: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Progress.Finish;
    Progress.Free;
    ADataset.EnableControls;
  end;
end;


procedure TClasseMovimentoFinanceiro.ExcluirCreditosFinanceiro(
  const FiltroData: Boolean);
var
  LCreditoID: String;
  Progress: TProgressHelper;
  Query: TOraQuery;
  Total, Contador: Integer;
  ResultUser: Boolean;
begin
  Progress := TProgressHelper.Create;
  try
    if not FiltroData then
    begin
        ResultUser := fnc_criar_menssagem('ALERTA',
                                          'Você optou por excluir TODOS os créditos (sem filtro de data).',
                                          'Esta ação irá EXCLUIR completamente os dados das tabelas CRÉDITOS' + sLineBreak +
                                          'Deseja continuar?',
                                          ExtractFilePath(Application.ExeName) +
                                          'Arquivos\icones\icon_aviso.png', 'ERRO');

      // Se o usuário clicou em "Não" ou "Cancelar", interrompe todo fluxo
      if not ResultUser then
       Abort;

      try
        Progress.Start(2, 'Executando limpeza total das tabelas de crédito...');
        FCarregarCreditoFinanceiro.IniciarTransacao;

        FCarregarCreditoFinanceiro.SetSQL('TRUNCATE TABLE CREDITOS_MOVIMENTOS');
        FCarregarCreditoFinanceiro.ExecutarComando;
        Progress.Step('Tabela CREDITOS_MOVIMENTOS truncada.');

        FCarregarCreditoFinanceiro.SetSQL('TRUNCATE TABLE CREDITOS');
        FCarregarCreditoFinanceiro.ExecutarComando;
        Progress.Step('Tabela CREDITOS truncada.');

        FCarregarCreditoFinanceiro.ConfirmarTransacao;

        MessageDlg('Todas as tabelas de créditos foram limpas com sucesso.', mtInformation, [mbOK], 0);
      except
        on E: Exception do
        begin
          FCarregarCreditoFinanceiro.CancelarTransacao;
          MessageDlg('Erro ao executar TRUNCATE: ' + E.Message, mtError, [mbOK], 0);
        end;
      end;
      Exit;
    end;

    if not Assigned(FCarregarCreditoFinanceiro) then
    begin
      MessageDlg('Nenhuma consulta de créditos foi carregada.', mtWarning, [mbOK], 0);
      Exit;
    end;

    Query := FCarregarCreditoFinanceiro.GetQuery;
    if not Query.Active then
      Query.Open;

    if Query.IsEmpty then
    begin
      MessageDlg('Nenhum crédito encontrado para exclusão.', mtInformation, [mbOK], 0);
      Exit;
    end;

    Progress.Start(Query.RecordCount, 'Excluindo registros de créditos filtrados...');
    FCarregarCreditoFinanceiro.IniciarTransacao;

    Query.First;
    Contador := 0;

    while not Query.Eof do
    begin
      Inc(Contador);
      LCreditoID := Query.FieldByName('CREDITO_ID').AsString;

      Progress.Step(Format('Excluindo crédito %s (%d/%d)', [LCreditoID, Contador, Query.RecordCount]));

      try
        FCarregarCreditoFinanceiro.SetSQL(
          'DELETE FROM CREDITOS_MOVIMENTOS WHERE CREDITO_ID = :pCreditoID');
        FCarregarCreditoFinanceiro.AddParam('pCreditoID', LCreditoID);
        FCarregarCreditoFinanceiro.ExecutarComando;

        FCarregarCreditoFinanceiro.SetSQL(
          'DELETE FROM CREDITOS WHERE CREDITO_ID = :pCreditoID');
        FCarregarCreditoFinanceiro.AddParam('pCreditoID', LCreditoID);
        FCarregarCreditoFinanceiro.ExecutarComando;

      except
        on E: Exception do
        begin
          FCarregarCreditoFinanceiro.CancelarTransacao;
          MessageDlg('Erro ao excluir o crédito ' + LCreditoID + ': ' + E.Message, mtError, [mbOK], 0);
          Exit;
        end;
      end;

      Query.Next;
    end;

    FCarregarCreditoFinanceiro.ConfirmarTransacao;
    MessageDlg('Exclusão de créditos por período concluída com sucesso.', mtInformation, [mbOK], 0);
  finally
    Progress.Finish;
    Progress.Free;
  end;
end;

end.

