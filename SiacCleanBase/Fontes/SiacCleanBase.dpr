program SiacCleanBase;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  _Biblioteca in 'C:\Sistemas\Repositorio\_Biblioteca.pas',
  VarGlobal in 'C:\Sistemas\Repositorio\VarGlobal.pas',
  uDataModule in 'uDataModule.pas' {DmModule: TDataModule},
  uViewlogin in 'uViewlogin.pas' {form_login},
  unit_empresasDados in 'unit_empresasDados.pas' {form_empresaDados},
  uViewMensagens in 'uViewMensagens.pas' {ViewMensagens},
  Classe.funcoes in 'Classe.funcoes.pas',
  classe.uScriptGeneratorTriggers in 'classe.uScriptGeneratorTriggers.pas',
  uViewProgressBar in 'uViewProgressBar.pas' {frmProgressBar},
  Classe.ProgressHelper in 'Classe.ProgressHelper.pas',
  classe.uScriptGeneratorDeleteEmpresas in 'classe.uScriptGeneratorDeleteEmpresas.pas',
  classe.uScriptGeneratorTrocaEmpresas in 'classe.uScriptGeneratorTrocaEmpresas.pas',
  uViewMain in 'uViewMain.pas' {ViewMain},
  classe.BancoDados in 'classe.BancoDados.pas',
  Classe.ConsultaBD in 'Classe.ConsultaBD.pas';

{$R *.res}

begin
  Application.Initialize;
  {Application.MainFormOnTaskbar := True;
    begin

     form_login := Tform_login.Create(nil);
     form_login.ShowModal;

     form_login.Hide;
     form_login.Free;

    end;    }
  Application.CreateForm(TViewMain, ViewMain);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TViewMensagens, ViewMensagens);
  Application.CreateForm(TfrmProgressBar, frmProgressBar);
  // Ativando o Tpanel com imagem opaca, significa que esta com o banco desconectado
     Principal.frmPrincipal.pnl_fundo_opacidade.Visible := true;
     Principal.frmPrincipal.pnl_fundo_normal.Visible := false;

  Application.CreateForm(TDmModule, DmModule);
  Application.Run;
end.
