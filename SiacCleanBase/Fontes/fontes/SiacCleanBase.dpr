program SiacCleanBase;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  _Biblioteca in 'C:\Sistemas\Repositorio\_Biblioteca.pas',
  uDataModule in 'uDataModule.pas' {DmModule: TDataModule},
  VarGlobal in 'C:\Sistemas\Repositorio\VarGlobal.pas',
  unit_login in 'unit_login.pas' {form_login},
  unit_principalDados in 'unit_principalDados.pas' {form_principalDados};

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
     // Ativando o Tpanel com imagem opaca, significa que esta com o banco desconectado
     Principal.frmPrincipal.pnl_fundo_opacidade.Visible := true;
     Principal.frmPrincipal.pnl_fundo_normal.Visible := false;

  Application.CreateForm(TDmModule, DmModule);
  Application.Run;
end.
