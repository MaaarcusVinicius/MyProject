unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Data.DB, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, MemDS,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

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
    pnl_logoFundo: TPanel;
    img_fundo: TImage;
    qryEmpresasATIVO: TStringField;
    qryEmpresasQTD_PRODUTOS_EMPRESA: TFloatField;
    qryEmpresasQTD_CADASTROS: TFloatField;
    qryEmpresasQTD_FINANCEIRO_EMPRESA: TFloatField;
    pnl_fundo_opacidade: TPanel;
    pnl_fundo_normal: TPanel;
    img_fundo_opacidade: TImage;
    qryEmpresasQTD_ESTOQUE_EMPRESA: TFloatField;
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
    procedure CtrlBotoes(Modo : Boolean);
    procedure FormCreate(Sender: TObject);
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
    CtrlBotoes(True);
    qryEmpresas.Open;

    pnl_fundo_normal.Visible := true;
    pnl_fundo_opacidade.Visible:= false;

  end else
  begin
    CtrlBotoes(False);
    ShowMessage('Erro ao conectar no banco!!');
  end;

  end;

procedure TfrmPrincipal.BtDesconectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.DesconectarBd then
  begin
    CtrlBotoes(False);
    pnl_fundo_normal.Visible := false;
    pnl_fundo_opacidade.Visible:= true;
  end;
end;

procedure TfrmPrincipal.CtrlBotoes(Modo: Boolean);
begin
  BtConectar.Enabled := not(Modo);
  BtDesconectar.Enabled := not(BtConectar.Enabled);
  eUsuario.Enabled := not(Modo);
  eSenha.Enabled := not(Modo);
  eServidor.Enabled := not(Modo);

  if Modo then
    Shape1.Brush.Color := clTeal //$4040ff

  else
    Shape1.Brush.Color := clSilver;  //  $00A5927E

  if Modo then
     Shape2.Brush.Color := clTeal //$4040ff
  else
     Shape2.Brush.Color := clSilver;


end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
 // BorderStyle := bsSingle; // mantém a barra de título
 //  SetBounds(0, 0, Screen.Width, Screen.Height); // ocupa a tela inteira
end;

end.
