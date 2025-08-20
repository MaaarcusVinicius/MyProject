unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  OraCall, Data.DB, DBAccess, Ora,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, DataModuloOracle,
  Vcl.Imaging.pngimage, ACBrBase, ACBrEnterTab;

type
  TfrmPrincipal = class(TForm)
    pnl_central: TPanel;
    pnl_superior: TPanel;
    edt_Usuario: TEdit;
    edt_Senha: TEdit;
    edt_Host: TEdit;
    btn_Conectar: TSpeedButton;
    lbl_userBanco: TLabel;
    lbl_Senha: TLabel;
    lbl_Servidor: TLabel;
    chk_Direct: TCheckBox;
    img_logoFundoOpacity: TImage;
    img_fundoLogo: TImage;
    AcbrTabEnter: TACBrEnterTab;
    procedure btn_ConectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btn_ConectarClick(Sender: TObject);

begin
  DataModuloOracle.SetOracle.OracleConexao.Close;
  DataModuloOracle.SetOracle.OracleConexao.Options.Direct := chk_Direct.Checked;
  DataModuloOracle.SetOracle.OracleConexao.Username    := edt_Usuario.text;
  DataModuloOracle.SetOracle.OracleConexao.Password    := edt_Senha.text;
  DataModuloOracle.SetOracle.OracleConexao.Server      := edt_Host.text;
  DataModuloOracle.SetOracle.OracleConexao.LoginPrompt := false;


//  showmessage(DataModuloOracle.SetOracle.OracleConexao.ConnectString); // Connect String

  DataModuloOracle.SetOracle.OracleConexao.Open;


  if DataModuloOracle.SetOracle.OracleConexao.Connected then
    showmessage('CONEXÃO BEM SUCEDIDA!!!')
  else
    showmessage('CONEXÃO FALHOU...') ;

 // TROCA A IMAGEM DO PNL_CENTRAL QUANDO A CONEXÃO FOR ESTABELECIDA
  if DataModuloOracle.SetOracle.OracleConexao.Connected then
  begin
    img_fundoLogo.Enabled := true;
    img_fundoLogo.Visible := true;
  end else
    img_logoFundoOpacity.Enabled := False;
    img_logoFundoOpacity.Visible := False;


end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin

    img_fundoLogo.Enabled := False;
    img_fundoLogo.Visible := False;

    img_logoFundoOpacity.Enabled := true;
    img_logoFundoOpacity.Visible := true;



end;

end.
