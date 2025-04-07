unit unit_cliente_consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  unit_cliente_cadastro, classe.clientes, unit_agendamento;

type
  Tform_cliente_consulta = class(TForm)
    pnl_fundo: TPanel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    lbl_aviso: TLabel;
    pnl_clientebotoes: TPanel;
    pnl_seleciona: TPanel;
    btn_seleciona: TSpeedButton;
    pnl_cancelar: TPanel;
    btn_cancelar: TSpeedButton;
    edt_nomeCliente: TEdit;
    pnl_linhaTop: TPanel;
    dbgrd_consultaClientes: TDBGrid;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    pnl_novocliente: TPanel;
    btn_1: TSpeedButton;
    pnl_11: TPanel;
    ds_consultaClientes: TDataSource;
    lbl_aviso2: TLabel;
    lbl_pesParte1: TLabel;
    lbl_pesParte2: TLabel;
    lbl_pesParte3: TLabel;
    lbl_pesParte4: TLabel;
    lbl_pesParte5: TLabel;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_nomeClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrd_consultaClientesDblClick(Sender: TObject);
    procedure dbgrd_consultaClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_selecionaClick(Sender: TObject);
    procedure dbgrd_consultaClientesEnter(Sender: TObject);
  private
    { Private declarations }
  public

    Clientes : TClientes;
    { Public declarations }

  end;

var
  form_cliente_consulta: Tform_cliente_consulta;

implementation

uses
  unit_dados;



{$R *.dfm}

procedure Tform_cliente_consulta.btn_1Click(Sender: TObject);
begin
  try
    form_cliente_cadastro :=  Tform_cliente_cadastro.Create(Self);
    ds_consultaClientes.DataSet := nil;
    form_cliente_cadastro.ShowModal;

  finally
     form_cliente_cadastro.Destroy;
  end;

end;

procedure Tform_cliente_consulta.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_cliente_consulta.btn_selecionaClick(Sender: TObject);
begin

  with dbgrd_consultaClientes.DataSource.DataSet  do
  begin

    if ( not ( IsEmpty ) ) then
    begin

      form_agendamento.Agendamento.cli_id_cliente := FieldByName('id_cliente').AsInteger;
      form_agendamento.edt_pesquisaCliente.Text   := FieldByName('ds_cliente').AsString;
      form_agendamento.medt_telefone.Text         := FieldByName('nr_telefone').AsString;
      form_agendamento.medt_celular.Text          := FieldByName('nr_telefone2').AsString;

      form_cliente_consulta.Close;

    end;
  end;

  form_agendamento.dblkcbb_selecionePorfissional.KeyValue := form_agendamento.dblkcbb_selecionePorfissional.KeyValue;

end;

procedure Tform_cliente_consulta.dbgrd_consultaClientesDblClick(
  Sender: TObject);
begin

 if ( not ( dbgrd_consultaClientes.DataSource.DataSet.IsEmpty ) ) then
   begin

     Clientes.id_cliente := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('id_cliente').AsInteger;

    try
     form_cliente_cadastro := Tform_cliente_cadastro.Create(Self);

     if Length( dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_cpf').AsString) >  14 then

       form_cliente_cadastro.Tipo_Pessoa.ItemIndex := 0
       else
       form_cliente_cadastro.Tipo_Pessoa.ItemIndex := 1;

       form_cliente_cadastro.edt_nomeCliente.Text    := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_cliente').AsString;
       form_cliente_cadastro.medt_dt_nascimento.Text := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('dt_nascimento').AsString;
       form_cliente_cadastro.medt_cpf_cnpj.Text      := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_cpf').AsString;
       form_cliente_cadastro.medt_rg.Text            := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_rg').AsString;
       form_cliente_cadastro.medt_cep.Text           := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_cep').AsString;
       form_cliente_cadastro.edt_endereco.Text       := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_endereco').AsString;
       form_cliente_cadastro.edt_numero.Text         := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_numero').AsString;
       form_cliente_cadastro.edt_complemento.Text    := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_complemento').AsString;
       form_cliente_cadastro.edt_bairro.Text         := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_bairro').AsString;
       form_cliente_cadastro.edt_cidade.Text         := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_cidade').AsString;
       form_cliente_cadastro.edt_estado.Text         := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_uf').AsString;
       form_cliente_cadastro.medt_contato.Text       := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_telefone').AsString;
       form_cliente_cadastro.medt_fixo.Text          := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('nr_telefone2').AsString;
       form_cliente_cadastro.edt_observacao.Text     := dbgrd_consultaClientes.DataSource.DataSet.FieldByName('ds_obs').AsString;

       ds_consultaClientes.DataSet := nil;

       form_cliente_cadastro.ShowModal;

    finally

     form_cliente_cadastro.Destroy;
    end;
   end;

//     dbgrd_consultaClientes.SetFocus;

end;

procedure Tform_cliente_consulta.dbgrd_consultaClientesEnter(Sender: TObject);
begin

   if dbgrd_consultaClientes.DataSource.DataSet.IsEmpty then
        exit;
   {
     Existe um erro ao acessar o dbgrid, neste momento ele ainda não existe
     com isto há um erro de acessviolation, tem que corrigir.

     Ex: Utilizar o --> Assigned <-- para verificar se no momento ele esta
         Criado, caso esteja da um Exit, caso não esteja da um Create   na
         consulta.
   }
   if  edt_nomeCliente.text = '' then
     begin

        ShowMessage('Será necessário preencher pelo menos uma letra.');
         edt_nomeCliente.SetFocus;
         exit;
     end else
      begin

        ShowMessage('Já esta preenchido.');

      end;

     //dbgrd_consultaClientesDblClick()



end;

procedure Tform_cliente_consulta.dbgrd_consultaClientesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

begin

  if ( Key = VK_DELETE ) and ( not ( dbgrd_consultaClientes.DataSource.DataSet.IsEmpty) ) then
  begin
    clientes.prc_deleta( dbgrd_consultaClientes.DataSource.DataSet.FieldByName('id_cliente').AsInteger );
    Clientes.fnc_cosnulta( edt_nomeCliente.text );
  end;

  btn_selecionaClick(Sender);

end;

procedure Tform_cliente_consulta.edt_nomeClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ds_consultaClientes.DataSet := clientes.fnc_cosnulta( edt_nomeCliente.Text) ;
  end;

end;

procedure Tform_cliente_consulta.FormCreate(Sender: TObject);
begin
  Clientes := TClientes.Create( form_dados.FDConnection );
end;

end.
