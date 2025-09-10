unit unit_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.StdCtrls, Vcl.Buttons, ACBrBase, ACBrEnterTab, Vcl.Imaging.pngimage;

type
  Tform_login = class(TForm)
    img_login: TImage;
    pnl_uLogin: TPanel;
    pnl_userName: TPanel;
    lbl_userName: TLabel;
    pnl_linhaUserName: TPanel;
    edt_userName: TEdit;
    pnl_userSenha: TPanel;
    lbl__userSenha: TLabel;
    pnl_linhaUserSenha: TPanel;
    edt_userSenha: TEdit;
    btn_fechar: TSpeedButton;
    pnl_botaoLogin: TPanel;
    btn_confirmaLogin: TSpeedButton;
    img_password: TImage;
    img_user: TImage;
    procedure btn_confirmaLoginClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_userSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_login: Tform_login;

implementation

{$R *.dfm}

procedure Tform_login.btn_confirmaLoginClick(Sender: TObject);
begin
  if ( edt_userName.Text = 'ADM' ) AND ( edt_userSenha.text = 'ADM' ) then
  begin
     Close;
  end else
  ShowMessage('Usuário ou Senha Inválido, por favor verifique!!');
//  Application.Terminate;
end;

procedure Tform_login.btn_fecharClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure Tform_login.edt_userSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    btn_confirmaLoginClick( Self );
end;

procedure Tform_login.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = Vk_Return then
    Perform(40,0,0);

  if key = VK_ESCAPE then
     Application.Terminate;

  // Verifica se o usuário pressionou ALT + F4
  if (Key = VK_F4) and (ssAlt in Shift) then
  begin
    Application.Terminate;
  end;
end;

end.
