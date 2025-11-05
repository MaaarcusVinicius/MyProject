unit uViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,  Classe.ConsultaBD,
  TelaAguarde, System.RegularExpressions, EditNumber, ACBrBase, ACBrEnterTab;

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
    TrocaEmpresa: TGroupBox;
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
    pnl_criarUsuario: TPanel;
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
    edt_E_MAIL: TEdit;
    edt_FONE_WHATSAPP: TMaskEdit;
    Label81: TLabel;
    Label14: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    pnl_novosDadosEmpresa: TPanel;
    grpAcoes: TGroupBox;
    pnl_trocandoEmpresa: TPanel;
    lbl_trocaEmpresa: TLabel;
    pnl_trocandoEmpresas: TPanel;
    Panel1: TPanel;
    btn_trocandoEmpresas: TSpeedButton;
    medt_cpf_cnpj: TMaskEdit;
    chk_saveScritpTrocando: TCheckBox;
    mmo_infTrocaEmpresa: TMemo;
    lbl_cidadeNome: TLabel;
    edt_CIDADE_ID: TEdit;
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
    FConsultaBD : TClasseConsultaBD;
    vGbl_Empresa_id : string;
    vGbl_RazaoSocial : string;

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
  Classe.ConsultaTrocaEmpresa;

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

function TViewMain.ValidaAtivacaoProcedimentos: Boolean;
//var
//  validaConexao : Boolean;
//  valida_vGbl_Empresa_id: Boolean;
begin
//  validaConexao := True; // por padrão, deixa continuar
//  valida_vGbl_Empresa_id := True; // por padrão, deixa continua
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
  Consulta: TConsultaTrocaEmpresa;
begin
  Consulta := TConsultaTrocaEmpresa.Create;

  // Acessa o menu Inicial
  PageControl.ActivePageIndex := 1;
  AlternaSplitViewClose(SplitViewMenu);


  if ( ValidaAtivacaoProcedimentos() ) then
    begin
      try
        Consulta.CarregarTrocaEmpresa(
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

procedure TViewMain.action_deletandoEmpresaExecute(Sender: TObject);
begin
  // Deleta Empresa
  PageControl.ActivePageIndex := 3;
  AlternaSplitViewClose(SplitViewMenu);
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

procedure TViewMain.act_HomeExecute(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0 ;
  AlternaSplitViewClose(SplitViewMenu);
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
        saveScriptOracle.SaveToFile('C:\CleanBaseLogs\sqlExport_DeleteEmpresa.txt', TEncoding.UTF8);
      finally
        saveScriptOracle.Free;
      end;
    end;

    // Atualiza Variaveis de ambiente e nome da empresa
       AtualizarTelaEmpresas();
  finally
    Scripts.Free;
    ScriptGen.Free;
    Progress.Free;
  end;
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
        saveScriptOracle.SaveToFile('C:\CleanBaseLogs\sqlExport_DesativarTriggers.txt', TEncoding.UTF8);
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
    // Exemplo 0: carregar versão do Oracle
    FConsultaBD.CarregarVersaoOracle(lbl_versaoOracle);

    // Exemplo 1: carregar sessões Ativas
    FConsultaBD.CarregarSessoesAtivas(DBGrid_CarregarSession);

    // Exemplo 2: carregar tablespace
     FConsultaBD.CarregarTablespace(DBGrid_CarregarTablespace);

    // Exemplo 3: carregar usuários
     FConsultaBD.CarregarUsuarios(DBGrid_CarregarUsuarios);

    // Exemplo 4: carregar TableSpace Diretorios
     FConsultaBD.CarregarBancoTablespaceDiretorio(DBGrid_CarregarTablespaceDiretorio);

    // Exemplo 5: atualizar status
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


procedure TViewMain.btn_expBkpClick(Sender: TObject);
begin
  ShowMessage('Em construção ...');
end;

procedure TViewMain.btn_importBkpClick(Sender: TObject);
begin
  ShowMessage('Em construção ...');
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

      // 5 - Mensagem final de sucesso
      fnc_criar_menssagem('ALTERAÇÃO DE EMPRESA',
                          'A ALTERAÇÃO DA EMPRESA FOI UM SUCESSO !!!',
                          'Você alterou o CNPJ da empresa: ' + vEmpresa_id + ' - ' + vRazaoSocial +
                          ', para o novo CNPJ: ' + newEmpresa_id,
                          ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                          'OK');

      // 6 - Salvar script se marcado
      if chk_saveScritpTrocando.Checked then
      begin
        saveScriptOracle := TStringList.Create;
        try
          saveScriptOracle.Text := Scripts.Text;
          saveScriptOracle.SaveToFile('C:\CleanBaseLogs\sqlExport_TrocaEmpresa.txt', TEncoding.UTF8);
        finally
          saveScriptOracle.Free;
        end;
      end;

     // Atualizar Dados da Tela
     AtualizarTelaEmpresas();

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
  fnc_criar_menssagem('SIAC CLEAN BASE',
                      'Versão do Sistema  -  1.1.5.3 - R07  -  @2025',
                      'Todos direitos reservados à: www.siacsistemas.com.br',
                      ExtractFilePath(Application.ExeName) + 'Arquivos\icones\icon_aviso.png',
                      'OK');
end;

procedure TViewMain.btn_bindsOracleClick(Sender: TObject);
begin
  try
    FConsultaBD.ExecutarBindsOracle(nil, 'Parâmetros de Configuração do Oracle');
  except
    on E: Exception do
      ShowMessage('Erro ao executar consulta de parâmetros Oracle: ' + E.Message);
  end;
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
   // Exit(False);
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

//   InicioTelaAguarde();
//   ExecutarOpcaoDeletarUser();
//   FimTelaAguarde();

//    fnc_criar_menssagem('Administração Banco de Dados',
//                   'O usuário ' + DBGrid_CarregarUsuarios.DataSource.DataSet.FieldByName('USERNAME').AsString + ' foi excluído com sucesso!',
//                   '',
//                    ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png', 'OK');

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



end.

