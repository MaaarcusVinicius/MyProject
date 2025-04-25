unit unit_cliente_cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  ACBrSocket, ACBrCEP, ACBrValidador, ACBrBase, ACBrEnterTab, unit_funcoes,
  ACBrAAC;

type
  Tform_cliente_cadastro = class(TForm)
    pnl_fundo: TPanel;
    lbl_contato: TLabel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    medt_contato: TMaskEdit;
    pnl_botoes: TPanel;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    pnl_nao: TPanel;
    btn_cancelar: TSpeedButton;
    edt_nomeCliente: TEdit;
    pnl_linhaTop: TPanel;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    pnl_enderecoSuperior: TPanel;
    lbl_dadosCadastrais: TLabel;
    medt_cpf_cnpj: TMaskEdit;
    Tipo_Pessoa: TRadioGroup;
    lbl_cnpj_cpf: TLabel;
    edt_endereco: TEdit;
    edt_bairro: TEdit;
    lbl_endereco: TLabel;
    lbl_dt_nascimento: TLabel;
    medt_dt_nascimento: TMaskEdit;
    medt_rg: TMaskEdit;
    lbl_rg: TLabel;
    edt_complemento: TEdit;
    lbl_complemento: TLabel;
    edt_numero: TEdit;
    lbl_numero: TLabel;
    lbl_bairro: TLabel;
    edt_cidade: TEdit;
    lbl_cidade: TLabel;
    edt_estado: TEdit;
    lbl_estado: TLabel;
    medt_fixo: TMaskEdit;
    lbl_fixo: TLabel;
    edt_observacao: TEdit;
    lbl_observacoes: TLabel;
    Acbrntrtb: TACBrEnterTab;
    ACBrValidador: TACBrValidador;
    ACBrCEP: TACBrCEP;
    lbl_Cep: TLabel;
    medt_cep: TMaskEdit;
    btn_encerrar: TSpeedButton;
    procedure btn_cancelarClick(Sender: TObject);
    procedure Tipo_PessoaClick(Sender: TObject);
    procedure medt_cpf_cnpjExit(Sender: TObject);
    procedure medt_dt_nascimentoExit(Sender: TObject);
    procedure medt_cepExit(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
    procedure btn_encerrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cliente_cadastro: Tform_cliente_cadastro;

implementation

uses
  unit_cliente_consulta;

{$R *.dfm}

procedure Tform_cliente_cadastro.btn_cancelarClick(Sender: TObject);
begin
 Close;
end;

procedure Tform_cliente_cadastro.medt_cpf_cnpjExit(Sender: TObject);
var
  CNPJ_CPF_LIMPO : string;
begin
  CNPJ_CPF_LIMPO :=  fnc_sonumeros(medt_cpf_cnpj.Text) ;

  if (  (CNPJ_CPF_LIMPO) <> '' ) then
     begin
       if Tipo_Pessoa.ItemIndex = 0 then
       begin
          ACBrValidador.TipoDocto := docCNPJ;
          ACBrValidador.Documento := CNPJ_CPF_LIMPO;

          if not ACBrValidador.Validar then
          begin
                fnc_criar_menssagem('INSERIR DADOS',
                                    'ERRO AO GRAVAR CNPJ!',
                                    'CNPJ FORA DO PADRÃO ESPERADO',
                                    ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                                    'OK')  ;
          end;

       end else  if Tipo_Pessoa.ItemIndex = 1 then
       begin
          ACBrValidador.TipoDocto := docCPF;
          ACBrValidador.Documento := CNPJ_CPF_LIMPO;

          if not ACBrValidador.Validar then
          begin
                fnc_criar_menssagem('INSERIR DADOS',
                                    'ERRO AO GRAVAR CPF!',
                                    'CPF FORA DO PADRÃO ESPERADO',
                                    ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                                    'OK')  ;
          end;
       end;
     end;
end;

procedure Tform_cliente_cadastro.btn_confirmaClick(Sender: TObject);
  var
    sTipoOperacao,
    sErro : string;

begin

   sErro := '';

   prcValidarCamposObrigatorios( form_cliente_cadastro );

   with form_cliente_consulta.Clientes do

   begin

     ds_cliente     := edt_nomeCliente.Text;
     dt_nascimento  := StrToDate(medt_dt_nascimento.Text);
     nr_cpf         := medt_cpf_cnpj.Text;
     nr_rg          := medt_rg.Text;
     nr_cep         := medt_cep.Text;
     ds_endereco    := edt_endereco.Text;
     nr_numero      := edt_numero.Text;
     ds_complemento := edt_complemento.Text;
     ds_bairro      := edt_bairro.Text;
     ds_cidade      := edt_cidade.Text;
     ds_uf          := edt_estado.Text;
     nr_telefone    := medt_contato.Text;
     nr_telefone2   := medt_fixo.Text;
     ds_obs         := edt_observacao.Text;

   if id_cliente > 0 then
     sTipoOperacao := 'ALTERAR'
   else
     sTipoOperacao := 'INSERIR';

   if fnc_inserir_alterar(sTipoOperacao, sErro) then
     begin
        fnc_criar_menssagem('INSERIR DADOS',
                            'CADASTRAR/ALTERAR CLIENTE',
                            'CADASTRO REALIZADO COM SUCESSO!',
                            ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                            'OK');
        Close;
     end else
     begin
        fnc_criar_menssagem('INSERIR DADOS',
                            'CADASTRAR/ALTERAR CLIENTE',
                            'OCORREU UM ERRO AO CADASTRAR O CLIENTE' +
                            sErro,
                            ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                            'OK')  ;

        edt_nomeCliente.SetFocus;
     end;

   end;

end;

procedure Tform_cliente_cadastro.btn_encerrarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_cliente_cadastro.medt_cepExit(Sender: TObject);
begin
  if ( fnc_sonumeros(medt_cep.Text)  <> '' )  then
    begin

      if ACBrCEP.BuscarPorCEP(medt_cep.Text) > 0 then
      begin
        edt_endereco.Text:= ACBrCEP.Enderecos[0].Logradouro;
        edt_bairro.Text  := ACBrCEP.Enderecos[0].Bairro;
        edt_cidade.Text  := ACBrCEP.Enderecos[0].Municipio;
        edt_estado.Text  := ACBrCEP.Enderecos[0].UF;

        edt_complemento.SetFocus;

      end else

      begin
        fnc_criar_menssagem('INSERIR DADOS',
                            'ERRO AO GRAVAR CEP',
                            'CEP FORA DO PADRÃO ESPERADO',
                            ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                            'OK')  ;

      medt_cep.SetFocus;

      end;
    end;
end;



procedure Tform_cliente_cadastro.medt_dt_nascimentoExit(Sender: TObject);
begin
  if ( fnc_sonumeros(medt_dt_nascimento.Text)  <> '' ) and
     ( medt_dt_nascimento.Text <> '__/__/____' ) then
    begin
      try
      medt_dt_nascimento.Text := FormatDateTime('DD/MM/YYYY', StrToDate(medt_dt_nascimento.Text))  ;
      except

        fnc_criar_menssagem('INSERIR DADOS',
                            'ERRO AO GRAVAR DATA NASCIMENTO',
                            'DATA FORA DO PADRÃO ESPERADO',
                            ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                            'OK')  ;

      medt_dt_nascimento.SetFocus;

      end;
    end;

end;

procedure Tform_cliente_cadastro.Tipo_PessoaClick(Sender: TObject);

begin
   medt_cpf_cnpj.text := '';
  case Tipo_Pessoa.ItemIndex of
    0 : medt_cpf_cnpj.EditMask := '!99.999.999/9999-99;1;_';
    1 : medt_cpf_cnpj.EditMask := '!999.999.999/99;1;_';
    2 : medt_cpf_cnpj.EditMask := '';
  end;

  if medt_cpf_cnpj.text = '' then
    medt_cpf_cnpj.SetFocus;
end;

end.
