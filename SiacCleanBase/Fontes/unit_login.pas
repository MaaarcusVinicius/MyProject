unit unit_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.StdCtrls, Vcl.Buttons, ACBrBase, ACBrEnterTab, Vcl.Imaging.pngimage, unit_containerLogin;

type
  Tform_login = class(TForm)
    pnl_fundo: TPanel;
    img_login: TImage;
    pnl_uLogin: TPanel;
    pnl_userName: TPanel;
    lbl_userName: TLabel;
    img_user: TImage;
    pnl_linhaUserName: TPanel;
    edt_userName: TEdit;
    pnl_userSenha: TPanel;
    lbl__userSenha: TLabel;
    img_password: TImage;
    pnl_linhaUserSenha: TPanel;
    edt_userSenha: TEdit;
    pnl_botaoLogin: TPanel;
    btn_confirmaLogin: TSpeedButton;
    btn_fechar: TSpeedButton;
    procedure btn_confirmaLoginClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_userSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_login: Tform_login;

implementation

uses
  unit_Main;

{$R *.dfm}

procedure Tform_login.btn_confirmaLoginClick(Sender: TObject);
begin
  if ( edt_userName.Text = 'ADM' ) AND ( edt_userSenha.text = 'ADM' ) then
  begin
     Close;
  end else
  ShowMessage('Usuário ou Senha Inválido, por favor verifique!!');

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

procedure Tform_login.FormShow(Sender: TObject);
var
  Overlay: TForm;
  form_translucent: Tform_translucent;

begin
 { // cria overlay translúcido que cobre toda a tela
  Overlay := TForm.Create(Self);
    form_translucent := form_translucent.Create(Self);

  try
    Overlay.BorderStyle := bsNone;
    Overlay.Color := clBlack;
    Overlay.AlphaBlend := True;
    Overlay.AlphaBlendValue := 80; // translucidez do fundo
    Overlay.SetBounds(0, 0, Screen.Width, Screen.Height);
    Overlay.FormStyle := fsStayOnTop;
    Overlay.Show;
    Overlay.Update;

    // cria e mostra form_translucent centralizado sobre o overlay
    //form_translucent := form_translucent.Create(nil);
    try
      form_translucent.Position := poDesigned;
      form_translucent.BorderStyle := bsDialog;
      form_translucent.Width := Screen.Width * 2;
      form_translucent.Height := Screen.Height * 2;
      form_translucent.Left := (Screen.Width + form_translucent.Width) * 2;
      form_translucent.Top := (Screen.Height + form_translucent.Height) * 2;
      form_translucent.ShowModal;
    finally
      form_translucent.Free;
    end;

  finally
    Overlay.Free;
  end;           }
end;


end.
