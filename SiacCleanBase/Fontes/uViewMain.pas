unit uViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,  Classe.DBA.Oracle,
  TelaAguarde, System.RegularExpressions, EditNumber, ACBrBase, ACBrEnterTab,
  Vcl.CheckLst, Datasnap.DBClient, Classe.LimparMovimento,
  Classe.EmailLogs;

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
    lbl_userLogin: TLabel;
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
    btn_fecharMenuEmpresas: TSpeedButton;
    ImageList2: TImageList;
    actlst2: TActionList;
    action_TrocandoEmpresa: TAction;
    action_deletandoEmpresa: TAction;
    action_fecharMenuEmpresas: TAction;
    SplitViewMovimento: TSplitView;
    FlowPanelMovimento: TFlowPanel;
    action_configBD: TAction;
    pnl_Movimentacao: TPanel;
    lbl_menuMovimentacao: TLabel;
    btn_movimentacaoSiac: TSpeedButton;
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
    pnl_fundoTrocaEmpresa: TPanel;
    grp_TrocaEmpresa: TGroupBox;
    grp_EmpresaDestino: TGroupBox;
    PageDeletaEmpresa: TTabSheet;
    pnl_fundoDeletaEmpresa: TPanel;
    grp_AcoesDeletaEmpresa: TGroupBox;
    pnl_carregaEmpresa: TPanel;
    pnl_configBancoDados: TPanel;
    act_Home: TAction;
    pnl_fundoPrincipal1: TPanel;
    pnl_fundoPrincipalAlBottom: TPanel;
    pnl_fundoAbrigaImagem: TPanel;
    img_fundo: TImage;
    img_fundo_opacidade: TImage;
    pnl_btnInfoOracle: TPanel;
    grp_InfoGerais: TGroupBox;
    grp_Session: TGroupBox;
    DBGrid_CarregarSession: TDBGrid;
    grp_TableSpace: TGroupBox;
    DBGrid_CarregarTablespaceDiretorio: TDBGrid;
    DBGrid_CarregarUsuarios: TDBGrid;
    lbl_versaoOracle: TLabel;
    DBGrid_CarregarTablespace: TDBGrid;
    pnl_deleteTriggers: TPanel;
    Panel2: TPanel;
    btn_deleteTriggers: TSpeedButton;
    chk_desativarObjetos: TCheckBox;
    OraScriptDeleteTriggers: TOraScript;
    mmo_infoDesativaBD: TMemo;
    OraScriptDeletandoEmpresa: TOraScript;
    OraScriptTrocandoEmpresas: TOraScript;
    ImageListMensagem: TImageList;
    lbl_carregaEmpresa: TLabel;
    btn_detalhesBD: TSpeedButton;
    OraScriptCriarUsuario: TOraScript;
    pnl_abrigaBotoes: TPanel;
    ImageAllSystem: TImageList;
    pnl_bindsOracle: TPanel;
    btn_bindsOracle: TSpeedButton;
    OraScriptCriarUsuarioOriginal: TOraScript;
    pnl_expBackup: TPanel;
    btn_expBkp: TSpeedButton;
    pnl_importarBackup: TPanel;
    btn_importBkp: TSpeedButton;
    pnl_abrigaCriarUsuario: TPanel;
    btn_criarUsuario: TSpeedButton;
    lbl_criarNomeUsuario: TLabel;
    edt_novoUsuario: TEdit;
    pnl_versaoSistema: TPanel;
    btn_versaoSistema: TSpeedButton;
    pnl_dadosEmpresa: TPanel;
    pnl_dadosEndereco: TPanel;
    edt_RAZAO_SOCIAL_NFE: TEdit;
    edt_FANTASIA: TEdit;
    edt_RAZAO_SOCIAL: TEdit;
    edt_EMPRESA_ID: TMaskEdit;
    edt_INSC_MUNICIPAL: TEdit;
    edt_INSC_ESTADUAL: TEdit;
    lbl_razaoSocialNFe: TLabel;
    lbl_nomeFantasia: TLabel;
    lbl_razaoSocial: TLabel;
    lbl_cnpj: TLabel;
    Label17: TLabel;
    lbl_inscricaoEstadual: TLabel;
    edt_CEP: TMaskEdit;
    edt_ENDERECO: TEdit;
    edt_BAIRRO: TEdit;
    edt_NOME_CIDADE: TEdit;
    edt_ESTADO_ID: TEdit;
    Label9: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edt_DDD: TMaskEdit;
    edt_FONE_VOZ: TMaskEdit;
    edt_FONE_FAX: TMaskEdit;
    edt_FONE_DADOS: TMaskEdit;
    edt_FONE_WHATSAPP: TMaskEdit;
    Label81: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    pnl_novosDadosEmpresa: TPanel;
    lbl_cidadeNome: TLabel;
    edt_CIDADE_ID: TEdit;
    shpTrocaEmpresaBottom: TShape;
    edt_E_MAIL: TEdit;
    Label14: TLabel;
    mmo_infTrocaEmpresa: TMemo;
    Panel1: TPanel;
    pnl_trocandoEmpresas: TPanel;
    btn_trocandoEmpresas: TSpeedButton;
    chk_saveScritpTrocando: TCheckBox;
    medt_cpf_cnpj: TMaskEdit;
    lbl_trocaEmpresa: TLabel;
    shpDeletaEmpresaBottom: TShape;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    edt_RAZAO_SOCIAL_NFE_d: TEdit;
    edt_FANTASIA_d: TEdit;
    edt_RAZAO_SOCIAL_d: TEdit;
    edt_EMPRESA_ID_d: TMaskEdit;
    edt_INSC_MUNICIPAL_d: TEdit;
    edt_INSC_ESTADUAL_d: TEdit;
    edt_E_MAIL_d: TEdit;
    Panel4: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edt_CEP_d: TMaskEdit;
    edt_ENDERECO_d: TEdit;
    edt_BAIRRO_d: TEdit;
    edt_NOME_CIDADE_d: TEdit;
    edt_ESTADO_ID_d: TEdit;
    edt_DDD_d: TMaskEdit;
    edt_FONE_VOZ_d: TMaskEdit;
    edt_FONE_FAX_d: TMaskEdit;
    edt_FONE_DADOS_d: TMaskEdit;
    edt_FONE_WHATSAPP_d: TMaskEdit;
    edt_CIDADE_ID_d: TEdit;
    Panel5: TPanel;
    Memo1: TMemo;
    Panel6: TPanel;
    pnl_deletandoEmpresas: TPanel;
    btn_deletandoEmpresas: TSpeedButton;
    chk_saveScriptDeletando: TCheckBox;
    pnl_TelaTrocaEmpresa: TPanel;
    lbl_1: TLabel;
    pnl_TelaDeletaEmpresa: TPanel;
    Label30: TLabel;
    pnl_telaInicial: TPanel;
    lbl_telaInicial: TLabel;
    PageDeletaMovimento: TTabSheet;
    action_DeletaMovimento: TAction;
    pnl_fundoDeleaMovimento: TPanel;
    Panel7: TPanel;
    Label31: TLabel;
    shpDeletaMovimento: TShape;
    btn_movimentacaoFinanceiro: TSpeedButton;
    btn_fecharMenuMovimento: TSpeedButton;
    action_MovimentoFinanceiro: TAction;
    pnl_sistemas: TPanel;
    PageTratarFinanceiro: TTabSheet;
    pnl_tratarFinanceiro: TPanel;
    Shape3: TShape;
    Panel9: TPanel;
    Label32: TLabel;
    pnl_abrigaPainelFinanceiro: TPanel;
    Panel8: TPanel;
    grp_tratarMovimentacaoFinanceira2: TGroupBox;
    rg_selecionarStatusExcluir: TRadioGroup;
    rg_filtroPeriodoFinanceiro: TRadioGroup;
    grp_periodoExclusao: TGroupBox;
    lbl_dataCadastramentoFinal: TLabel;
    lbl_dataCadastramentoInicial: TLabel;
    lbl_dataEmissaoInicial: TLabel;
    lbl_dataEmissaoFinal: TLabel;
    lbl_dataVencimentoInicial: TLabel;
    lbl_dataVencimentoFinal: TLabel;
    lbl_dataBaixaInicial: TLabel;
    lbl_dataBaixaFinal: TLabel;
    chk_dtCadastramento: TCheckBox;
    chk_dtEmissao: TCheckBox;
    chk_dtVencimento: TCheckBox;
    chk_dtBaixa: TCheckBox;
    medt_InicialCadastramento: TMaskEdit;
    medt_FinalCadastramento: TMaskEdit;
    medt_FinalEmissao: TMaskEdit;
    medt_InicialEmissao: TMaskEdit;
    medt_FinalVencimento: TMaskEdit;
    medt_InicialVencimento: TMaskEdit;
    medt_FinalBaixa: TMaskEdit;
    medt_InicialBaixa: TMaskEdit;
    rg_tipoCrCp: TRadioGroup;
    lbl_startOracle: TLabel;
    rg_filtroDeletarAlterar: TRadioGroup;
    grp_alterarTitulos: TGroupBox;
    chk_alterarDocumentoID: TCheckBox;
    chk_limparNossoNumero: TCheckBox;
    chk_limparPedidoTitulos: TCheckBox;
    grp_tratarDocumentoFinanceira: TGroupBox;
    dbgrd_movimentoFinanceiro: TDBGrid;
    pnl_botoesFinanceiroSistema: TPanel;
    pnl_abriBotaoAlterarTitulos: TPanel;
    btn_alterarTitulos: TSpeedButton;
    pnl_abriBotaoExcluirTitulos: TPanel;
    btn_excluirFinanceiro: TSpeedButton;
    pnl_abriBotaoProcessarTitulos: TPanel;
    btn_processarFinanceiro: TSpeedButton;
    Panel16: TPanel;
    btn_infTela: TSpeedButton;
    rg_textoAdicionalDocumento: TRadioGroup;
    edt_textDocumento: TEdit;
    lbl_exemploDocumento: TLabel;
    lbl_textoAdicional: TLabel;
    btn_exemploDocumento: TButton;
    pnl_deletarMovimentoSistema: TPanel;
    pnl_abrigaBtnExcluirMovimentoSiac: TPanel;
    btn_excluirMovimento: TSpeedButton;
    pnl_abrigaBtnAnaliseMovSiac: TPanel;
    btn_analisarExcluirMovimento: TSpeedButton;
    Panel19: TPanel;
    btn_infClickMovimentoDelete: TSpeedButton;
    Panel11: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    btn_deletarCreditos: TSpeedButton;
    Panel20: TPanel;
    Panel21: TPanel;
    grp_tratarCreditoFinanceira: TGroupBox;
    edt_dataInicialCredito: TMaskEdit;
    edt_dataFinalCredito: TMaskEdit;
    lbl_dataFinalCredito: TLabel;
    Label34: TLabel;
    chk_filtroDataCredito: TCheckBox;
    chk_deletarCredito: TCheckBox;
    DBGrid_movimentoDeleteSiac: TDBGrid;
    DBGrid_listaTabelasEssenciais: TDBGrid;
    pnl_separarCabecario: TPanel;
    lbl_tituloTabelasDeletadas: TLabel;
    lbl_tituloTabelasProtegidas: TLabel;
    lbl_separador: TLabel;
    pnl_abrigaBtnAddListaProtegida: TPanel;
    btn_addListaProtegida: TSpeedButton;
    acbrntrtb_tabEnter: TACBrEnterTab;
    pnl_enviarEmail: TPanel;
    btn_enviarEmail: TSpeedButton;
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
    procedure btn_testeClick(Sender: TObject);
    procedure action_TrocandoEmpresaExecute(Sender: TObject);
    procedure action_deletandoEmpresaExecute(Sender: TObject);
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
    procedure BtConectarClick(Sender: TObject);
    procedure BtDesconectarClick(Sender: TObject);
    procedure CtrlBotoes(Modo: Boolean);
    procedure dbPrincipalEmpresasDblClick(Sender: TObject);
    procedure pnl_carregaEmpresaClick(Sender: TObject);
    procedure pnl_carregaEmpresaDblClick(Sender: TObject);
    procedure act_HomeExecute(Sender: TObject);
    procedure btn_deleteTriggersClick(Sender: TObject);
    procedure DBGrid_CarregarUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
    procedure DBGrid_CarregarUsuariosCellClick(Column: TColumn);
    procedure ExecutarOpcaoDeletarUser();
    procedure DBGrid_CarregarSessionDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGrid_CarregarSessionCellClick(Column: TColumn);
    procedure ExecutarKillSession();
    procedure btn_deletandoEmpresasClick(Sender: TObject);
    procedure btn_trocandoEmpresasClick(Sender: TObject);
    function  ValidaAtivacaoProcedimentos: Boolean;
    procedure AtualizarTelaEmpresas;
    procedure btn_detalhesBDClick(Sender: TObject);
    procedure btn_criarUsuarioClick(Sender: TObject);
    procedure ExecutarScriptCriarUsuario;
    procedure btn_importBkpClick(Sender: TObject);
    procedure btn_expBkpClick(Sender: TObject);
    procedure btn_bindsOracleClick(Sender: TObject);
    procedure btn_versaoSistemaClick(Sender: TObject);
    procedure action_DeletaMovimentoExecute(Sender: TObject);
    procedure btn_FecharMenuMovimento2Click(Sender: TObject);
    procedure btn_movimentacaoSiacClick(Sender: TObject);
    procedure action_MovimentoFinanceiroExecute(Sender: TObject);
    procedure rg_filtroPeriodoFinanceiroClick(Sender: TObject);
    procedure btn_processarFinanceiroClick(Sender: TObject);
    procedure btn_alterarTitulosClick(Sender: TObject);
    procedure rg_filtroDeletarAlterarClick(Sender: TObject);
    procedure chk_alterarDocumentoIDClick(Sender: TObject);
    procedure btn_exemploDocumentoClick(Sender: TObject);
    procedure btn_excluirFinanceiroClick(Sender: TObject);
    procedure btn_infTelaClick(Sender: TObject);
    procedure btn_excluirMovimentoClick(Sender: TObject);
    procedure btn_deletarCreditosClick(Sender: TObject);
    procedure chk_filtroDataCreditoClick(Sender: TObject);
    procedure chk_deletarCreditoClick(Sender: TObject);
//    procedure btn_inserirTabelasExcecaoClick(Sender: TObject);
    procedure btn_analisarExcluirMovimentoClick(Sender: TObject);
    procedure btn_infClickMovimentoDeleteClick(Sender: TObject);
    procedure DBGrid_listaTabelasEssenciaisDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGrid_movimentoDeleteSiacDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid_movimentoDeleteSiacDblClick(Sender: TObject);
    procedure DBGrid_listaTabelasEssenciaisDblClick(Sender: TObject);
    procedure btn_addListaProtegidaClick(Sender: TObject);
    procedure btn_addListaDeletarClick(Sender: TObject);
    procedure btn_enviarEmailClick(Sender: TObject);

  private
    FMostrarBranco: Boolean;
    ActiveAlternaLogo: Boolean;
    FLimpar: TClasseLimparMovimento;
    FBtnLimpar: TClasseLimparMovimento;
    Email: TClasseEmailLogs;

    procedure AlternarAtivo;
    procedure EnsureEventBindings;

  public
    function fnc_FecharSistema: Boolean;
    procedure AplicarPermissoesUsuario(const NomeUsuario: string);
    procedure ValidarPermissaoAcao(const NomeAcao: string);
  end;

var
  ViewMain: TViewMain;
    FConsultaBD : TClasseConsultaBD;
    //Variavel Global do sistema.
    vGbl_Empresa_id      : string;
    vGbl_RazaoSocial     : string;
    vGbl_UserLogin       : string;
    vGbl_FuncionarioId   : string;
    vGbl_FuncionarioNome : string;
    vGbl_FListaUsuarios: TStringList;
    vGbl_UsuarioAutorizado: Boolean = False;

implementation

uses
  Classe.funcoes,
  VarGlobal,
  _Biblioteca,
  uDataModule,
  classe.uScriptGeneratorDeleteEmpresas,
  classe.uScriptGeneratorTriggers,
  classe.uScriptGeneratorTrocaEmpresas,
  Classe.ProgressHelper,
  uViewMensagens,
  uViewProgressBar,
  Classe.AtualizaComponentesTela,
  classe.BancoDados,
  Classe.ConsultaEmpresa,
  Classe.MovimentoFinanceiro, uViewlogin;

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
  FLimpar := TClasseLimparMovimento.Create;
  FBtnLimpar := TClasseLimparMovimento.Create;
  Email := TClasseEmailLogs.Create;
end;

procedure TViewMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLimpar);
  FreeAndNil(FBtnLimpar);
  FreeAndNil(Email);
end;

procedure TViewMain.FormShow(Sender: TObject);
var
  iPages: Integer;
begin
  // Remover o nome das abas do PageControl
  begin
    for iPages := 0 to PageControl.PageCount - 1 do
    begin
      PageControl.Pages[iPages].TabVisible := False;
    end;
  end;

  // Abre o sistema com a tela Inicial do Programa
  PageControl.ActivePageIndex := 0;

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

  //  Deixa invisivel o pnl que carrega as informações do banco de dados
  pnl_configBancoDados.Visible:= False;


  TClasseMovimentoFinanceiro.InicializarComportamentos(
    rg_selecionarStatusExcluir,      // TRadioGroup status
    [ chk_dtCadastramento,
      chk_dtEmissao,
      chk_dtVencimento,
      chk_dtBaixa ],                 // 4 checkboxes (nesta ordem)
    [ medt_InicialCadastramento, medt_FinalCadastramento,
      medt_InicialEmissao,   medt_FinalEmissao,
      medt_InicialVencimento,medt_FinalVencimento,
      medt_InicialBaixa,     medt_FinalBaixa ] // 8 mask edits (2 por check)
  );

  // Adicionando camada de comportamento dos botões da Financeiro
  btn_excluirFinanceiro.Enabled := False;
  btn_alterarTitulos.Enabled := False;

  // Aparência inicial (neutra)
  btn_excluirFinanceiro.Font.Color := clGray;
  btn_alterarTitulos.Font.Color := clGray;
  btn_excluirFinanceiro.Cursor := crDefault;
  btn_alterarTitulos.Cursor := crDefault;

  grp_alterarTitulos.Enabled := False;
  rg_textoAdicionalDocumento.Enabled := False;
  edt_textDocumento.Enabled := False;
  lbl_exemploDocumento.visible := False;
  lbl_textoAdicional.Enabled := False;
  btn_deletarCreditos.Enabled:= False;

  // Add nome e Id usuario

  lbl_userLogin.Caption := 'Matrícula & Usuário: ' +
    vGbl_FuncionarioId + ' - ' + vGbl_UserLogin;

  lbl_nomeUsuario.Caption := 'Usuário: ' +
    vGbl_FuncionarioNome;

    // Se houver usuário logado, aplica permissões
  if Trim(vGbl_UserLogin) <> '' then
  begin
    AplicarPermissoesUsuario(vGbl_UserLogin);
  end;

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

function TViewMain.ValidaAtivacaoProcedimentos: Boolean;
begin
    result := True; // Ativa execução
  // Valida se foi Selecionado a empresa para o procedimento
  if ( vGbl_Empresa_id = '' ) then
  begin
    fnc_criar_menssagem(
      'ATENÇÃO',
      '  Nenhuma empresa foi selecionada para o procedimento!',
      '    Você precisa selecionar uma empresa para ativar este recurso. ' + sLineBreak +
      '    Você será direcionado para tela Inicial.',
      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png', 'OK');


    PageControl.ActivePageIndex := 0; // direciona o usuário
    result := False; // bloqueia execução
    Exit;
  end;


  if not( DmModule.StatusConectado ) then
  begin
    fnc_criar_menssagem(
      'ATENÇÃO',
      '  Uma conexão com banco de dados não foi estabelecida!',
      '    Você precisa conectar ao banco de dados para ativar este recurso. ' + sLineBreak +
      '    Você será direcionado para tela de configuração.',
      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\database_error.png', 'OK');


    PageControl.ActivePageIndex := 2; // direciona o usuário
    result := False; // bloqueia execução
    Exit;
  end;

end;

procedure TViewMain.action_TrocandoEmpresaExecute(Sender: TObject);
var
  Consulta: TConsultaEmpresa;
begin
  Consulta := TConsultaEmpresa.Create;

  // Acessa o menu Inicial
  PageControl.ActivePageIndex := 1;
  AlternaSplitViewClose(SplitViewMenu);


  if ( ValidaAtivacaoProcedimentos() ) then
    begin
      try
        Consulta.CarregarConsultaEmpresa(
          vGbl_Empresa_id,  // Parâmetro recebido da variável global
          edt_EMPRESA_ID,
          edt_INSC_MUNICIPAL,
          edt_INSC_ESTADUAL,
          edt_RAZAO_SOCIAL,
          edt_FANTASIA,
          edt_RAZAO_SOCIAL_NFE,
          edt_CEP,
          edt_ENDERECO,
          edt_BAIRRO,
          edt_CIDADE_ID,
          edt_NOME_CIDADE,
          edt_ESTADO_ID,
          edt_DDD,
          edt_FONE_VOZ,
          edt_FONE_FAX,
          edt_FONE_DADOS,
          edt_E_MAIL,
          edt_FONE_WHATSAPP );
      finally
        Consulta.Free;
      end;
    end else
    begin
      Exit;
    end;


end;


procedure TViewMain.action_configBDExecute(Sender: TObject);
begin
  // Troca Empresa
  PageControl.ActivePageIndex := 2;
  AlternaSplitViewClose(SplitViewMenu);
end;

procedure TViewMain.action_DeletaMovimentoExecute(Sender: TObject);
begin
  // Deleta Movimento
  PageControl.ActivePageIndex := 4;
  AlternaSplitViewClose(SplitViewMenu);
end;

procedure TViewMain.action_deletandoEmpresaExecute(Sender: TObject);
var
  ConsultaDel: TConsultaEmpresa;
begin
  ConsultaDel := TConsultaEmpresa.Create;

   // Deleta Empresa
  PageControl.ActivePageIndex := 3;
  AlternaSplitViewClose(SplitViewMenu);

    if ( ValidaAtivacaoProcedimentos() ) then
    begin
      try
        ConsultaDel.CarregarConsultaEmpresa(
          vGbl_Empresa_id,  // Parâmetro recebido da variável global
          edt_EMPRESA_ID_d,
          edt_INSC_MUNICIPAL_d,
          edt_INSC_ESTADUAL_d,
          edt_RAZAO_SOCIAL_d,
          edt_FANTASIA_d,
          edt_RAZAO_SOCIAL_NFE_d,
          edt_CEP_d,
          edt_ENDERECO_d,
          edt_BAIRRO_d,
          edt_CIDADE_ID_d,
          edt_NOME_CIDADE_d,
          edt_ESTADO_ID_d,
          edt_DDD_d,
          edt_FONE_VOZ_d,
          edt_FONE_FAX_d,
          edt_FONE_DADOS_d,
          edt_E_MAIL_d,
          edt_FONE_WHATSAPP_d );
      finally
        ConsultaDel.Free;
      end;
    end else
    begin
      Exit;
    end;

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

procedure TViewMain.action_MovimentoFinanceiroExecute(Sender: TObject);
begin
  if not ValidaAtivacaoProcedimentos then
    Exit;
  // Deleta Movimento Financeiro   - PageTratarFinanceiro
  PageControl.ActivePageIndex := 5;
  AlternaSplitViewClose(SplitViewMenu);
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
  ValidarPermissaoAcao('Menu: Empresas');

  if SplitViewEmpresas.Opened then
    SplitViewEmpresas.close
  else
    SplitViewEmpresas.Open;
end;

procedure TViewMain.act_HomeExecute(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0 ;
  AlternaSplitViewClose(SplitViewMenu);
end;

procedure TViewMain.act_MovimentacaoExecute(Sender: TObject);
begin
  ValidarPermissaoAcao('Menu: Movimentação');

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

procedure TViewMain.btn_criarUsuarioClick(Sender: TObject);
begin
  if ( edt_novoUsuario.Text = '' ) then

  begin
        fnc_criar_menssagem('Administração Banco de Dados',
                   'Atenção!',
                   'Para criar um novo usuário é obrigatório informar o nome!',
                    ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png', 'OK');

    edt_novoUsuario.SetFocus;

  end
  else
  begin
    InicioTelaAguarde();

 // Executa a criação do usuário no banco.
    ExecutarScriptCriarUsuario();

    FimTelaAguarde();

    // Limpa o nome digitado
    edt_novoUsuario.Clear;

    // Carregar/Atualizar GRID de usuários
    FConsultaBD.CarregarUsuarios(DBGrid_CarregarUsuarios);
  end;
end;

procedure TViewMain.btn_deletandoEmpresasClick(Sender: TObject);
var
  ScriptGen: TScriptGeneratorDeleteEmpresas;
  returnUsuario: Boolean;
  saveScriptOracle: TStringList;
  Scripts: TStringList;
  Progress: TProgressHelper;
  i: Integer;
  vEmpresa_id, vRazaoSocial: string;

begin
  if not ValidaAtivacaoProcedimentos then
    Exit; // interrompe tudo, pois a conexão ainda está ativa
  vEmpresa_id :=  qryEmpresas.FieldByName('EMPRESA_ID').AsString ;
  vRazaoSocial := qryEmpresas.FieldByName('RAZAO_SOCIAL').AsString;

  ScriptGen := TScriptGeneratorDeleteEmpresas.Create(DmModule.orsConexao);
  Scripts := TStringList.Create;
  Progress := TProgressHelper.Create;
  try
    // 1 - Gera os scripts dinamicamente
    ScriptGen.Gerar('''' + vEmpresa_id+ '''');

    // Copia os scripts para lista temporária
    Scripts.Text := ScriptGen.GetScripts;

    // 2 - Mostra progress bar durante a geração
    Progress.Start(Scripts.Count, 'Gerando scripts para exclusão...');
    for i := 0 to Scripts.Count - 1 do
    begin
      Progress.Step('Gerando: ' + Scripts[i]);
    end;
    Progress.Finish;

    // 3 - Confirmação do usuário
    if Scripts.Count = 0 then Exit;

    returnUsuario := fnc_criar_menssagem(
                        'EXCLUSÃO DE EMPRESA',
                        vEmpresa_id + ' - ' + vRazaoSocial,
                        'DESEJA REALMENTE EXCLUIR ESTA EMPRESA? ' + sLineBreak +
                        'ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                        'ERRO');

    if not returnUsuario then Exit;

    // 4 - Executa os scripts individualmente
    Progress.Start(Scripts.Count, 'Executando exclusão da empresa...');
    for i := 0 to Scripts.Count - 1 do
    begin
      OraScriptDeletandoEmpresa.SQL.Text := Scripts[i];
      OraScriptDeletandoEmpresa.Execute;

      Progress.Step('Executando: ' + Scripts[i]);
    end;
    Progress.Finish;

    // 5 - Mensagem final de sucesso
    fnc_criar_menssagem('EXCLUSÃO DE EMPRESA',
                        'A EXCLUSÃO DA EMPRESA FOI UM SUCESSO !!!',
                        'Você selecionou a empresa: ' + vEmpresa_id + ' - ' + vRazaoSocial +
                        '. ESTA AÇÃO É IRREVERSÍVEL!!!',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                        'OK');

    // 6 - Salvar script se marcado
    if chk_saveScriptDeletando.Checked then
    begin
      saveScriptOracle := TStringList.Create;
      try
        saveScriptOracle.Text := Scripts.Text;
        saveScriptOracle.SaveToFile('C:\SiacDBManagerLogs\sqlExport_DeleteEmpresa.txt', TEncoding.UTF8);
      finally
        saveScriptOracle.Free;
      end;
    end;

    // Dispara o Email
       Email.EnviarLogOperacao('Deleta Empresa');

    // Atualiza/Limpa Variaveis de ambiente/globais e nome da empresa
       AtualizarTelaEmpresas();

    // Atualiza/Limpa variáveis globais
       TClasseAtualizaComponentesTela.LimparVariaveisGlobais(ViewMain.lbl_carregaEmpresa);

    // Limpando os campos da tela, como a empresa não existe mais, temos que limpar esse dados lixo.
       prcLimparCamposEditaveis(PageDeletaEmpresa);

    // Leva o usuario para a tela inicial do sistema.
       PageControl.ActivePageIndex := 0 ;
    // Dispara o Email
       Email.EnviarLogOperacao('Deleta Empresa');
  finally
    Scripts.Free;
    ScriptGen.Free;
    Progress.Free;
  end;
end;

procedure TViewMain.btn_deletarCreditosClick(Sender: TObject);
var
  Movimento: TClasseMovimentoFinanceiro;
  FiltroData: Boolean;
  DataIni, DataFim: TDateTime;
begin
  Movimento := TClasseMovimentoFinanceiro.Create;
  try
    // 🔹 Verifica se o filtro de data está ativo
    FiltroData := chk_filtroDataCredito.Checked;

    // 🔹 Converte as datas apenas se o filtro estiver ativo
    if FiltroData then
    begin
      if not TryStrToDate(edt_dataInicialCredito.Text, DataIni) then
      begin
        MessageDlg('Informe uma data inicial válida.', mtWarning, [mbOK], 0);
        edt_dataInicialCredito.SetFocus;
        Exit;
      end;

      if not TryStrToDate(edt_dataFinalCredito.Text, DataFim) then
      begin
        MessageDlg('Informe uma data final válida.', mtWarning, [mbOK], 0);
        edt_dataFinalCredito.SetFocus;
        Exit;
      end;

      // 🔸 Primeiro carrega os créditos filtrados para gerar o SQL base
      Movimento.CarregarCreditosFinanceiro(vGbl_Empresa_id, True, DataIni, DataFim);
    end;

    // 🔸 Agora executa a exclusão (truncate ou delete por período)
    Movimento.ExcluirCreditosFinanceiro(FiltroData);

  finally
    Movimento.Free;
  end;

  // Envio de Email.
  Email.EnviarLogOperacao('A exclusão de Créditos Financeiros');

end;


procedure TViewMain.btn_deleteTriggersClick(Sender: TObject);
var
  ScriptGen: TScriptGeneratorTriggers;
  returnUsuario: Boolean;
  saveScriptOracle: TStringList;
  Scripts: TStringList;
  Progress: TProgressHelper;
  i: Integer;
begin
  ValidarPermissaoAcao('Botão: Deletar Triggers');

  ScriptGen := TScriptGeneratorTriggers.Create(DmModule.orsConexao); // já vem com SQL configurado
  Scripts := TStringList.Create;
  Progress := TProgressHelper.Create;

  try
    // 1 - Gera os scripts dinamicamente
    // Passa para classe o nome do usuario logado
    ScriptGen.Gerar(Self.eUsuario.Text);

    // Copia os scripts para o TStringList temporário
    Scripts.Text := ScriptGen.GetScripts;

    // 2 - Mostra progress bar durante a geração
    Progress.Start(Scripts.Count, 'Gerando scripts...');
    for i := 0 to Scripts.Count - 1 do
    begin
      Progress.Step('Gerando: ' + Scripts[i]);
    end;
    Progress.Finish;

    // 3 - Confirmação do usuário antes de executar
    if Scripts.Count = 0 then Exit;

    returnUsuario := fnc_criar_menssagem('ALTERAÇÃO DE OBJETOS DO BANCO DE DADOS',
                                         'DESEJA REALMENTE DESATIVAR OS OBJETOS?',
                                         'ESTE PROCEDIMENTO É REVERSÍVEL',
                                         ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                                         'ERRO');

    if not returnUsuario then Exit;

    // 4 - Limpa o OraScript antes de executar
    OraScriptDeleteTriggers.SQL.Clear;

    // 5 - Inicializa o ProgressBar para execução real
    Progress.Start(Scripts.Count, 'Executando scripts...');

    // 6 - Executa cada script individualmente
    for i := 0 to Scripts.Count - 1 do
    begin
      OraScriptDeleteTriggers.SQL.Text := Scripts[i];
      OraScriptDeleteTriggers.Execute;

      // Atualiza ProgressBar com a informação atual
      Progress.Step('Executando: ' + Scripts[i]);
    end;

    Progress.Finish;

    // 7 - Mensagem de sucesso
    fnc_criar_menssagem('ALTERAÇÃO DE OBJETOS DO BANCO DE DADOS',
                        'OS OBJETOS DO BANCO DE DADOS FORAM DESATIVADOS !!',
                        'TRIGGER''s E CONSTRAINTS FORAM DESATIVADAS',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                        'OK');

    // 8 - Salva script em arquivo opcional
    if chk_desativarObjetos.Checked then
    begin
      saveScriptOracle := TStringList.Create;
      try
        saveScriptOracle.Text := Scripts.Text;
        saveScriptOracle.SaveToFile('C:\SiacDBManagerLogs\sqlExport_DesativarTriggers.txt', TEncoding.UTF8);
      finally
        saveScriptOracle.Free;
      end;
    end;

  finally
    Scripts.Free;
    ScriptGen.Free;
    Progress.Free;
  end;
end;

procedure TViewMain.btn_detalhesBDClick(Sender: TObject);
begin
  FConsultaBD := TClasseConsultaBD.Create;
  try
    // Exemplo 1: carregar versão do Oracle
    FConsultaBD.CarregarVersaoOracle(lbl_versaoOracle);

    // Exemplo 2: carregar Inicialização do Oracle
    FConsultaBD.CarregarStartOracle(lbl_startOracle);

    // Exemplo 3: carregar sessões Ativas
    FConsultaBD.CarregarSessoesAtivas(DBGrid_CarregarSession);

    // Exemplo 4: carregar tablespace
     FConsultaBD.CarregarTablespace(DBGrid_CarregarTablespace);

    // Exemplo 5: carregar usuários
     FConsultaBD.CarregarUsuarios(DBGrid_CarregarUsuarios);

    // Exemplo 6: carregar TableSpace Diretorios
     FConsultaBD.CarregarBancoTablespaceDiretorio(DBGrid_CarregarTablespaceDiretorio);

    // Exemplo 7: atualizar status
    // FConsultaBD.AtualizarEmpresaStatus(1, 'ATIVO');

  finally
   // FConsultaBD.Free;
  end;

  //  Deixa Visivel o pnl que carrega as informações do banco de dados
  pnl_configBancoDados.Visible:= True;
      // Habilitando pnl_deleteTriggers para o usuário
     Self.pnl_deleteTriggers.Visible := True;

    // Habilitando pnl_configBancoDados para o usuário
     pnl_configBancoDados.Visible := True;
end;

procedure TViewMain.btn_enviarEmailClick(Sender: TObject);
var
  Email: TClasseEmailLogs;
begin
  Email := TClasseEmailLogs.Create;
  try
    Email.EnviarLog(
      'Siac DBManager - SIAC Sistemas',
      'Este é um e-mail de teste automático enviado pelo módulo de logs do SiacDBManager.'
    );
  finally
    Email.Free;
  end;
end;

procedure TViewMain.btn_excluirFinanceiroClick(Sender: TObject);
var
  Movimento: TClasseMovimentoFinanceiro;
  DS: TDataSet;
begin
  DS := dbgrd_movimentoFinanceiro.DataSource.DataSet;

  if not Assigned(DS) or DS.IsEmpty then
  begin
    MessageDlg('Nenhum registro disponível no grid para exclusão.', mtWarning, [mbOK], 0);
    Exit;
  end;

  Movimento := TClasseMovimentoFinanceiro.Create;
  try
    Movimento.ExcluirRegistrosFinanceiro(DS);
  finally
    Movimento.Free;
  end;

  // Atualiza o grid após a exclusão
  btn_processarFinanceiro.Click;

  // Envio de Email.
  Email.EnviarLogOperacao('A exclusão de títulos Financeiro');

end;


procedure TViewMain.btn_excluirMovimentoClick(Sender: TObject);
begin
  if not Assigned(FBtnLimpar) then Exit;

 // DBGrid_movimentoDeleteSiac.SelectedRows

  DBGrid_movimentoDeleteSiac.DataSource.DataSet.First;
  FBtnLimpar.GetListaDeletaveis.Clear;
  while not DBGrid_movimentoDeleteSiac.DataSource.DataSet.Eof do
  begin
    FBtnLimpar.GetListaDeletaveis.Add(DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('TABELA').AsString);
    DBGrid_movimentoDeleteSiac.DataSource.DataSet.Next;
  end;

  FBtnLimpar.TruncarTabelasDeletaveis(DBGrid_movimentoDeleteSiac);

  //  Mensagem de sucesso
  fnc_criar_menssagem(' SIAC MOVIMENTO - LIMPAR DADOS',
                      ' OS DADOS DO BANCO DE DADOS FORAM DELETADOS.',
                      ' O PROCEDIMENTO FOI REALIZADO COM SUCESSO !!',
                      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                      'OK');

  // Reinicia a pesquisa da tela
  btn_analisarExcluirMovimentoClick(Sender);
  // Dispara o envio de email
  Email.EnviarLogOperacao('A limpeza da Base de Dados');
end;

procedure TViewMain.btn_exemploDocumentoClick(Sender: TObject);
var
  doc_original: string;
  New_Documento: string;
begin
  doc_original := '1234/01E';

  // Cria o novo valor baseado no modo do RadioGroup
  case rg_textoAdicionalDocumento.ItemIndex of
    0: New_Documento := doc_original + ' ' + edt_textDocumento.Text;   // Prefixo
    1: New_Documento := edt_textDocumento.Text + ' ' + doc_original;   // Sufixo
  else
    New_Documento := doc_original;
  end;

  // Exibe o resultado no label de exemplo
  lbl_exemploDocumento.Caption := New_Documento;
end;


procedure TViewMain.btn_expBkpClick(Sender: TObject);
begin
  ShowMessage('Em construção ...');
end;

procedure TViewMain.btn_FecharMenuMovimento2Click(Sender: TObject);
begin
 ShowMessage('Deleta movimentação');
end;

procedure TViewMain.btn_importBkpClick(Sender: TObject);
begin
  ShowMessage('Em construção ...');
end;

procedure TViewMain.btn_infClickMovimentoDeleteClick(Sender: TObject);
begin
  // Mostra a advertencia do sistema, procedimento irreversivel.
  fnc_criar_menssagem('Siac DBManager',
                      'A exclusão do movimento é permanente.',
                      'Seguir com esta operação, não será possível restaurar o movimento excluído.',
                      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png',
                      'OK');
end;

procedure TViewMain.btn_infTelaClick(Sender: TObject);
begin
  // Mostra a advertencia do sistema, procedimento irreversivel.
  fnc_criar_menssagem('Siac DBManager',
                      'A exclusão/alteração do movimento financeiro é permanente.',
                      'Após confirmar esta operação, não será possível restaurar as informações excluídas/alteradas.',
                      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png',
                      'OK');
end;

//procedure TViewMain.btn_inserirTabelasExcecaoClick(Sender: TObject);
//var
//  ListaTabelas: TStringList;
//  I: Integer;
//begin
//  if not Assigned(FLimpar) then
//    FLimpar := TClasseLimparMovimento.Create;
//
//  // 🔹 Garante que o usuário informou algo
//  if Trim(Memo_TabelasExcecao.Lines.Text) = '' then
//  begin
//    MessageDlg('Digite ao menos uma tabela antes de inserir.', mtWarning, [mbOK], 0);
//    Exit;
//  end;
//
//  ListaTabelas := TStringList.Create;
//  try
//    // 🔹 Carrega as linhas do Memo (nome das tabelas)
//    ListaTabelas.Assign(Memo_TabelasExcecao.Lines);
//
//    // 🔹 Adiciona as novas tabelas personalizadas na lista protegida
//    FLimpar.AdicionarTabelasProtegidasPersonalizadas(ListaTabelas);
//
//    // 🔹 Recarrega o grid de tabelas protegidas com as novas inclusões
//    FLimpar.CarregarListaProtegidas(DBGrid_listaTabelasEssenciais);
//
//    // 🔹 Atualiza labels de resumo
//    FLimpar.AtualizarResumoLabels(lbl_tituloTabelasProtegidas, lbl_tituloTabelasDeletadas);
//
//    // 🔹 Força atualização visual (para coloração azul imediata)
//    DBGrid_listaTabelasEssenciais.Refresh;
//    DBGrid_listaTabelasEssenciais.Repaint;
//
//    //Remover a tabela da lista Tabelas Deletadas
//    for I := 0 to Memo_TabelasExcecao.Lines.Count - 1 do
//    begin
//      if DBGrid_movimentoDeleteSiac.DataSource.DataSet.Locate('TABELA', Memo_TabelasExcecao.Lines[I], []) then
//      begin
//        DBGrid_movimentoDeleteSiac.DataSource.DataSet.Delete;
//      end;
//    end;
//
//    Application.ProcessMessages;
//
//    MessageDlg('Tabelas adicionadas à lista de exceções com sucesso!' + sLineBreak +
//               'Essas tabelas agora são protegidas e marcadas em azul.',
//               mtInformation, [mbOK], 0);
//
//  finally
//    ListaTabelas.Free;
//  end;
//end;




procedure TViewMain.btn_movimentacaoSiacClick(Sender: TObject);
begin
  ShowMessage('Delete Movimento - Financeiro');
end;

procedure TViewMain.btn_processarFinanceiroClick(Sender: TObject);
var
  ConsultaFinan: TClasseMovimentoFinanceiro;
  DS: TDataSet;
begin
  ConsultaFinan := TClasseMovimentoFinanceiro.Create;
  try
    ConsultaFinan.CarregarMovimentoFinanceiro(
      dbgrd_movimentoFinanceiro,
      vGbl_Empresa_id,
      rg_tipoCrCp.ItemIndex,
      rg_selecionarStatusExcluir.ItemIndex,
      rg_filtroPeriodoFinanceiro.ItemIndex
    );

    //  Após carregar a consulta, verifica se há registros no dataset
    DS := dbgrd_movimentoFinanceiro.DataSource.DataSet;
    if not Assigned(DS) or DS.IsEmpty then
    begin
      MessageDlg('Nenhum resultado encontrado para os parâmetros definidos.', mtInformation, [mbOK], 0);

      //  Desabilita botões, pois não há dados para ação
      btn_excluirFinanceiro.Enabled := False;
      btn_alterarTitulos.Enabled := False;
      btn_excluirFinanceiro.Font.Color := clGray;
      btn_alterarTitulos.Font.Color := clGray;
      btn_excluirFinanceiro.Cursor := crDefault;
      btn_alterarTitulos.Cursor := crDefault;

      Exit;
    end;

  finally
  //  ConsultaFinan.Free;
  end;

  //  Comportamento visual e funcional conforme o modo
  case rg_filtroDeletarAlterar.ItemIndex of
    0: // Deletar Movimento
      begin
        btn_excluirFinanceiro.Enabled := True;
        btn_excluirFinanceiro.Font.Color := clRed;
        btn_excluirFinanceiro.Cursor := crHandPoint;

        btn_alterarTitulos.Enabled := False;
        btn_alterarTitulos.Font.Color := clGray;
        btn_alterarTitulos.Cursor := crDefault;
      end;
    1: // Alterar Movimento
      begin
        btn_excluirFinanceiro.Enabled := False;
        btn_excluirFinanceiro.Font.Color := clGray;
        btn_excluirFinanceiro.Cursor := crDefault;

        btn_alterarTitulos.Enabled := True;
        btn_alterarTitulos.Font.Color := clGreen;
        btn_alterarTitulos.Cursor := crHandPoint;
      end;
  else
    btn_excluirFinanceiro.Enabled := False;
    btn_alterarTitulos.Enabled := False;
    btn_excluirFinanceiro.Font.Color := clGray;
    btn_alterarTitulos.Font.Color := clGray;
    btn_excluirFinanceiro.Cursor := crDefault;
    btn_alterarTitulos.Cursor := crDefault;
  end;
end;



procedure TViewMain.btn_testeClick(Sender: TObject);
begin
  ShowMessage('testes');
end;

procedure TViewMain.btn_trocandoEmpresasClick(Sender: TObject);
var
  ScriptGen: TScriptGeneratorTrocaEmpresa;
  returnUsuario: Boolean;
  saveScriptOracle: TStringList;
  Scripts: TStringList;
  Progress: TProgressHelper;
  i: Integer;
  vEmpresa_id, vRazaoSocial, newEmpresa_id, newCnpj: string;
begin
  newCnpj := fnc_sonumeros(medt_cpf_cnpj.Text);

  if (newCnpj <> '') and (Length(newCnpj) = 14) then
  begin
    vEmpresa_id   := qryEmpresas.FieldByName('EMPRESA_ID').AsString;
    vRazaoSocial  := qryEmpresas.FieldByName('RAZAO_SOCIAL').AsString;
    newEmpresa_id := medt_cpf_cnpj.Text;

    if newEmpresa_id = vEmpresa_id then
     // Validação do CNPJ inserido.
      begin
          returnUsuario := fnc_criar_menssagem(
                          'ALTERAÇÃO DE EMPRESA',
                          vEmpresa_id + ' - ' + vRazaoSocial,
                          'O CNPJ INSERIDO É IGUAL AO SELECIONADO.' + sLineBreak +
                          'ESTA AÇÃO NÃO PODERÁ PROSEGUIR.',
                          ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoAviso.png',
                          'OK');
          Exit;
      end;

    ScriptGen := TScriptGeneratorTrocaEmpresa.Create(DmModule.orsConexao);
    Scripts   := TStringList.Create;
    Progress  := TProgressHelper.Create;
    try
      // 1 - Gera os scripts dinamicamente
      ScriptGen.Gerar('''' + vEmpresa_id + '''', '''' + newEmpresa_id + '''');

      // Copia os scripts para lista temporária
      Scripts.Text := ScriptGen.GetScripts;

      // 2 - Mostra progress bar durante a geração
      Progress.Start(Scripts.Count, 'Gerando scripts de troca...');
      for i := 0 to Scripts.Count - 1 do
      begin
        Progress.Step('Gerando: ' + Scripts[i]);
      end;
      Progress.Finish;

      // 3 - Confirmação do usuário
      if Scripts.Count = 0 then Exit;

      returnUsuario := fnc_criar_menssagem(
                          'ALTERAÇÃO DE EMPRESA',
                          vEmpresa_id + ' - ' + vRazaoSocial,
                          'DESEJA REALMENTE ALTERAR O CNPJ DA EMPRESA?' + sLineBreak +
                          'ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                          ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                          'ERRO');
//
      if not returnUsuario then Exit;

      // 4 - Executa os scripts individualmente
      Progress.Start(Scripts.Count, 'Executando alteração da empresa...');
      for i := 0 to Scripts.Count - 1 do
      begin
        OraScriptTrocandoEmpresas.SQL.Text := Scripts[i];
        OraScriptTrocandoEmpresas.Execute;

        Progress.Step('Executando: ' + Scripts[i]);
      end;
      Progress.Finish;

        vGbl_Empresa_id := newEmpresa_id;
      // 5 - Mensagem final de sucesso
      fnc_criar_menssagem('ALTERAÇÃO DE EMPRESA',
                          'A ALTERAÇÃO DA EMPRESA FOI UM SUCESSO !!!',
                          'Você alterou o CNPJ da empresa: ' + vEmpresa_id + ' - ' + vRazaoSocial +
                          ', para o novo CNPJ: ' + newEmpresa_id,
                          ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                          'OK');

      // 6 - Enviar Log E-mail
      Email.EnviarLogOperacao('Troca Empresa, CNPJ Original: ' + vEmpresa_id);

      // 7 - Salvar script se marcado
      if chk_saveScritpTrocando.Checked then
      begin
        saveScriptOracle := TStringList.Create;
        try
          saveScriptOracle.Text := Scripts.Text;
          saveScriptOracle.SaveToFile('C:\SiacDBManager\sqlExport_TrocaEmpresa.txt', TEncoding.UTF8);
        finally
          saveScriptOracle.Free;
        end;
      end;

    // Atualiza/Limpa Variaveis de ambiente/globais e nome da empresa
       AtualizarTelaEmpresas();

    // Atualiza/Limpa variáveis globais
       TClasseAtualizaComponentesTela.LimparVariaveisGlobais(ViewMain.lbl_carregaEmpresa);

    // Limpando os campos da tela, como a empresa não existe mais, temos que limpar esse dados lixo.
       prcLimparCamposEditaveis(PageDeletaEmpresa);

    // Leva o usuario para a tela inicial do sistema.
       PageControl.ActivePageIndex := 0 ;

    finally
      Scripts.Free;
      ScriptGen.Free;
      Progress.Free;
    end;
  end
  else
  begin
    fnc_criar_menssagem('TROCA EMPRESA',
                        'PARA EXECUTAR O PROCEDIMENTO, INFORME O NOVO CNPJ!',
                        'O NOVO CNPJ ESTÁ VAZIO OU INCOMPLETO.',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoAviso.png',
                        'OK');
    medt_cpf_cnpj.SetFocus;
  end;
end;


procedure TViewMain.btn_versaoSistemaClick(Sender: TObject);
begin
  // Mostra a Versão do sistema, somente pra preencher a tela com botões.
  fnc_criar_menssagem('Siac DBManager',
                      'Versão do Sistema  -  1.1.5.3 - R07  -  @2025',
                      'Todos direitos reservados à: www.siacsistemas.com.br',
                      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png',
                      'OK');
end;

procedure TViewMain.chk_alterarDocumentoIDClick(Sender: TObject);
begin
  if chk_alterarDocumentoID.Checked then
  begin
    rg_textoAdicionalDocumento.Enabled := True;
    edt_textDocumento.Enabled := True;
    lbl_exemploDocumento.Visible := True;
    lbl_textoAdicional.Enabled := True;
  end
  else
  begin
    rg_textoAdicionalDocumento.Enabled := False;
    edt_textDocumento.Enabled := False;
    lbl_exemploDocumento.Visible := False;
    lbl_textoAdicional.Enabled := False;
  end;

end;


procedure TViewMain.chk_deletarCreditoClick(Sender: TObject);
begin
   if chk_deletarCredito.Checked then
   begin
     btn_deletarCreditos.Enabled:=True;
   end
     else
   begin
     btn_deletarCreditos.Enabled:=False;
   end;
end;

procedure TViewMain.chk_filtroDataCreditoClick(Sender: TObject);
begin
   if chk_filtroDataCredito.Checked then
   begin
      edt_dataInicialCredito.Enabled := True;
      edt_dataFinalCredito.Enabled := True;
   end
   else
   begin
      edt_dataInicialCredito.Enabled := false;
      edt_dataFinalCredito.Enabled:= false;
   end;
end;

procedure TViewMain.btn_alterarTitulosClick(Sender: TObject);
var
  Movimento: TClasseMovimentoFinanceiro;
  TextoAdicional: String;
  ModoTexto: Integer;
  DS: TDataSet;
begin
  DS := dbgrd_movimentoFinanceiro.DataSource.DataSet;

  if not Assigned(DS) or DS.IsEmpty then
  begin
    MessageDlg('Nenhum registro carregado no grid.', mtWarning, [mbOK], 0);
    Exit;
  end;

  // 🔸 Validação centralizada — apenas uma vez
  if chk_alterarDocumentoID.Checked then
  begin
    if Trim(edt_textDocumento.Text) = '' then
    begin
      MessageDlg('Digite um texto adicional para alterar o DOCUMENTO_ID.', mtWarning, [mbOK], 0);
      edt_textDocumento.SetFocus;
      Exit;
    end;
  end;

  // 🔸 Confirmação do usuário
  if MessageDlg('Aplicar as alterações definidas a todos os registros exibidos?',
     mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Movimento := TClasseMovimentoFinanceiro.Create;
  try
    TextoAdicional := Trim(edt_textDocumento.Text);
    ModoTexto := rg_textoAdicionalDocumento.ItemIndex;

    Movimento.AplicarAlteracoesEmLote(
      DS,
      chk_limparPedidoTitulos.Checked,
      chk_limparNossoNumero.Checked,
      chk_alterarDocumentoID.Checked,
      TextoAdicional,
      ModoTexto
    );
  finally
    Movimento.Free;
  end;

  // 🔸 Atualiza o grid
  btn_processarFinanceiro.Click;

  // Envio de Email.
  Email.EnviarLogOperacao('Alteração de Títulos Financeiro');

end;

procedure TViewMain.btn_analisarExcluirMovimentoClick(Sender: TObject);
begin
  DBGrid_movimentoDeleteSiac.DataSource := nil;
  //  Garante que o objeto de limpeza foi criado
  if not Assigned(FLimpar) then
    FLimpar := TClasseLimparMovimento.Create;

  //  Verifica conexão antes de continuar
  if (not Assigned(DmModule)) or (not DmModule.orsConexao.Connected) then
  begin
    MessageDlg('Conexão com o banco de dados não está ativa.' + sLineBreak +
               'Conecte-se ao banco antes de continuar.',
               mtWarning, [mbOK], 0);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    try
      // =============================================================
      // 1 Executa a análise principal das tabelas
      // =============================================================
      FLimpar.ExecutarAnaliseTabelas;

      // =============================================================
      // 2 Recarrega as tabelas protegidas no DBGrid (lado esquerdo)
      // =============================================================
      FLimpar.CarregarListaProtegidas(DBGrid_listaTabelasEssenciais);

      // =============================================================
      // 3 Executa o SQL dinâmico e carrega as tabelas com dados (>0)
      // =============================================================
      FLimpar.CarregarTabelasComDados(DBGrid_movimentoDeleteSiac);

      // =============================================================
      // 4 Atualiza os labels de resumo (protegidas e deletáveis)
      // =============================================================
      FLimpar.AtualizarResumoLabels(lbl_tituloTabelasProtegidas, lbl_tituloTabelasDeletadas);

      // =============================================================
      // 5 Força redesenho completo dos grids (cores e fontes)
      // =============================================================
      DBGrid_listaTabelasEssenciais.Refresh;
      DBGrid_listaTabelasEssenciais.Repaint;
      DBGrid_movimentoDeleteSiac.Refresh;
      DBGrid_movimentoDeleteSiac.DataSource.DataSet.First;
      Application.ProcessMessages;

    except
      on E: Exception do
      begin
        MessageDlg('Erro ao executar análise: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
  // Habilita o botão para excluir o movimento,
  btn_excluirMovimento.Enabled := True;
end;

procedure TViewMain.btn_bindsOracleClick(Sender: TObject);
begin
  try
    FConsultaBD.ExecutarBindsOracle(nil, 'Parâmetros e Configuração do Oracle');
  except
    on E: Exception do
      ShowMessage('Erro ao executar consulta de parâmetros Oracle: ' + E.Message);
  end;
end;

procedure TViewMain.img_logoEmpresaBrancoClick(Sender: TObject);
begin
  // quando usuário clicar na imagem Azul pause/retorna a alternância
  AlternarAtivo;
end;

procedure TViewMain.img_logoEmpresaAzulClick(Sender: TObject);
begin
  // quando usuário clicar na imagem branca pause/retorna a alternância
  AlternarAtivo;
end;

procedure TViewMain.img_logoEnableClick(Sender: TObject);
begin
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

procedure TViewMain.pnl_carregaEmpresaClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  AlternaSplitViewClose(SplitViewMenu);
end;

procedure TViewMain.pnl_carregaEmpresaDblClick(Sender: TObject);
begin
 PageControl.ActivePageIndex := 0;
 AlternaSplitViewClose(SplitViewMenu);
end;

procedure TViewMain.rg_filtroDeletarAlterarClick(Sender: TObject);
begin

begin
  case rg_filtroDeletarAlterar.ItemIndex of
    0:
      begin
        grp_alterarTitulos.Enabled := False;
        btn_excluirFinanceiro.Enabled := True;
        btn_excluirFinanceiro.Font.Color := clRed;
        btn_excluirFinanceiro.Cursor := crHandPoint;

        btn_alterarTitulos.Enabled := False;
        btn_alterarTitulos.Font.Color := clGray;
        btn_alterarTitulos.Cursor := crDefault;
      end;
    1:
      begin
        grp_alterarTitulos.Enabled := True;
        btn_excluirFinanceiro.Enabled := False;
        btn_excluirFinanceiro.Font.Color := clGray;
        btn_excluirFinanceiro.Cursor := crDefault;

        btn_alterarTitulos.Enabled := True;
        btn_alterarTitulos.Font.Color := clGreen;
        btn_alterarTitulos.Cursor := crHandPoint;
      end;
  else
    btn_excluirFinanceiro.Enabled := False;
    btn_alterarTitulos.Enabled := False;
    btn_excluirFinanceiro.Font.Color := clGray;
    btn_alterarTitulos.Font.Color := clGray;
    btn_excluirFinanceiro.Cursor := crDefault;
    btn_alterarTitulos.Cursor := crDefault;
  end;
end;
end;

procedure TViewMain.rg_filtroPeriodoFinanceiroClick(Sender: TObject);
begin
 // Controla as opções de datas para o usuario
  if rg_filtroPeriodoFinanceiro.ItemIndex = 1 then
     grp_periodoExclusao.Enabled := True
  else
     grp_periodoExclusao.Enabled := False;
end;


procedure TViewMain.btn_addListaDeletarClick(Sender: TObject);
begin
  ShowMessage('Adicionar lista para Remover');
end;

procedure TViewMain.btn_addListaProtegidaClick(Sender: TObject);
var
  MemoForm: TForm;
  MemoInput: TMemo;
  BtnOk, BtnCancel: TButton;
  Lista: TStringList;
begin
  // Cria form temporário
  MemoForm := TForm.Create(nil);
  try
    MemoForm.Caption := 'Adicionar Tabelas Protegidas';
    MemoForm.BorderStyle := bsSizeable;
    MemoForm.Position := poScreenCenter;
    MemoForm.Width := 600;
    MemoForm.Height := 400;
    MemoForm.Color := clTeal;
    MemoForm.Font.Name := 'Segoe UI';
    MemoForm.Font.Size := 10;

    // 🔹 Cria o TMemo para digitação
    MemoInput := TMemo.Create(MemoForm);
    MemoInput.Parent := MemoForm;
    MemoInput.Align := alClient;
    MemoInput.ScrollBars := ssVertical;
    MemoInput.WordWrap := False;
    MemoInput.Font.Name := 'Consolas';
    MemoInput.Font.Size := 11;
    MemoInput.Font.Color := clGreen;
    MemoInput.Lines.Add('Digite aqui os nomes das tabelas que deseja proteger...');
    MemoInput.Lines.Add('Um nome de tabela por linha.');
    MemoInput.Lines.Add('TABELA1');
    MemoInput.Lines.Add('TABELA2');
    MemoInput.Lines.Add('TABELA3');
    MemoInput.Lines.Add('TABELA4');
    MemoInput.SelStart := 0;

    // 🔹 Botão OK
    BtnOk := TButton.Create(MemoForm);
    BtnOk.Parent := MemoForm;
    BtnOk.Caption := 'Confirmar';
    BtnOk.ModalResult := mrOk;
    BtnOk.Default := True;
    BtnOk.Top := MemoForm.ClientHeight - 45;
    BtnOk.Left := MemoForm.ClientWidth - 180;
    BtnOk.Width := 80;
    BtnOk.Anchors := [akRight, akBottom];

    // 🔹 Botão Cancelar
    BtnCancel := TButton.Create(MemoForm);
    BtnCancel.Parent := MemoForm;
    BtnCancel.Caption := 'Cancelar';
    BtnCancel.ModalResult := mrCancel;
    BtnCancel.Cancel := True;
    BtnCancel.Top := BtnOk.Top;
    BtnCancel.Left := BtnOk.Left + BtnOk.Width + 10;
    BtnCancel.Width := 80;
    BtnCancel.Anchors := [akRight, akBottom];

    if BtnCancel.ModalResult = mrOk then
       // Desabilita o botão para excluir o movimento
    btn_excluirMovimento.Enabled := False;



    // 🔹 Mostra o formulário de forma modal
    if MemoForm.ShowModal = mrOk then
    begin
      // Cria lista e preenche com o conteúdo digitado
      Lista := TStringList.Create;
      try
        // Remove linhas vazias e espaços extras
        Lista.Text := Trim(MemoInput.Lines.Text);
        Lista.StrictDelimiter := True;

        // 🔹 Aqui você pode chamar seu método existente:
        // AdicionarTabelasProtegidasPersonalizadas(Lista);
        FLimpar.AdicionarTabelasProtegidasPersonalizadas(Lista);

        // E atualizar o grid visual
        FLimpar.CarregarListaProtegidas(DBGrid_listaTabelasEssenciais);

        // Desabilita o botão para excluir o movimento
        btn_excluirMovimento.Enabled := False;

      finally
        Lista.Free;
      end;
    end;

  finally
    MemoForm.Free;
  end;
end;


procedure TViewMain.img_closeClick(Sender: TObject);
begin
  fnc_FecharSistema();
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

    //Ativando a qry do DBGridEmpresas
     qryEmpresas.Open;
     dbPrincipalEmpresas.Visible:=True;

    fnc_criar_menssagem('CONFIGURAÇÃO AO BANCO DE DADOS ORACLE',
               'Configuração de banco de dados',
               'Conexão com o banco de dados estabelecida com sucesso!',
                ExtractFilePath(Application.ExeName) + 'Arquivos\icones\database_connection.png', 'OK');


    // Troca a imagem da tela Main/Tela princial
    img_fundo.Visible := True;
    img_fundo_opacidade.Visible := False;

    // Habilitando o pnl_btnInfoOracle
    pnl_btnInfoOracle.Visible := True;
  end
  else
  begin
    CtrlBotoes(False);
   fnc_criar_menssagem('CONFIGURAÇÃO AO BANCO DE DADOS ORACLE',
                   'Falha na configuração de banco de dados!',
                   'Verifique as configurações de conexão.',
                    ExtractFilePath(Application.ExeName) + 'Arquivos\icones\database_error.png',
                   'OK');
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

    // Desabilitando o pnl_btnInfoOracle
    pnl_btnInfoOracle.Visible := False;
    pnl_btnInfoOracle.Visible := False;

    // Desabilitando pnl_deleteTriggers para o usuário
     Self.pnl_deleteTriggers.Visible := False;

    // Desabilitando pnl_configBancoDados para o usuário
     pnl_configBancoDados.Visible := False;

    begin
      // Passa o SQL da empresa Selecionada para o form responsavel pela edição da empresa
       TClasseAtualizaComponentesTela.AtualizarVariaveisGlobais(ViewMain.lbl_carregaEmpresa,
                                                                ViewMain.qryEmpresas       );
     end;

   dbPrincipalEmpresas.Visible:=False;
  end;
end;

function TViewMain.fnc_FecharSistema: Boolean;
begin
  Result := fnc_criar_menssagem('FECHAR SISTEMA',
                                'A FUNÇÃO PARA FECHAR O SISTEMA FOI ACIONADA',
                                'DESEJA REALMENTE SAIR DO SISTEMA ?',
                                ExtractFilePath(Application.ExeName) +
                                'Arquivos\icones\icon_aviso.png', 'ERRO');

  // Se o usuário clicou em "Não" ou "Cancelar", interrompe
  if not Result then
   Abort;

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

procedure TViewMain.DBGrid_CarregarUsuariosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BtnRect: TRect;
  TextoBotao: string;
  Grid: TDBGrid;
begin
  Grid := Sender as TDBGrid;

  // Verifica se é a coluna que representa o "botão"
  if Column.Title.Caption = 'DROP USER' then
  begin
    BtnRect := Rect;
    InflateRect(BtnRect, -6, -1); // pequenas margens internas

    // --- Fundo branco ---
    Grid.Canvas.Brush.Color := clWhite;
    Grid.Canvas.FillRect(Rect);

    // --- Moldura cinza do botão ---
    DrawEdge(Grid.Canvas.Handle, BtnRect, EDGE_RAISED, BF_RECT);

    // --- Texto vermelho ---
    Grid.Canvas.Font.Color := clRed;
    Grid.Canvas.Brush.Style := bsClear; // para não sobrepor o texto com cor de fundo

    TextoBotao := 'Remover';
    DrawText(Grid.Canvas.Handle, PChar(TextoBotao), Length(TextoBotao),
      BtnRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

    // Restaura o brush padrão
    Grid.Canvas.Brush.Style := bsSolid;
  end
  else
    // Desenho padrão das outras colunas
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TViewMain.DBGrid_listaTabelasEssenciaisDblClick(Sender: TObject);
var
  TotalLinhas: Integer;
begin
  DBGrid_listaTabelasEssenciais.DataSource.DataSet.DisableControls;
  DBGrid_movimentoDeleteSiac.DataSource.DataSet.DisableControls;
  try
    if DBGrid_listaTabelasEssenciais.DataSource.DataSet.IsEmpty then
      Exit;

    DBGrid_movimentoDeleteSiac.DataSource.DataSet.Insert;
    DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('TABELA').AsString :=
      DBGrid_listaTabelasEssenciais.DataSource.DataSet.FieldByName('TABELA_PROTEGIDA').AsString;

    DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('QTD_LINHAS').AsInteger :=
      fnc_contar_registros_tabela(DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('TABELA').AsString);

    // 🔹 NOVO: Marca o tipo de origem do item adicionado
    if DBGrid_movimentoDeleteSiac.DataSource.DataSet.FindField('TIPO_ITEM') <> nil then
      DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('TIPO_ITEM').AsString := 'PERSONALIZADA';

    DBGrid_movimentoDeleteSiac.DataSource.DataSet.Post;
    DBGrid_listaTabelasEssenciais.DataSource.DataSet.Delete;

    // 🔹 Atualiza labels
    TotalLinhas := 0;
    DBGrid_movimentoDeleteSiac.DataSource.DataSet.First;
    while not DBGrid_movimentoDeleteSiac.DataSource.DataSet.Eof do
    begin
      if not DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('QTD_LINHAS').IsNull then
        Inc(TotalLinhas, DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('QTD_LINHAS').AsInteger);
      DBGrid_movimentoDeleteSiac.DataSource.DataSet.Next;
    end;

    lbl_tituloTabelasDeletadas.Caption := Format(
      'Tabelas deletáveis: %d | Total de linhas: %s',
      [DBGrid_movimentoDeleteSiac.DataSource.DataSet.RecordCount, FormatFloat('#,##0', TotalLinhas)]
    );

    lbl_tituloTabelasProtegidas.Caption := Format(
      'Tabelas protegidas: %d',
      [DBGrid_listaTabelasEssenciais.DataSource.DataSet.RecordCount]
    );

  finally
    DBGrid_movimentoDeleteSiac.DataSource.DataSet.First;
    DBGrid_listaTabelasEssenciais.DataSource.DataSet.First;
    DBGrid_movimentoDeleteSiac.DataSource.DataSet.EnableControls;
    DBGrid_listaTabelasEssenciais.DataSource.DataSet.EnableControls;
  end;
end;


procedure TViewMain.DBGrid_listaTabelasEssenciaisDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  Origem: string;
  Canvas: TCanvas;
begin
  if not Assigned(FLimpar) then Exit;
  Canvas := DBGrid_listaTabelasEssenciais.Canvas;

  // Obtém o tipo de origem (SISTEMA ou PERSONALIZADA)
  if Assigned(Column.Field) and (Column.Field.DataSet.FindField('TIPO_ORIGEM') <> nil) then
    Origem := UpperCase(Column.Field.DataSet.FieldByName('TIPO_ORIGEM').AsString)
  else
    Origem := '';

  // 🔹 Cor por tipo de origem
  if Origem = 'PERSONALIZADA' then
  begin
    Canvas.Brush.Color := RGB(200, 230, 255); // Azul pastel
    Canvas.Font.Style := [fsBold];
  end
  else if Origem = 'SISTEMA' then
  begin
    Canvas.Brush.Color := RGB(220, 255, 220); // Verde pastel
    Canvas.Font.Style := [];
  end
  else
    Canvas.Brush.Color := clWindow;

  // 🔹 Seleção padrão do grid
  if gdSelected in State then
  begin
    Canvas.Brush.Color := clHighlight;
    Canvas.Font.Color := clHighlightText;
  end;

  // Desenha o texto
  Canvas.FillRect(Rect);
  Canvas.TextOut(Rect.Left + 4, Rect.Top + 2, Column.Field.AsString);
end;


procedure TViewMain.DBGrid_movimentoDeleteSiacDblClick(Sender: TObject);
var
  TotalLinhas: Integer;
begin
  DBGrid_movimentoDeleteSiac.DataSource.DataSet.DisableControls;
  if DBGrid_movimentoDeleteSiac.DataSource.DataSet.IsEmpty then
  begin
    Exit;
  end;

  DBGrid_listaTabelasEssenciais.DataSource.DataSet.Insert;
  DBGrid_listaTabelasEssenciais.DataSource.DataSet.FieldByName('TABELA_PROTEGIDA').AsString := DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('TABELA').AsString;
  DBGrid_listaTabelasEssenciais.DataSource.DataSet.FieldByName('TIPO_ORIGEM').AsString := 'PERSONALIZADA';
  DBGrid_listaTabelasEssenciais.DataSource.DataSet.Post;

  DBGrid_movimentoDeleteSiac.DataSource.DataSet.Delete;
  while not DBGrid_movimentoDeleteSiac.DataSource.DataSet.Eof do
  begin
    if not DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('QTD_LINHAS').IsNull then
      Inc(TotalLinhas, DBGrid_movimentoDeleteSiac.DataSource.DataSet.FieldByName('QTD_LINHAS').AsInteger);
    DBGrid_movimentoDeleteSiac.DataSource.DataSet.Next;
  end;

  DBGrid_movimentoDeleteSiac.DataSource.DataSet.First;
  lbl_tituloTabelasDeletadas.Caption := Format('Tabelas deletáveis: %d | Total de linhas: %s', [DBGrid_movimentoDeleteSiac.DataSource.DataSet.RecordCount, FormatFloat('#,##0', TotalLinhas)]);
  DBGrid_movimentoDeleteSiac.DataSource.DataSet.EnableControls;

  lbl_tituloTabelasProtegidas.Caption := Format('Tabelas protegidas: %d', [DBGrid_listaTabelasEssenciais.DataSource.DataSet.RecordCount]);
end;

procedure TViewMain.DBGrid_movimentoDeleteSiacDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  TipoItem: string;
  Canvas: TCanvas;
begin
  Canvas := (Sender as TDBGrid).Canvas;

  if (Column.Field = nil) or (Column.Field.DataSet = nil) then
    Exit;

  TipoItem := '';
  if Column.Field.DataSet.FindField('TIPO_ITEM') <> nil then
    TipoItem := UpperCase(Column.Field.DataSet.FieldByName('TIPO_ITEM').AsString);

  // 🔹 Cores por tipo de item
  if not (gdSelected in State) then
  begin
    if TipoItem = 'PERSONALIZADA' then
    begin
      Canvas.Brush.Color := RGB(255, 255, 180); // Amarelo claro
      Canvas.Font.Style := [fsBold];
    end
    else if TipoItem = 'SISTEMA' then
    begin
      Canvas.Brush.Color := RGB(255, 220, 220); // Vermelho claro
      Canvas.Font.Style := [];
    end
    else
      Canvas.Brush.Color := clWindow;

    Canvas.Font.Color := clBlack;
  end
  else
  begin
    Canvas.Brush.Color := clHighlight;
    Canvas.Font.Color := clHighlightText;
  end;

  Canvas.FillRect(Rect);
  Canvas.TextOut(Rect.Left + 4, Rect.Top + 2, Column.Field.AsString);
end;


procedure TViewMain.ExecutarOpcaoDeletarUser;
var
  LConsultaBD: TClasseConsultaBD;
begin
  LConsultaBD := TClasseConsultaBD.Create;
    try
      LConsultaBD.ExecutarDropUser(DBGrid_CarregarUsuarios.DataSource.DataSet.FieldByName('USERNAME').AsString);
    finally
      LConsultaBD.Destroy
    end;
end;

procedure TViewMain.ExecutarKillSession;
var
  LConsultaBD: TClasseConsultaBD;
begin
  LConsultaBD := TClasseConsultaBD.Create;
    try
      LConsultaBD.ExecutarKillSession(DBGrid_CarregarSession.DataSource.DataSet.FieldByName('SID').AsString,
                                   DBGrid_CarregarSession.DataSource.DataSet.FieldByName('SERIAL').AsString);
    finally
      LConsultaBD.Destroy
    end;
end;

procedure TViewMain.DBGrid_CarregarSessionCellClick(Column: TColumn);
begin
  if Column.Title.Caption = 'KILL' then
  begin
   // Pegando o SID de um DbGrid
   //ShowMessage(DBGrid_CarregarSession.DataSource.DataSet.FieldByName('SID').AsString );
   InicioTelaAguarde();
   ExecutarKillSession();
   FimTelaAguarde();

    fnc_criar_menssagem('Administração Banco de Dados',
                   'Uma sessão do usuário: '  + DBGrid_CarregarSession.DataSource.DataSet.FieldByName('USERNAME').AsString + ' foi encerrada.',
                   'Detalhes de sessão: ' + #13#10 +
                   '   Programa: '+ DBGrid_CarregarSession.DataSource.DataSet.FieldByName('PROGRAM').AsString + #13#10 +
                   '   Terminal: '+ DBGrid_CarregarSession.DataSource.DataSet.FieldByName('TERMINAL').AsString,
                    ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png', 'OK');

   FConsultaBD.CarregarSessoesAtivas(DBGrid_CarregarSession);

  end;
end;

procedure TViewMain.DBGrid_CarregarSessionDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BtnRect: TRect;
  TextoBotao: string;
  Grid: TDBGrid;
begin

  Grid := Sender as TDBGrid;

  // Verifica se é a coluna que representa o "botão"
  if Column.Title.Caption = 'KILL' then
  begin
    BtnRect := Rect;
    InflateRect(BtnRect, -6, -1); // pequenas margens internas

    // --- Fundo branco ---
    Grid.Canvas.Brush.Color := clWhite;
    Grid.Canvas.FillRect(Rect);

    // --- Moldura cinza do botão ---
    DrawEdge(Grid.Canvas.Handle, BtnRect, EDGE_RAISED, BF_RECT);

    // --- Texto vermelho ---
    Grid.Canvas.Font.Color := clRed;
    Grid.Canvas.Brush.Style := bsClear; // para não sobrepor o texto com cor de fundo

    TextoBotao := 'Remover';
    DrawText(Grid.Canvas.Handle, PChar(TextoBotao), Length(TextoBotao),
      BtnRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

    // Restaura o brush padrão
    Grid.Canvas.Brush.Style := bsSolid;
  end
  else
    // Desenho padrão das outras colunas
    Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
procedure TViewMain.DBGrid_CarregarUsuariosCellClick(Column: TColumn);
var
  returnUsuario: Boolean;

begin
  if Column.Title.Caption = 'DROP USER' then
  begin
   // Pega o nome do usuario do Banco de dados a ser deletado.
   //ShowMessage(DBGrid_CarregarUsuarios.DataSource.DataSet.FieldByName('USERNAME').AsString );

     returnUsuario := fnc_criar_menssagem(
                      'Administração Banco de Dados',
                     'O usuário ' + DBGrid_CarregarUsuarios.DataSource.DataSet.FieldByName('USERNAME').AsString + ' foi selecionado para ser Excluído.',
                      'DESEJA REALMENTE DELETAR ESTE USUÁRIO?' + sLineBreak +
                      'ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                      'ERRO');

      if not returnUsuario then Exit;

    try
      InicioTelaAguarde;
      try
        ExecutarOpcaoDeletarUser;

        // Se chegou aqui, não houve erro → mostra mensagem de sucesso
        fnc_criar_menssagem('Administração Banco de Dados',
                            'O usuário ' + DBGrid_CarregarUsuarios.DataSource.DataSet.FieldByName('USERNAME').AsString + ' foi excluído com sucesso!',
                            '',
                            ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png', 'OK');
      except
        on E: Exception do
        begin
          fnc_criar_menssagem('Administração Banco de Dados',
                              'O usuário ' + DBGrid_CarregarUsuarios.DataSource.DataSet.FieldByName('USERNAME').AsString + ' não foi excluído!',
                              'Não foi possível excluir o usuário selecionado, existem sessões ativas.',
                              ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_erro.png', 'OK');

          // Aqui você pode registrar o erro se quiser:
          // LogErro(E.Message);

          Exit; // Sai do procedimento para não seguir o fluxo
        end;
      end;
    finally
      FimTelaAguarde;
    end;

    // Exemplo 2: carregar tablespace
     FConsultaBD.CarregarTablespace(DBGrid_CarregarTablespace);

    // Exemplo 3: carregar usuários
     FConsultaBD.CarregarUsuarios(DBGrid_CarregarUsuarios);

  end;
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
        AlternaSplitViewClose(SplitViewMenu);
     end else

    begin
      // Passa o SQL da empresa Selecionada para o form responsavel pela edição da empresa
       TClasseAtualizaComponentesTela.AtualizarVariaveisGlobais(ViewMain.lbl_carregaEmpresa,
                                                                ViewMain.qryEmpresas);
     end;

end;

procedure TViewMain.AtualizarTelaEmpresas;
begin
  // Atualiza o DBGrid (qryEmpresas é o dataset)
  TClasseAtualizaComponentesTela.AtualizarDBGrid(ViewMain.qryEmpresas);

  // Atualiza variáveis globais
  TClasseAtualizaComponentesTela.AtualizarVariaveisGlobais(ViewMain.lbl_carregaEmpresa, ViewMain.qryEmpresas);
end;

procedure TViewMain.ExecutarScriptCriarUsuario;
var
  ScriptTxt: string;
  UserName: string;
  TmpLines: TStringList;
begin
  // Pega o nome informado pelo usuário
  UserName := Trim(edt_novoUsuario.Text);

  // Valida o nome antes de tudo
  if not ValidarCaracterString(UserName) then
  begin
    ShowMessage('Nome de usuário inválido. Use apenas letras, números e _ $ #, começando com letra.');
    Exit;
  end;

  // Padroniza (opcional)
  UserName := UpperCase(UserName);

  TmpLines := TStringList.Create;
  try
    try
      // Copia o script original do componente para uma string temporária
      TmpLines.Text := OraScriptCriarUsuario.SQL.Text;

      // Substitui todas as ocorrências de :vUsuario
      ScriptTxt := StringReplace(TmpLines.Text, ':vUsuario', UserName, [rfReplaceAll, rfIgnoreCase]);

      // Se seu script usa outras variáveis, substitua aqui também:
      // ScriptTxt := StringReplace(ScriptTxt, ':vTablespace', 'DADOS', [rfReplaceAll, rfIgnoreCase]);

      // Atribui de volta ao TOraScript e executa
      OraScriptCriarUsuario.SQL.Text := ScriptTxt;
      OraScriptCriarUsuario.Execute;
    except
      on E: Exception do
        ShowMessage('Erro ao executar script: ' + E.Message);
    end;
  finally
    TmpLines.Free;
  end;

  // Volta o texto original do Scritp para criar o usuario.
  OraScriptCriarUsuario.SQL.Text := OraScriptCriarUsuarioOriginal.SQL.Text;

end;

procedure TViewMain.AplicarPermissoesUsuario(const NomeUsuario: string);
var
  i: Integer;
  Autorizado: Boolean;
begin
  Autorizado := False;

  if Assigned(vGbl_FListaUsuarios) then
  begin
    for i := 0 to vGbl_FListaUsuarios.Count - 1 do
    begin
      if SameText(LowerCase(vGbl_FListaUsuarios[i]), LowerCase(Trim(NomeUsuario))) then
      begin
        Autorizado := True;
        Break;
      end;
    end;
  end;

  //  Guarda se o usuário atual é autorizado globalmente
  vGbl_UsuarioAutorizado := Autorizado;

  //  Mantém tudo habilitado, mas a verificação será feita no clique
  act_Empresas.Enabled := True;
  act_Movimentacao.Enabled := True;
  act_Configuracao.Enabled := True;
  btn_deleteTriggers.Enabled := True;
end;



procedure TViewMain.ValidarPermissaoAcao(const NomeAcao: string);
begin
  // 🔹 Se o usuário não for autorizado, exibe aviso e bloqueia a ação
  if not vGbl_UsuarioAutorizado then
  begin
    MessageDlg(
      '🚫 Acesso negado!' + sLineBreak +
      'Usuário "' + vGbl_UserLogin + '" não possui permissão para acessar "' + NomeAcao + '".' + sLineBreak +
      'Entre em contato com o administrador do sistema.',
      mtWarning, [mbOK], 0
    );
    Abort; // ⚠️ Impede a continuação da execução
  end;
end;



end.

