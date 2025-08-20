unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Data.DB, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, MemDS;

type
  TfrmPrincipal = class(TForm)
    Shape2: TShape;
    BtDesconectar: TBitBtn;
    BtConectar: TBitBtn;
    eServidor: TEdit;
    eSenha: TEdit;
    eUsuario: TEdit;
    LbAlias: TLabel;
    LbSenha: TLabel;
    Label17: TLabel;
    Shape1: TShape;
    qryEmpresas: TOraQuery;
    dbEmpresas: TDBGrid;
    OraData: TOraDataSource;
    qryEmpresasEMPRESA_ID: TStringField;
    qryEmpresasRAZAO_SOCIAL: TStringField;
    qryEmpresasFANTASIA: TStringField;
    lbldate: TLabel;
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uDataModule,_Biblioteca, VarGlobal;

{$R *.dfm}

procedure TfrmPrincipal.BtConectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.ConectarBd(eUsuario.Text,eSenha.Text,eServidor.Text) then
  begin
    BtConectar.Enabled := False;
    BtDesconectar.Enabled := True;
    Shape2.Brush.Color := clGreen;
    qryEmpresas.Open;
    lbldate.Caption := DateToStr(now);
   end else
    ShowMessage('Problema ao conectar no banco de dados');


end;

procedure TfrmPrincipal.BtDesconectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.DesconectarBd then
  begin
    BtConectar.Enabled := True;
    BtDesconectar.Enabled := False;
    Shape2.Brush.Color := $00A5927E;
  end;
end;

end.
