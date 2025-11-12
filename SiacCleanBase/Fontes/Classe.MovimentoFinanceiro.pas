unit Classe.MovimentoFinanceiro;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls; // Adiciona aqui!

type
  TClasseMovimentoFinanceiro = class
  private
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
      rgModo, rgStatus: TRadioGroup;
      const CheckBoxes: array of TCheckBox;
      const MaskEdits: array of TMaskEdit);

    // finaliza (libera a instância e remove eventos)
    class procedure FinalizarComportamentos;

    // retorna qual período está selecionado
    class function ObterPeriodoSelecionado: string;
  end;

implementation

{ TClasseMovimentoFinanceiro }

constructor TClasseMovimentoFinanceiro.Create;
begin
  inherited;
end;

destructor TClasseMovimentoFinanceiro.Destroy;
begin
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
  rgModo, rgStatus: TRadioGroup; const CheckBoxes: array of TCheckBox;
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

  inst.FRgModo := rgModo;
  inst.FRgStatus := rgStatus;

  for i := 0 to 3 do
    inst.FChecks[i] := CheckBoxes[i];

  for i := 0 to 3 do
  begin
    inst.FMaskEdits[i,0] := MaskEdits[i*2];
    inst.FMaskEdits[i,1] := MaskEdits[i*2 + 1];
  end;

  if Assigned(rgModo) then
    rgModo.OnClick := inst.HandleRadioModoClick;

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

end.

