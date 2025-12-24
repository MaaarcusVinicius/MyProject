program SiacDBManager;

uses
  Vcl.Forms,
  uViewMain in 'uViewMain.pas' {ViewMain},
  uDataModule in 'uDataModule.pas' {DmModule: TDataModule},
  uViewlogin in 'uViewlogin.pas' {form_login},
  uViewMensagens in 'uViewMensagens.pas' {ViewMensagens},
  Classe.funcoes in 'Classe.funcoes.pas',
  uViewProgressBar in 'uViewProgressBar.pas' {frmProgressBar},
  Classe.ProgressHelper in 'Classe.ProgressHelper.pas',
  classe.uScriptGeneratorTriggers in 'classe.uScriptGeneratorTriggers.pas',
  classe.uScriptGeneratorDeleteEmpresas in 'classe.uScriptGeneratorDeleteEmpresas.pas',
  classe.uScriptGeneratorTrocaEmpresas in 'classe.uScriptGeneratorTrocaEmpresas.pas',
  classe.BancoDados in 'classe.BancoDados.pas',
  Classe.DBA.Oracle in 'Classe.DBA.Oracle.pas',
  Classe.AtualizaComponentesTela in 'Classe.AtualizaComponentesTela.pas',
  TelaAguarde in 'C:\sistemas\Repositorio\TelaAguarde.pas' {FormTelaAguarde},
  Classe.ConsultaEmpresa in 'Classe.ConsultaEmpresa.pas',
  Classe.MovimentoFinanceiro in 'Classe.MovimentoFinanceiro.pas',
  Classe.LimparMovimento in 'Classe.LimparMovimento.pas',
  Classe.EmailLogs in 'Classe.EmailLogs.pas',
  Api.Base in 'Api.Base.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
    begin

     form_login := Tform_login.Create(nil);
     form_login.ShowModal;

     form_login.Hide;
     form_login.Free;

    end;
  Application.CreateForm(TViewMain, ViewMain);
  Application.CreateForm(TViewMensagens, ViewMensagens);
  // Application.CreateForm(TfrmProgressBar, frmProgressBar);
  Application.CreateForm(TFormTelaAguarde, FormTelaAguarde);

  Application.CreateForm(TDmModule, DmModule);
  Application.Run;
end.
