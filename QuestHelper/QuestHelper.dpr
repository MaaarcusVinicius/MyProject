program QuestHelper;

uses
  Vcl.Forms,
  UPrincipal in 'Fontes\UPrincipal.pas' {frmPrincipal},
  classe.Conexao in 'Fontes\classe.Conexao.pas',
  DataModuloOracle in 'Fontes\DataModuloOracle.pas' {SetOracle: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TSetOracle, SetOracle);
  Application.Run;
end.
