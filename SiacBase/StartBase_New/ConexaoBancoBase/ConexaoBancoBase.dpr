program ConexaoBancoBase;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  _Biblioteca in 'C:\Sistemas\Repositorio\_Biblioteca.pas',
  uDataModule in 'uDataModule.pas' {DmModule: TDataModule},
  VarGlobal in 'C:\Sistemas\Repositorio\VarGlobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDmModule, DmModule);
  Application.Run;
end.
