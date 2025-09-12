unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Data.DB, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, MemDS,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, DAScript, OraScript, unit_principalDados;

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
    pnl_editEmpresa: TPanel;
    btn_frmEmpresas: TButton;
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
    procedure CtrlBotoes(Modo : Boolean);
    procedure dbEmpresasDblClick(Sender: TObject);
    procedure dbEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_frmEmpresasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uDataModule,_Biblioteca, VarGlobal, unit_mensagens;

{$R *.dfm}

procedure TfrmPrincipal.BtConectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.ConectarBd(eUsuario.Text,eSenha.Text,eServidor.Text) then
  begin
    CtrlBotoes(True);
    qryEmpresas.Open;

    //qry_deletandoEmpresas.Open;

    pnl_fundo_normal.Visible := true;
    pnl_fundo_opacidade.Visible:= false;

 //   OraScriptDeletandoEmpresa.SQL.Text := qry_deletandoEmpresas.SQL.Text;
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

procedure TfrmPrincipal.btn_frmEmpresasClick(Sender: TObject);
begin
  try
    form_principalDados := Tform_principalDados.Create(Self);

    // Desabilitando o fundo do sistema principal
    pnl_fundo_normal.Visible := False;

    // Centralizar em relação ao painel pnl_fundo_normal
    form_principalDados.Left := pnl_fundo_normal.Left +
                                (pnl_fundo_normal.Width - form_principalDados.Width) div 2;

    form_principalDados.Top := pnl_fundo_normal.Top +
                               (pnl_fundo_normal.Height - form_principalDados.Height) div 2;

    form_principalDados.ShowModal;

  finally
    form_principalDados.Free;
    pnl_fundo_normal.Visible := True;
  end;
end;
procedure TfrmPrincipal.CtrlBotoes(Modo: Boolean);
begin
  BtConectar.Enabled := not(Modo);
  BtDesconectar.Enabled := not(BtConectar.Enabled);
  eUsuario.Enabled := not(Modo);
  eSenha.Enabled := not(Modo);
  eServidor.Enabled := not(Modo);

  // Alterando a coloração do sistema quando esta conectado ao banco
  if Modo then
    Shape1.Brush.Color := clTeal

  else
    Shape1.Brush.Color := clSilver;

  if Modo then
     Shape2.Brush.Color := clTeal
  else
     Shape2.Brush.Color := clSilver;

   // Ativando o Botão Editar Empresa
  if Modo then
   pnl_editEmpresa.Visible  := True
  else
  pnl_editEmpresa.Visible := False;

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
  //ShowMessage('Scripts gerados:' + sLineBreak + OraScriptDeletandoEmpresa.SQL.Text);

  // executar logo apos inserir os dados
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
