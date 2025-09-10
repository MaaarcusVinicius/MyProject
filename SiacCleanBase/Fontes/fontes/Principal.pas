unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Data.DB, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, MemDS,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, DAScript, OraScript;

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
    OraScriptDeletandoEmpresa: TOraScript;
    ds_deletandoEmpresa: TOraDataSource;
    qry_deletandoEmpresas: TOraQuery;
    dbGrid_QryEmpresas: TDBGrid;
    field_deletandoEmpresasSCRIPT: TStringField;
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
    procedure CtrlBotoes(Modo : Boolean);
    procedure dbEmpresasDblClick(Sender: TObject);
    procedure dbEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    qry_deletandoEmpresas.Open;

    pnl_fundo_normal.Visible := true;
    pnl_fundo_opacidade.Visible:= false;



    OraScriptDeletandoEmpresa.SQL.Text := qry_deletandoEmpresas.SQL.Text;
//    OraScriptDeletandoEmpresa.Execute;

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
    Shape1.Brush.Color := clTeal

  else
    Shape1.Brush.Color := clSilver;

  if Modo then
     Shape2.Brush.Color := clTeal
  else
     Shape2.Brush.Color := clSilver;


end;

procedure TfrmPrincipal.dbEmpresasDblClick(Sender: TObject);
var
  vEmpresa_id: String;
begin
  vEmpresa_id := qryEmpresas.FieldByName('EMPRESA_ID').AsString;

  // <-- IMPORTANTE: setar o parâmetro ANTES de abrir a query geradora
  qry_deletandoEmpresas.Close;
  qry_deletandoEmpresas.ParamByName('pEMPRESA_ID').AsString := '''' + vEmpresa_id + '''';
  qry_deletandoEmpresas.Open;

  OraScriptDeletandoEmpresa.SQL.Clear;
  qry_deletandoEmpresas.First;
  while not qry_deletandoEmpresas.Eof do
  begin
    OraScriptDeletandoEmpresa.SQL.Add(qry_deletandoEmpresas.FieldByName('SCRIPT').AsString);
    qry_deletandoEmpresas.Next;
  end;

  // debug rápido: ver o que foi gerado
  ShowMessage('Scripts gerados:' + sLineBreak + OraScriptDeletandoEmpresa.SQL.Text);

  // executar
  //OraScriptDeletandoEmpresa.Execute;
end;



procedure TfrmPrincipal.dbEmpresasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_DELETE then
   OraScriptDeletandoEmpresa.Execute;

   qryEmpresas.Close;
   qryEmpresas.Open;
end;

end.
