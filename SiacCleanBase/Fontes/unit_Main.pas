unit unit_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons;

type
  TfrmMain = class(TForm)
    pnl_logoMarca: TPanel;
    pnl_logoIcone: TPanel;
    img_logoDesable: TImage;
    img_logoEnable: TImage;
    pnl_topo: TPanel;
    pnl_logoNome: TPanel;
    img_logoEmpresaBranco: TImage;
    pnl_User: TPanel;
    pnl_userLogin: TPanel;
    pnl_UserName: TPanel;
    img_UserLogin: TImage;
    img_UserLogout: TImage;
    lbl_nomeUser: TLabel;
    lbl_nomeUsuario: TLabel;
    img_logoEmpresaAzul: TImage;
    tmr_trocaLogoEmpresa: TTimer;
    SplitView1: TSplitView;
    CategoryButtonsGrupo: TCategoryButtons;
    pnl_close: TPanel;
    pnl_sairNome: TPanel;
    pnl_iconeSair: TPanel;
    img_sairVermelho: TImage;
    img_sairBranco: TImage;
    lbl_close: TLabel;
    procedure FormShow(Sender: TObject);
    procedure img_logoEnableClick(Sender: TObject);
    procedure img_logoDesableMouseEnter(Sender: TObject);
    procedure img_logoEnableMouseLeave(Sender: TObject);
    procedure img_UserLoginMouseEnter(Sender: TObject);
    procedure img_UserLogoutMouseLeave(Sender: TObject);
    procedure img_UserLogoutClick(Sender: TObject);
    procedure tmr_trocaLogoEmpresaTimer(Sender: TObject);
    procedure img_logoEmpresaBrancoClick(Sender: TObject);
    procedure img_logoEmpresaAzulClick(Sender: TObject);
    procedure img_closeClick(Sender: TObject);
    procedure lbl_closeClick(Sender: TObject);
    procedure img_sairBrancoMouseEnter(Sender: TObject);
    procedure img_sairVermelhoMouseLeave(Sender: TObject);
    procedure lbl_closeMouseEnter(Sender: TObject);
    procedure lbl_closeMouseLeave(Sender: TObject);
  private
    FMostrarBranco: Boolean;
    ActiveAlternaLogo: Boolean;
    procedure AlternarAtivo;
    procedure EnsureEventBindings;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  unit_funcoes;

{$R *.dfm}

procedure TfrmMain.EnsureEventBindings;
begin
  // garante que os eventos estejam ligados mesmo que o DFM esteja sem referência
  if not Assigned(tmr_trocaLogoEmpresa.OnTimer) then
    tmr_trocaLogoEmpresa.OnTimer := tmr_trocaLogoEmpresaTimer;

  if not Assigned(img_logoEmpresaBranco.OnClick) then
    img_logoEmpresaBranco.OnClick := img_logoEmpresaBrancoClick;

  if not Assigned(img_logoEmpresaAzul.OnClick) then
    img_logoEmpresaAzul.OnClick := img_logoEmpresaAzulClick;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  img_logoDesable.Visible := True;
  img_logoEnable.Visible := False;

  img_UserLogout.Visible := False;
  img_UserLogin.Visible := True;

   // inicia o controle de troca automática
  FMostrarBranco := True;
  ActiveAlternaLogo := True;

   // garante que as duas imagens tenham visibilidade inicial consistente
  img_logoEmpresaBranco.Visible := True;
  img_logoEmpresaBranco.BringToFront;
  img_logoEmpresaAzul.Visible := False;

   // configura Timer
  tmr_trocaLogoEmpresa.Enabled := False; // liga depois de configurar
  tmr_trocaLogoEmpresa.Interval := 1000; // 1 segundo
  EnsureEventBindings;
  tmr_trocaLogoEmpresa.Enabled := ActiveAlternaLogo;

   // opcional: força redraw inicial
  img_logoEmpresaBranco.Update;
  img_logoEmpresaAzul.Update;

   // debug
  OutputDebugString(PChar('FormShow: Timer enabled = ' + BoolToStr(tmr_trocaLogoEmpresa.Enabled, True)));
end;

procedure TfrmMain.tmr_trocaLogoEmpresaTimer(Sender: TObject);
begin
  // se está desativado, garante que o timer não faça nada (defensivo)
  if not ActiveAlternaLogo then
  begin
    if tmr_trocaLogoEmpresa.Enabled then
      tmr_trocaLogoEmpresa.Enabled := False;
    Exit;
  end;

  // alterna as imagens
  FMostrarBranco := not FMostrarBranco;

  img_logoEmpresaBranco.Visible := FMostrarBranco;
  img_logoEmpresaAzul.Visible := not FMostrarBranco;

  if img_logoEmpresaBranco.Visible then
    img_logoEmpresaBranco.BringToFront
  else
    img_logoEmpresaAzul.BringToFront;

  // debug - ver no DebugView ou no log do Delphi
  OutputDebugString(PChar(Format('tmr tick: Active=%s ShowBranco=%s', [BoolToStr(ActiveAlternaLogo, True), BoolToStr(FMostrarBranco, True)])));
end;

procedure TfrmMain.AlternarAtivo;
begin
  ActiveAlternaLogo := not ActiveAlternaLogo;
  tmr_trocaLogoEmpresa.Enabled := ActiveAlternaLogo;

  // debug
  OutputDebugString(PChar('AlternarAtivo: ActiveAlternaLogo = ' + BoolToStr(ActiveAlternaLogo, True)));
end;

procedure TfrmMain.img_logoEmpresaBrancoClick(Sender: TObject);
begin
  // quando usuário clicar na imagem branca pause/retome a alternância
  AlternarAtivo;
end;

procedure TfrmMain.img_logoEmpresaAzulClick(Sender: TObject);
begin
  // quando usuário clicar na imagem azul pause/retome a alternância
  AlternarAtivo;
end;

procedure TfrmMain.img_logoEnableClick(Sender: TObject);
begin
  if SplitView1.Opened then
    SplitView1.Close
  else
    SplitView1.Open;


  if  SplitView1.Opened then
  lbl_close.Visible := false
  else  lbl_close.Visible := True;





end;

procedure TfrmMain.img_logoEnableMouseLeave(Sender: TObject);
begin
  img_logoEnable.Visible := False;
  img_logoDesable.Visible := True;
end;

procedure TfrmMain.img_sairBrancoMouseEnter(Sender: TObject);
begin
  img_sairBranco.Visible :=False;
  img_sairVermelho.Visible :=True;
  lbl_close.Font.Color := clRed;

end;

procedure TfrmMain.img_sairVermelhoMouseLeave(Sender: TObject);
begin
  img_sairBranco.Visible :=True;
  img_sairVermelho.Visible :=False;
  lbl_close.Font.Color := clWhite;
end;

procedure TfrmMain.img_UserLoginMouseEnter(Sender: TObject);
begin
  img_UserLogout.Visible := True;
  img_UserLogin.Visible := False;
end;

procedure TfrmMain.img_UserLogoutClick(Sender: TObject);
begin
  ShowMessage('Fazer Logout');
end;

procedure TfrmMain.img_UserLogoutMouseLeave(Sender: TObject);
begin
  img_UserLogin.Visible := true;
  img_UserLogout.Visible := False;
end;

procedure TfrmMain.lbl_closeClick(Sender: TObject);
var
  returnUsuario: Boolean;
begin
  returnUsuario := fnc_criar_menssagem('FECHAR SISTEMA',
  'A FUNÇÃO PARA FECHAR O SISTEMA FOI ACIONADA',
  'DESEJA REALMENTE SAIR DO SISTEMA ?',
  ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png',
  'ERRO');

  if not returnUsuario then
    Exit;

  Application.Terminate;
end;

procedure TfrmMain.lbl_closeMouseEnter(Sender: TObject);
begin
  img_sairBranco.Visible :=False;
  img_sairVermelho.Visible :=True;
  lbl_close.Font.Color := clRed;
end;

procedure TfrmMain.lbl_closeMouseLeave(Sender: TObject);
begin
    img_sairBranco.Visible :=True;
  img_sairVermelho.Visible :=False;
  lbl_close.Font.Color := clWhite;
end;

procedure TfrmMain.img_closeClick(Sender: TObject);
var
  returnUsuario: Boolean;
begin
  returnUsuario := fnc_criar_menssagem('FECHAR SISTEMA',
  'A FUNÇÃO PARA FECHAR O SISTEMA FOI ACIONADA',
  'DESEJA REALMENTE SAIR DO SISTEMA ?',
  ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png',
  'ERRO');

  if not returnUsuario then
    Exit;

  Application.Terminate;

end;

procedure TfrmMain.img_logoDesableMouseEnter(Sender: TObject);
begin
  img_logoEnable.Visible := True;
  img_logoDesable.Visible := False;
end;

end.

