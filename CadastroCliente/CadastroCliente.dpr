program CadastroCliente;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {FrmPrincipal},
  Unit_DM in 'Unit_DM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
