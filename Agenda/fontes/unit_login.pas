unit unit_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  frxSVGGraphic, Vcl.Buttons, Vcl.Imaging.pngimage, unit_dados;

type
  Tform_login = class(TForm)
    pnl_fundo: TPanel;
    pnl_lateral: TPanel;
    pnl_userName: TPanel;
    lbl_userName: TLabel;
    pnl_linhaUserName: TPanel;
    edt_userName: TEdit;
    pnl_userSenha: TPanel;
    lvl_userSenha: TLabel;
    pnl_linhaUserSenha: TPanel;
    edt_userSenha: TEdit;
    pnl_botaoLogin: TPanel;
    img_logoSiac: TImage;
    spb_confirmaLogin: TSpeedButton;
    spb_fechar: TSpeedButton;
    img_SiacSistemas: TImage;
    img_logoSistema: TImage;
    lbl_nameBemVindo: TLabel;
    procedure spb_fecharClick(Sender: TObject);
    procedure spb_confirmaLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_login: Tform_login;

implementation

uses
  unit_funcoes;

{$R *.dfm}

procedure Tform_login.FormActivate(Sender: TObject);
begin
   pnl_fundo.left := Round (( form_login.Width - pnl_fundo.Width )  / 2 );
   pnl_fundo.top  := Round (( form_login.Height - pnl_fundo.Height )  / 2 );
end;

procedure Tform_login.spb_confirmaLoginClick(Sender: TObject);
begin
  unit_funcoes.prcValidarCamposObrigatorios( form_login );

  if form_dados.Usuarios.fnc_valida_login( edt_userName.Text,edt_userSenha.text ) then
     Close;
end;

procedure Tform_login.spb_fecharClick(Sender: TObject);
begin
    Application.Terminate;
end;

end.
