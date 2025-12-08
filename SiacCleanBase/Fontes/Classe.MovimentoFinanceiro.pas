unit Classe.MovimentoFinanceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.StrUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,classe.BancoDados, uViewlogin;

type
  TClasseMovimentoFinanceiro = class
  private
    FCarregarMovimentoFinanceiro : TClasseBancoDados;


    // instância para fornecer method-pointers (event handlers)
    class var FInstance: TClasseMovimentoFinanceiro;

    // referências aos controles (não ownership)
    FRgModo: TRadioGroup;
    FRgStatus: TRadioGroup;
    FChecks: array[0..3] of TCheckBox;
    FMaskEdits: array[0..3, 0..1] of TMaskEdit;

    // event handlers
    procedure HandleRadioModoClick(Sender: TObject);
    procedure HandleCheckBoxClick(Sender: TObject);

    // utilitários
    procedure AtualizarMaskEdits;
    procedure AssignCheckHandlers(AOn: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    // inicializa (cria a instância interna e atribui eventos)
class procedure InicializarComportamentos(
  rgStatus: TRadioGroup;
  const CheckBoxes: array of TCheckBox;
  const MaskEdits: array of TMaskEdit);
    // finaliza (libera a instância e remove eventos)
    class procedure FinalizarComportamentos;
    // retorna qual período está selecionado
    class function ObterPeriodoSelecionado: string;
    procedure CarregarMovimentoFinanceiro(ADBGrid: TDBGrid; const AEmpresaID : String);
  end;

implementation

uses
  uDataModule, uViewMain;

{ TClasseMovimentoFinanceiro }

constructor TClasseMovimentoFinanceiro.Create;
begin
  // Cada objeto TClasseBancoDados é independente (permite múltiplas consultas simultâneas)
  FCarregarMovimentoFinanceiro := TClasseBancoDados.Create(DmModule.orsConexao);


  inherited;
end;

destructor TClasseMovimentoFinanceiro.Destroy;
begin
  FCarregarMovimentoFinanceiro.Free;

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
    if Assigned(FMaskEdits[i,0]) then
      FMaskEdits[i,0].Enabled := FChecks[i].Checked;
    if Assigned(FMaskEdits[i,1]) then
      FMaskEdits[i,1].Enabled := FChecks[i].Checked;
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
  // valida quantidade esperada de controles
  if (Length(CheckBoxes) <> 4) or (Length(MaskEdits) <> 8) then
    raise Exception.Create('Número incorreto de controles informados.');

  // destrói instância anterior
  if Assigned(FInstance) then
    FreeAndNil(FInstance);

  inst := TClasseMovimentoFinanceiro.Create;
  FInstance := inst;

  // agora só existe rgStatus
  inst.FRgStatus := rgStatus;

  // armazena checkboxes
  for i := 0 to 3 do
    inst.FChecks[i] := CheckBoxes[i];

  // armazena mask edits (2 para cada check)
  for i := 0 to 3 do
  begin
    inst.FMaskEdits[i, 0] := MaskEdits[i*2];
    inst.FMaskEdits[i, 1] := MaskEdits[i*2 + 1];
  end;

  // ativa eventos
  inst.AssignCheckHandlers(True);

  // atualiza estado inicial
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


procedure TClasseMovimentoFinanceiro.CarregarMovimentoFinanceiro(ADBGrid: TDBGrid; const AEmpresaID : String);
begin
  FCarregarMovimentoFinanceiro.SetSQL(' SELECT F.EMPRESA_ID, '+
                                      '        F.TIPO_CONTA, '+
                                      '        F.TIPO_DOC, '+
                                      '        F.CADASTRO_ID, '+
                                      '        F.COMPL_CADASTRO_ID AS COMPL, '+
                                      '        NVL(NVL(C.FANTASIA,C.RAZAO_SOCIAL),''CADASTRO NÃO ENCONTRADO'' )AS CLIENTE, '+
                                      '        F.DOCUMENTO_ID, '+
                                      '        F.PEDIDO_ID,  '+
                                      '        F.VLR_TITULO, '+
                                      '        F.STATUS, '+
                                      '        F.DT_CADASTRAMENTO, '+
                                      '        F.DT_EMISSAO, '+
                                      '        F.DT_VENCTO, '+
                                      '        F.DT_BAIXA, '+
                                      '        F.ROWID '+
                                      '   FROM FINANCEIRO F, CADASTROS C '+
                                      '  WHERE F.CADASTRO_ID = C.CADASTRO_ID (+)  '+
                                      '    AND F.COMPL_CADASTRO_ID = C.COMPL_CADASTRO_ID (+) '+
                                      '    AND F.EMPRESA_ID = :vEMPRESA_ID '+
                                      '    ORDER BY F.DT_VENCTO ' );

  // Adiciona o parâmetro corretamente -- EMPRESA_ID --
  FCarregarMovimentoFinanceiro.AddParam('vEMPRESA_ID', AEmpresaID);

  // Adiciona o parâmetro corretamente -- TIPO_DOC --


 // FCarregarMovimentoFinanceiro.AddParam('vEMPRESA_ID', AEmpresaID);

  FCarregarMovimentoFinanceiro.ExecutarConsulta;
  ADBGrid.DataSource := FCarregarMovimentoFinanceiro.GetDataSource;
end;
end.

