unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  DAScript, OraScript, ACBrBase, ACBrEnterTab;

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
    LbServidor: TLabel;
    Shape1: TShape;
    qryEmpresas: TOraQuery;
    dbPrincipalEmpresas: TDBGrid;
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
    pnl_editEmpresas: TPanel;
    btn_editEmpresa: TSpeedButton;
    acbr_tabEnter: TACBrEnterTab;
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
    procedure CtrlBotoes(Modo: Boolean);
    procedure dbPrincipalEmpresasDblClick(Sender: TObject);
    procedure dbPrincipalEmpresasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_editEmpresaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uDataModule, _Biblioteca, VarGlobal, unit_empresasDados;

{$R *.dfm}

procedure TfrmPrincipal.BtConectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.ConectarBd(eUsuario.Text, eSenha.Text, eServidor.Text) then
  begin
    CtrlBotoes(True);
    qryEmpresas.Open;

    // Seta o cursor do mouse para o DbGridEmpresas
    dbPrincipalEmpresas.SetFocus;

    pnl_fundo_normal.Visible := true;
    pnl_fundo_opacidade.Visible := false;

  end
  else
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

    pnl_fundo_opacidade.Visible := true;
    pnl_fundo_normal.Visible := false;

  end;
end;

procedure TfrmPrincipal.btn_editEmpresaClick(Sender: TObject);
var
  vEmpresaID: string;
begin
  try
    form_empresaDados := Tform_empresaDados.Create(Self);

   // Passa o SQL da empresa Selecionada para o form responsavel pela edição da empresa
    vEmpresaID := qryEmpresasEMPRESA_ID.AsString;

    form_empresaDados.qryEmpresas.Close;
    form_empresaDados.qryEmpresas.SQL.Clear;

    form_empresaDados.qryEmpresas.SQL.Add('SELECT EMPRESA_ID,                                                 ');
    form_empresaDados.qryEmpresas.SQL.Add('       RAZAO_SOCIAL,                                               ');
    form_empresaDados.qryEmpresas.SQL.Add('       FANTASIA,                                                   ');
    form_empresaDados.qryEmpresas.SQL.Add('       E.ATIVO,                                                    ');
    form_empresaDados.qryEmpresas.SQL.Add('       (SELECT COUNT(*) FROM CADASTROS C) QTD_CADASTROS,           ');
    form_empresaDados.qryEmpresas.SQL.Add('       (SELECT COUNT(*)                                            ');
    form_empresaDados.qryEmpresas.SQL.Add('          FROM FINANCEIRO F                                        ');
    form_empresaDados.qryEmpresas.SQL.Add('         WHERE 1 = 1                                               ');
    form_empresaDados.qryEmpresas.SQL.Add('           AND F.EMPRESA_ID = E.EMPRESA_ID) QTD_FINANCEIRO_EMPRESA,');
    form_empresaDados.qryEmpresas.SQL.Add('       (SELECT COUNT(*)                                            ');
    form_empresaDados.qryEmpresas.SQL.Add('          FROM PRODUTOS PR, PRODUTOS_EMPRESAS PE                   ');
    form_empresaDados.qryEmpresas.SQL.Add('         WHERE PR.PRODUTO_ID = PE.PRODUTO_ID                       ');
    form_empresaDados.qryEmpresas.SQL.Add('           AND PE.EMPRESA_ID = E.EMPRESA_ID) QTD_PRODUTOS_EMPRESA, ');
    form_empresaDados.qryEmpresas.SQL.Add('       (SELECT NVL(TRUNC(SUM(ESTOQUE_ATUAL), 4), 0)                ');
    form_empresaDados.qryEmpresas.SQL.Add('          FROM ESTOQUES ET                                         ');
    form_empresaDados.qryEmpresas.SQL.Add('         WHERE 1 = 1                                               ');
    form_empresaDados.qryEmpresas.SQL.Add('           AND ET.EMPRESA_ID = E.EMPRESA_ID                        ');
    form_empresaDados.qryEmpresas.SQL.Add('           AND ET.ESTOQUE_ATUAL > 0) QTD_ESTOQUE_EMPRESA           ');
    form_empresaDados.qryEmpresas.SQL.Add('  FROM EMPRESAS E                                                  ');
    form_empresaDados.qryEmpresas.SQL.Add(' WHERE E.EMPRESA_ID = :pEMPRESA_ID                                 ');
    form_empresaDados.qryEmpresas.ParamByName('pEMPRESA_ID').AsString := vEmpresaID;

    form_empresaDados.qryEmpresas.Open;

     // Centralizar em relação ao painel pnl_fundo_normal
    form_empresaDados.Left := pnl_fundo_normal.Left + (pnl_fundo_normal.Width - form_empresaDados.Width) div 2;

    form_empresaDados.Top := pnl_fundo_normal.Top + (pnl_fundo_normal.Height - form_empresaDados.Height) div 2;

    form_empresaDados.ShowModal;
    //form_empresaDados.Show;
    // ativando o Qry do dbgrid da proxima tela
    form_empresaDados.qryEmpresas.Open;

  finally
    form_empresaDados.Free;
  end;
end;

procedure TfrmPrincipal.CtrlBotoes(Modo: Boolean);
begin
  BtConectar.Enabled := not (Modo);
  BtDesconectar.Enabled := not (BtConectar.Enabled);
  eUsuario.Enabled := not (Modo);
  eSenha.Enabled := not (Modo);
  eServidor.Enabled := not (Modo);

  if Modo then
    Shape1.Brush.Color := clTeal
  else
    Shape1.Brush.Color := clSilver;

  if Modo then
    Shape2.Brush.Color := clTeal
  else
    Shape2.Brush.Color := clSilver;

  if Modo then
    pnl_editEmpresas.Visible := True
  else
    pnl_editEmpresas.Visible := False;

end;

procedure TfrmPrincipal.dbPrincipalEmpresasDblClick(Sender: TObject);
begin
  btn_editEmpresaClick(Self);
end;

procedure TfrmPrincipal.dbPrincipalEmpresasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_editEmpresaClick(Self);

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  pnl_editEmpresas.Visible := False;
end;

end.

