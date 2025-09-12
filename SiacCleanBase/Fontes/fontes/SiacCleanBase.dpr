program SiacCleanBase;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  _Biblioteca in 'C:\Sistemas\Repositorio\_Biblioteca.pas',
  uDataModule in 'uDataModule.pas' {DmModule: TDataModule},
  VarGlobal in 'C:\Sistemas\Repositorio\VarGlobal.pas',
  unit_login in 'unit_login.pas' {form_login},
  unit_principalDados in 'unit_principalDados.pas' {form_principalDados},
  unit_funcoes in 'unit_funcoes.pas',
  unit_mensagens in 'unit_mensagens.pas' {form_menssagens},
  form_consultaEmpresas in 'form_consultaEmpresas.pas' {Form1};

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
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(Tform_menssagens, form_menssagens);
  Application.CreateForm(TForm1, Form1);
  // Ativando o Tpanel com imagem opaca, significa que esta com o banco desconectado
     Principal.frmPrincipal.pnl_fundo_opacidade.Visible := true;
     Principal.frmPrincipal.pnl_fundo_normal.Visible := false;
     Principal.frmPrincipal.pnl_editEmpresa.Visible := False;
  Application.CreateForm(TDmModule, DmModule);
  Application.Run;
end.
