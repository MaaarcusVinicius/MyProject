unit unit_usuario_cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.DBCtrls, unit_funcoes, unit_dados;

type
  Tform_usuario_cadastro = class(TForm)
    pnl_fundo: TPanel;
    lbl_nomeUsuario: TLabel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    edt_nomeUsuario: TEdit;
    pnl_linhaTop: TPanel;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    edt_senha: TEdit;
    lbl_1: TLabel;
    edt_senhaConfirma: TEdit;
    lbl_senha2: TLabel;
    btn_consultaProfissionais: TSpeedButton;
    lbl_grupoUsuario: TLabel;
    edt_nomeLogin: TEdit;
    lbl_nomeLogin: TLabel;
    dbl_cmb_grupoUsuario: TDBLookupComboBox;
    pnl_fechar: TPanel;
    btn_fechar: TSpeedButton;
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_usuario_cadastro: Tform_usuario_cadastro;

implementation

{$R *.dfm}

procedure Tform_usuario_cadastro.btn_fecharClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_usuario_cadastro.btn_confirmaClick(Sender: TObject);
var
  sErro : string;
begin

   prcValidarCamposObrigatorios( form_usuario_cadastro );

   if edt_senha.text <> edt_senhaConfirma.text then
   begin
     fnc_criar_menssagem('HOUVE PROBLEMAS AO CADASTRAR O USUÁRIO',
                         'SENHA NÃO CONFEREM',
                         'VERIFIQUE O PREENCHIMENTO DE SUA SENHA',
                         ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                        'OK')  ;
     edt_senha.SetFocus;
     abort;
   end;

   with form_dados.Usuarios do
   begin
     ds_usuario   := edt_nomeUsuario.text;
     ds_login     := edt_nomeLogin.text;
     ds_senha     := edt_senha.text;
//     cd_permissao := dbl_cmb_grupoUsuario.KeyValue;

     if fnc_operacoes_crud('INSERIR', '', sErro ) then
     begin
       fnc_criar_menssagem('CADASTRA DE USUÁRIO',
                           'INSERIR E ALTERAR USUÁRIOS',
                           'DADOS CADASTRADOS/ALTERADOS COM SUCESSO',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoConfirma.png',
                           'OK');
       Close;

     end else
     begin
       fnc_criar_menssagem('CADASTRA DE USUÁRIO',
                           'INSERIR E ALTERAR USUÁRIOS',
                           sErro,
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                           'AVISO');
        edt_nomeLogin.SetFocus;
     end;

   end;

end;

end.
