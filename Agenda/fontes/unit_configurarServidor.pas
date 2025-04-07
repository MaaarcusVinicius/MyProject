unit unit_configurarServidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Buttons, classe.conexao, unit_funcoes, unit_dados;

type
  Tform_configurarServidor = class(TForm)
    shp_fundo: TShape;
    pnl_configServidor: TPanel;
    pnl_configCabecario: TPanel;
    pnl_configConsulta: TPanel;
    pnl_fundo: TPanel;
    img_config: TImage;
    lbl_configServidorCabecario: TLabel;
    lbl_configInstrucao: TLabel;
    lbl_configServidor: TLabel;
    lbl_configConsulta: TLabel;
    pnl_linhaCofigServidorConsulta: TPanel;
    pnl_linhaCofigServidor: TPanel;
    edt_configCaminhoServidor: TEdit;
    edt_configBaseServidor: TEdit;
    edt_configLoginServidor: TEdit;
    edt_configPortaServidor: TEdit;
    edt_configSenhaServidor: TEdit;
    lbl_configCaminhoServidor: TLabel;
    lbl_configBaseServidor: TLabel;
    lbl_configLoginServidor: TLabel;
    lbl_configPortaServidor: TLabel;
    lbl_configSenhaServidor: TLabel;
    edt_configBaseServidorAtual: TEdit;
    lbl_configBaseServidorAtual: TLabel;
    edt_configCaminhoServidorAtual: TEdit;
    lbl_configCaminhoServidorAtual: TLabel;
    edt_configLoginServidorAtual: TEdit;
    lbl_configLoginServidorAtual: TLabel;
    edt_configSenhaServidorAtual: TEdit;
    lbl_configSenhaServidorAtual: TLabel;
    edt_configPortaServidorAtual: TEdit;
    lbl_configPortaServidorAtual: TLabel;
    pnl_configServidroSair: TPanel;
    btn_configServidorSair: TSpeedButton;
    pnl_botoes: TPanel;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    pnl_nao: TPanel;
    btn_cancelar: TSpeedButton;
    procedure btn_configServidorSairClick(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_configurarServidor: Tform_configurarServidor;

implementation

uses
  unit_principal;



{$R *.dfm}

procedure Tform_configurarServidor.btn_cancelarClick(Sender: TObject);
begin
   Close;
end;

procedure Tform_configurarServidor.btn_configServidorSairClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure Tform_configurarServidor.btn_confirmaClick(Sender: TObject);
begin

    prcValidarCamposObrigatorios (form_configurarServidor)  ;

    form_dados.Conexao.Servidor := edt_configCaminhoServidor.Text;
    form_dados.Conexao.Base     := edt_configBaseServidor.Text;
    form_dados.Conexao.Login    := edt_configLoginServidor.Text;
    form_dados.Conexao.Senha    := edt_configSenhaServidor.Text;
    form_dados.Conexao.Porta    := edt_configPortaServidor.Text;

    form_dados.Conexao.prcGravarArquivoIni;

    if form_dados.Conexao.fnc_conectar_banco_dados then
    begin

      fnc_criar_menssagem('CONEXÃO AO BANCO DE DADOS',
                          'SUCESSO AO CONECTAR AO BANCO DE DADOS',
                          'A conexão foi estabelecida com sucesso!'+
                          ' O Sistema precisar ser reiniciado!',
                          ExtractFilePath(Application.ExeName ) + '\icones\database_connection.png',
                          'OK')  ;
      Application.Terminate;

    end
    else
     begin

      fnc_criar_menssagem('CONEXÃO AO BANCO DE DADOS',
                          'PROBLEMAS AO CONECTAR AO BANCO DE DADOS',
                          'Não foi possível conectar ao banco de dados, possível causa:' +
                          form_dados.Conexao.MsgErro,
                          ExtractFilePath(Application.ExeName ) + '\icones\database_error.png',
                          'OK')  ;

      edt_configCaminhoServidor.SetFocus;

     end;

end;

procedure Tform_configurarServidor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Close;
end;

procedure Tform_configurarServidor.FormShow(Sender: TObject);
begin
   if form_dados.Conexao.fnc_ler_ArquivoIni  then
    begin

      edt_configCaminhoServidorAtual.Text := form_dados.Conexao.Servidor;
      edt_configBaseServidorAtual.Text    := form_dados.Conexao.Base;
      edt_configLoginServidorAtual.Text   := form_dados.Conexao.Login;
      edt_configSenhaServidorAtual.Text   := form_dados.Conexao.Senha;
      edt_configPortaServidorAtual.Text   := form_dados.Conexao.Porta;

    end;
end;
end.
