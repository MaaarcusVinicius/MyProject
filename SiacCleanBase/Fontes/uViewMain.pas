unit uViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask;

type
  TViewMain = class(TForm)
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
    SplitViewMenu: TSplitView;
    CategoryButtonsGrupo: TCategoryButtons;
    pnl_close: TPanel;
    pnl_sairNome: TPanel;
    pnl_iconeSair: TPanel;
    img_sairVermelho: TImage;
    img_sairBranco: TImage;
    lbl_close: TLabel;
    actlst1: TActionList;
    ImageList1: TImageList;
    act_Empresas: TAction;
    act_Movimentacao: TAction;
    act_Configuracao: TAction;
    SplitViewEmpresas: TSplitView;
    pnl_subMenu: TPanel;
    lbl_subMenuEmpresas: TLabel;
    FlowPanelEmpresas: TFlowPanel;
    btn_deletandoEmpresa: TSpeedButton;
    btn_trocandoEmpresa: TSpeedButton;
    btn_editandoEmpresa: TSpeedButton;
    btn_vago: TSpeedButton;
    btn_fecharMenuEmpresas: TSpeedButton;
    ImageList2: TImageList;
    actlst2: TActionList;
    action_TrocandoEmpresa: TAction;
    action_deletandoEmpresa: TAction;
    action_editandoEmpresa: TAction;
    action_vago: TAction;
    action_fecharMenuEmpresas: TAction;
    SplitViewMovimento: TSplitView;
    FlowPanelMovimento: TFlowPanel;
    action_configBD: TAction;
    pnl_Movimentacao: TPanel;
    lbl_menuMovimentacao: TLabel;
    btn_FecharMenuMovimento: TSpeedButton;
    SplitViewConfigBD: TSplitView;
    FlowPanelConfigBD: TFlowPanel;
    pnl_menuConfig: TPanel;
    lbl_MenuConfig: TLabel;
    btn_configBD: TSpeedButton;
    btn_FecharConfigMenu: TSpeedButton;
    action_fecharMenuMovimentacao: TAction;
    action_fecharMenuConfig: TAction;
    pnl_baseCentral: TPanel;
    PageControl: TPageControl;
    PageInicial: TTabSheet;
    PageTrocaEmpresa: TTabSheet;
    img_fundo_opacidade: TImage;
    qryEmpresas: TOraQuery;
    qryEmpresasEMPRESA_ID: TStringField;
    qryEmpresasRAZAO_SOCIAL: TStringField;
    qryEmpresasFANTASIA: TStringField;
    qryEmpresasATIVO: TStringField;
    qryEmpresasQTD_PRODUTOS_EMPRESA: TFloatField;
    qryEmpresasQTD_CADASTROS: TFloatField;
    qryEmpresasQTD_FINANCEIRO_EMPRESA: TFloatField;
    qryEmpresasQTD_ESTOQUE_EMPRESA: TFloatField;
    OraData: TOraDataSource;
    dbPrincipalEmpresas: TDBGrid;
    PageConfigBD: TTabSheet;
    Shape2: TShape;
    BtDesconectar: TBitBtn;
    BtConectar: TBitBtn;
    eServidor: TEdit;
    eSenha: TEdit;
    eUsuario: TEdit;
    LbAlias: TLabel;
    LbSenha: TLabel;
    LbServidor: TLabel;
    shape1: TShape;
    img_fundo: TImage;
    pnl_fundoTrocaEmpresa: TPanel;
    TrocaEmpresa: TGroupBox;
    grpAcoes: TGroupBox;
    pnl_trocandoEmpresa: TPanel;
    lbl_trocaEmpresa: TLabel;
    pnl_trocandoEmpresas: TPanel;
    Panel1: TPanel;
    btn_trocandoEmpresas: TSpeedButton;
    medt_cpf_cnpj: TMaskEdit;
    chk_saveScritpTrocando: TCheckBox;
    grpEmpresaDestino: TGroupBox;
    PageDeletaEmpresa: TTabSheet;
    pnl_fundoDeletaEmpresa: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    pnl_deletaEmpresa: TPanel;
    pnl_deletandoEmpresas: TPanel;
    btn_deletandoEmpresas: TSpeedButton;
    chk_saveScriptDeletando: TCheckBox;
    pnl_carregaEmpresa: TPanel;
    pnl_configBancoDados: TPanel;
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
    procedure act_MovimentacaoExecute(Sender: TObject);
    procedure act_EmpresasExecute(Sender: TObject);
    procedure act_ConfiguracaoExecute(Sender: TObject);
    procedure act_ConfiguracaoBDExecute(Sender: TObject);
    procedure btn_testeClick(Sender: TObject);
    procedure action_TrocandoEmpresaExecute(Sender: TObject);
    procedure action_deletandoEmpresaExecute(Sender: TObject);
    procedure action_editandoEmpresaExecute(Sender: TObject);
    procedure action_vagoExecute(Sender: TObject);
    procedure action_fecharMenuEmpresasExecute(Sender: TObject);
    procedure action_fecharMenuConfigBDExecute(Sender: TObject);
    procedure action_fecharMenuMovimentacaoExecute(Sender: TObject);
    procedure action_configBDExecute(Sender: TObject);
    procedure AlternaSplitViewClose(Target: TSplitView);
    procedure AlternaSplitViewOpen(Target: TSplitView);
    procedure img_logoEnableMouseEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_logoDesableClick(Sender: TObject);
    procedure img_logoEnableDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
    procedure CtrlBotoes(Modo: Boolean);
    procedure img_fundo_opacidadeDblClick(Sender: TObject);
    procedure dbPrincipalEmpresasDblClick(Sender: TObject);

  private
    FMostrarBranco: Boolean;
    ActiveAlternaLogo: Boolean;
    procedure AlternarAtivo;
    procedure EnsureEventBindings;

  public
    function fnc_FecharSistema: Boolean;

  end;

var
  ViewMain: TViewMain;

implementation

uses
  Classe.funcoes, VarGlobal, _Biblioteca, uDataModule;

{$R *.dfm}

procedure TViewMain.EnsureEventBindings;
begin
  // garante que os eventos estejam ligados mesmo que o DFM esteja sem referência
  if not Assigned(tmr_trocaLogoEmpresa.OnTimer) then
    tmr_trocaLogoEmpresa.OnTimer := tmr_trocaLogoEmpresaTimer;

  if not Assigned(img_logoEmpresaBranco.OnClick) then
    img_logoEmpresaBranco.OnClick := img_logoEmpresaBrancoClick;

  if not Assigned(img_logoEmpresaAzul.OnClick) then
    img_logoEmpresaAzul.OnClick := img_logoEmpresaAzulClick;
end;

procedure TViewMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fnc_FecharSistema()
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
end;

procedure TViewMain.FormShow(Sender: TObject);
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
  //OutputDebugString(PChar('FormShow: Timer enabled = ' + BoolToStr(tmr_trocaLogoEmpresa.Enabled, True)));
end;

procedure TViewMain.tmr_trocaLogoEmpresaTimer(Sender: TObject);
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
  // OutputDebugString(PChar(Format('tmr tick: Active=%s ShowBranco=%s', [BoolToStr(ActiveAlternaLogo, True), BoolToStr(FMostrarBranco, True)])));
end;

procedure TViewMain.action_TrocandoEmpresaExecute(Sender: TObject);
begin
  // Acessa o menu Inicial
  PageControl.ActivePageIndex := 1;
end;

procedure TViewMain.action_configBDExecute(Sender: TObject);
begin
  // Troca Empresa
  PageControl.ActivePageIndex := 2;
end;

procedure TViewMain.action_deletandoEmpresaExecute(Sender: TObject);
begin
  // Deleta Empresa
  PageControl.ActivePageIndex := 3;
end;

procedure TViewMain.action_editandoEmpresaExecute(Sender: TObject);
begin
  ShowMessage('Editando Empresas');
end;

procedure TViewMain.action_fecharMenuEmpresasExecute(Sender: TObject);
begin
  SplitViewEmpresas.Close;       // fecharMenuEmpresas
end;

procedure TViewMain.action_fecharMenuConfigBDExecute(Sender: TObject);
begin
  SplitViewConfigBD.Close;       // fecharMenuConfiguração
end;

procedure TViewMain.action_fecharMenuMovimentacaoExecute(Sender: TObject);
begin
  SplitViewMovimento.Close;      // fecharMenuMovimentação
end;

procedure TViewMain.action_vagoExecute(Sender: TObject);
begin
  ShowMessage('Opção Vaga');
end;

procedure TViewMain.act_ConfiguracaoBDExecute(Sender: TObject);
begin
//     perdido
end;

procedure TViewMain.act_ConfiguracaoExecute(Sender: TObject);
begin
  if SplitViewConfigBD.Opened then
    SplitViewConfigBD.close
  else
    SplitViewConfigBD.Open;
end;

procedure TViewMain.act_EmpresasExecute(Sender: TObject);
begin
 //SplitView2.Open;

  if SplitViewEmpresas.Opened then
    SplitViewEmpresas.close
  else
    SplitViewEmpresas.Open;
end;

procedure TViewMain.act_MovimentacaoExecute(Sender: TObject);
begin
  if SplitViewMovimento.Opened then
    SplitViewMovimento.close
  else
    SplitViewMovimento.Open;
end;

procedure TViewMain.AlternarAtivo;
begin
  ActiveAlternaLogo := not ActiveAlternaLogo;
  tmr_trocaLogoEmpresa.Enabled := ActiveAlternaLogo;
end;

procedure TViewMain.btn_testeClick(Sender: TObject);
begin
  ShowMessage('testes');
end;

procedure TViewMain.img_logoEmpresaBrancoClick(Sender: TObject);
begin
  // quando usuário clicar na imagem branca pause/retorna a alternância
  AlternarAtivo;
end;

procedure TViewMain.img_logoEmpresaAzulClick(Sender: TObject);
begin
  // quando usuário clicar na imagem branca pause/retorna a alternância
  AlternarAtivo;
end;

procedure TViewMain.img_logoEnableClick(Sender: TObject);
begin
//   AlternaSplitView(SplitViewMenu);
  AlternaSplitViewOpen(SplitViewMenu);
end;

procedure TViewMain.img_logoEnableDblClick(Sender: TObject);
begin
  AlternaSplitViewClose(SplitViewMenu);
end;

procedure TViewMain.img_logoEnableMouseEnter(Sender: TObject);
begin
  if SplitViewMenu.Opened then
    lbl_close.Visible := True
  else
    lbl_close.Visible := false;
end;

procedure TViewMain.img_logoEnableMouseLeave(Sender: TObject);
begin
  img_logoEnable.Visible := False;
  img_logoDesable.Visible := True;
end;

procedure TViewMain.img_sairBrancoMouseEnter(Sender: TObject);
begin
  img_sairBranco.Visible := False;
  img_sairVermelho.Visible := True;
  lbl_close.Font.Color := clRed;

end;

procedure TViewMain.img_sairVermelhoMouseLeave(Sender: TObject);
begin
  img_sairBranco.Visible := True;
  img_sairVermelho.Visible := False;
  lbl_close.Font.Color := clWhite;
end;

procedure TViewMain.img_UserLoginMouseEnter(Sender: TObject);
begin
  img_UserLogout.Visible := True;
  img_UserLogin.Visible := False;
end;

procedure TViewMain.img_UserLogoutClick(Sender: TObject);
begin
  ShowMessage('Fazer Logout');
end;

procedure TViewMain.img_UserLogoutMouseLeave(Sender: TObject);
begin
  img_UserLogin.Visible := true;
  img_UserLogout.Visible := False;
end;

procedure TViewMain.lbl_closeClick(Sender: TObject);
begin
  fnc_FecharSistema();
end;

procedure TViewMain.lbl_closeMouseEnter(Sender: TObject);
begin
  img_sairBranco.Visible := False;
  img_sairVermelho.Visible := True;
  lbl_close.Font.Color := clRed;
end;

procedure TViewMain.lbl_closeMouseLeave(Sender: TObject);
begin
  img_sairBranco.Visible := True;
  img_sairVermelho.Visible := False;
  lbl_close.Font.Color := clWhite;
end;

procedure TViewMain.img_closeClick(Sender: TObject);
begin
  fnc_FecharSistema();
end;

procedure TViewMain.img_fundo_opacidadeDblClick(Sender: TObject);
begin
   // if  dbPrincipalEmpresas. then

end;

procedure TViewMain.img_logoDesableClick(Sender: TObject);
begin
  AlternaSplitViewOpen(SplitViewMenu);
end;

procedure TViewMain.img_logoDesableMouseEnter(Sender: TObject);
begin
  img_logoEnable.Visible := True;
  img_logoDesable.Visible := False;
end;

procedure TViewMain.AlternaSplitViewClose(Target: TSplitView);
var
  i: Integer;
begin
  // Fecha todos os SplitViews do form
  for i := 0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TSplitView then
      TSplitView(Self.Components[i]).Close;

  // Se o alvo não estava aberto, abre ele
  if not Target.Opened then
    Target.Open;

end;

procedure TViewMain.AlternaSplitViewOpen(Target: TSplitView);
var
  i: Integer;
begin
  // Fecha todos os SplitViews do form
  for i := 0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TSplitView then
      TSplitView(Self.Components[i]).Open;

  // Se o alvo não estava aberto, abre ele
  if Target.Opened then
    Target.Close;

end;

procedure TViewMain.BtConectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.ConectarBd(eUsuario.Text, eSenha.Text, eServidor.Text) then
  begin
    CtrlBotoes(True);
    qryEmpresas.Open;

   fnc_criar_menssagem('CONFIGURAÇÃO AO BANCO DE DADOS ORACLE',
               'Configuração de banco de dados',
               'Conexão com o banco de dados estabelecida com sucesso!',
                ExtractFilePath(Application.ExeName) + 'Arquivos\icones\database_connection.png', 'OK');

    // Volta o foco do usuário para a tela incial, seleção da empresa.
    PageControl.ActivePageIndex := 0;

    // Seta o cursor do mouse para o DbGridEmpresas
    dbPrincipalEmpresas.SetFocus;

    // Troca a imagem da tela Main/Tela princial
    img_fundo.Visible := True;
    img_fundo_opacidade.Visible := False;

    // testando
     pnl_configBancoDados.Color := clBlack;

  end
  else
  begin
    CtrlBotoes(False);
   fnc_criar_menssagem('CONFIGURAÇÃO AO BANCO DE DADOS ORACLE',
                   'Falha na configuração de banco de dados!',
                   'Verifique as configurações de conexão.',
                    ExtractFilePath(Application.ExeName) + 'Arquivos\icones\database_error.png', 'OK');
  end;

end;

procedure TViewMain.BtDesconectarClick(Sender: TObject);
begin
  if uDataModule.DmModule.DesconectarBd then
  begin
    CtrlBotoes(False);

    // Troca a imagem da tela Main/Tela princial
    img_fundo_opacidade.Visible := True;
    img_fundo.Visible := False;
  end;
end;

function TViewMain.fnc_FecharSistema: Boolean;
begin
  Result := fnc_criar_menssagem('FECHAR SISTEMA', 'A FUNÇÃO PARA FECHAR O SISTEMA FOI ACIONADA', 'DESEJA REALMENTE SAIR DO SISTEMA ?', ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png', 'ERRO');

  // Se o usuário clicou em "Não" ou "Cancelar", interrompe
  if not Result then
    Exit(False);

  // Caso contrário, fecha o sistema
  Application.Terminate;
  Result := True;
end;

procedure TViewMain.CtrlBotoes(Modo: Boolean);
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

end;

procedure TViewMain.dbPrincipalEmpresasDblClick(Sender: TObject);
begin
  if ( dbPrincipalEmpresas.DataSource.DataSet.IsEmpty ) then
     begin
       fnc_criar_menssagem('CONFIGURAÇÃO AO BANCO DE DADOS ORACLE',
                           'Nenhuma configuração de banco de dados encontrada!',
                           'Verifique as configurações de conexão.',
                            ExtractFilePath(Application.ExeName) + 'Arquivos\icones\database_error.png', 'OK');

       // REDIRECIONAMENTO PARA A TELA DE CONFIGURAÇÃO
        PageControl.ActivePageIndex := 2;
     end else

     begin
      // Passa o SQL da empresa Selecionada para o form responsavel pela edição da empresa
       pnl_carregaEmpresa.Caption := 'Empresa Selecionada: ' +
                                      qryEmpresasEMPRESA_ID.AsString +
                                      ' / ' +
                                      qryEmpresasRAZAO_SOCIAL.AsString;
     end;


end;

end.

