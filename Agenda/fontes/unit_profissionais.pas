unit unit_profissionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tform_profissionais = class(TForm)
    pnl_fundo: TPanel;
    lbl_nomeProfissional: TLabel;
    lbl_contato: TLabel;
    medt_contato: TMaskEdit;
    pnl_botoes: TPanel;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    pnl_nao: TPanel;
    btn_cancelar: TSpeedButton;
    edt_especialidade: TEdit;
    lbl_especialidade: TLabel;
    edt_nomeProfissional: TEdit;
    lbl_obsProfissional: TLabel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    pnl_linhaTop: TPanel;
    dbgrd_profissionais: TDBGrid;
    ds_profissionais: TDataSource;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    lbl_aviso: TLabel;
    procedure btn_cancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgrd_profissionaisKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_confirmaClick(Sender: TObject);
    procedure dbgrd_profissionaisDblClick(Sender: TObject);
  private
    { Private declarations }
  public                                        
    { Public declarations }
  end;

var
  form_profissionais: Tform_profissionais;

implementation

uses
  unit_dados, classe.profissionais, unit_funcoes;

{$R *.dfm}

procedure Tform_profissionais.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_profissionais.btn_confirmaClick(Sender: TObject);
 var
 Operacao, Erro : string;
begin
  prcValidarCamposObrigatorios ( form_profissionais )  ;

      form_dados.GetProfissional().ds_Profissional := AnsiUpperCase(edt_nomeProfissional.Text);
      form_dados.GetProfissional().ds_especialidade := AnsiUpperCase(edt_especialidade.Text);
      form_dados.GetProfissional().nr_contato := fnc_sonumeros(medt_contato.Text);

      if form_dados.GetProfissional().Id_Profissional > 0 then
        Operacao := 'ALTERAR'
      else
        Operacao := 'INSERIR' ;

      if form_dados.GetProfissional().fnc_inserir_alterar(Operacao, Erro) then
      begin

        fnc_criar_menssagem('CONFIRMANDO DADOS',
                            'CADASTRAR/ALTERAR PROFISSIONAL',
                            'Cadastro Realizado com Sucesso!'+
                            '',
                            ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                            'OK')  ;
        Close;

      end
      else
       begin

        fnc_criar_menssagem('INSERIR DADOS',
                            'FALHA AO CADASTRAR/ALTERAR NOVO PROFISSIONAL',
                            'Não foi possível cadastrar/alterar o profissional, possível causa:' +
                            Erro,
                            ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                            'OK')  ;

        edt_nomeProfissional.SetFocus;

       end;

end;

procedure Tform_profissionais.dbgrd_profissionaisDblClick(Sender: TObject);
begin
   if ( NOT ( dbgrd_profissionais.DataSource.DataSet.IsEmpty) ) then
   begin
      edt_nomeProfissional.Text := dbgrd_profissionais.DataSource.DataSet.FieldByName('ds_profissional').AsString;
      edt_especialidade.Text    := dbgrd_profissionais.DataSource.DataSet.FieldByName('ds_especialidade').AsString;
      medt_contato.Text         := dbgrd_profissionais.DataSource.DataSet.FieldByName('nr_contato').AsString;


      form_dados.GetProfissional().Id_Profissional := dbgrd_profissionais.DataSource.DataSet.FieldByName('id_profissional').AsInteger;

   end;
end;

procedure Tform_profissionais.dbgrd_profissionaisKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  //if dbgrd_profissionais.DataSource.DataSet.IsEmpty then
  //Exit;

  if ( NOT ( dbgrd_profissionais.DataSource.DataSet.IsEmpty) ) and ( Key = VK_DELETE ) then

      form_dados.GetProfissional().prc_deleta(dbgrd_profissionais.DataSource.DataSet.FieldByName('id_profissional').AsInteger);
end;

procedure Tform_profissionais.FormShow(Sender: TObject);
begin
   ds_profissionais.DataSet := form_dados.GetProfissional().fnc_consulta('');
end;

end.
