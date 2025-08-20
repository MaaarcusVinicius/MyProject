unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, OraCall, Data.DB, DBAccess, Ora,
  Vcl.StdCtrls, form_consultaGrid,  MemDS, Vcl.Grids, Vcl.DBGrids;

type
  TPrincipal = class(TForm)
    Label1: TLabel;
    vUser: TEdit;
    vSenha: TEdit;
    vServidor: TEdit;
    btnConectar: TButton;
    vDirect: TCheckBox;
    dbgrd_oracle: TDBGrid;
    procedure btnConectarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

procedure TPrincipal.btnConectarClick(Sender: TObject);
begin
  OraSession.close;
  OraSession.Options.Direct := vDirect.Checked;
  OraSession.Password       := vSenha.Text;
  OraSession.Username       := vUser.Text;
  OraSession.Server         := vServidor.Text;
  OraSession.LoginPrompt    := false;

  showmessage(OraSession.ConnectString);

  OraSession.Open;
  if OraSession.Connected then
    showmessage('CONECTOU...')
  else
    showmessage('não ...') ;

  qry_oracle.Session := OraSession;
  qry_oracle.Active := true;
end;

end.
