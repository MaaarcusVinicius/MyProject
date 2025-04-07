unit unit_agendamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.WinXCalendars,  unit_funcoes, unit_principal,  unit_dados, classe.profissionais,
  Data.DB, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, classe.agendamento;

type
  Tform_agendamento = class(TForm)
    pnl_fundo: TPanel;
    lbl_selecioneProfissional: TLabel;
    btn_incluirProfissional: TSpeedButton;
    btn_diaHorario: TSpeedButton;
    lbl_diaHorario: TLabel;
    clndrpckr_agendamento: TCalendarPicker;
    medt_agendamentoData: TMaskEdit;
    medt_horaAgendamento: TMaskEdit;
    lbl_selecioneCliente: TLabel;
    edt_pesquisaCliente: TEdit;
    btn_selecionarCliente: TSpeedButton;
    medt_telefone: TMaskEdit;
    medt_celular: TMaskEdit;
    lbl_telefone: TLabel;
    lbl_celular: TLabel;
    edt_observacoes: TEdit;
    lbl_observacoes: TLabel;
    pnl_botoes: TPanel;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    pnl_nao: TPanel;
    btn_cancelar: TSpeedButton;
    dataSource_profissionais: TDataSource;
    dblkcbb_selecionePorfissional: TDBLookupComboBox;
    procedure clndrpckr_agendamentoChange(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_incluirProfissionalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_selecionarClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_diaHorarioClick(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
  private
    { Private declarations }
    Profissional : TProfissionais;

  public
    { Public declarations }
    Agendamento :TAgendamento;

  end;

var
  form_agendamento: Tform_agendamento;


implementation

uses
  unit_profissionais, unit_cliente_consulta, unit_agendamento_consulta;


{$R *.dfm}

procedure Tform_agendamento.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_agendamento.btn_confirmaClick(Sender: TObject);
begin
   prcValidarCamposObrigatorios( form_agendamento );
end;

procedure Tform_agendamento.btn_diaHorarioClick(Sender: TObject);
begin
  try

    form_agendamento_consulta := Tform_agendamento_consulta.Create( Self );

    if dblkcbb_selecionePorfissional.KeyValue <> null then
       form_agendamento_consulta.dblkcbb_selecionePorfissional.KeyValue := dblkcbb_selecionePorfissional.KeyValue;

    form_agendamento_consulta.ShowModal;

  finally

    form_agendamento_consulta.Free;

  end;

end;

procedure Tform_agendamento.btn_incluirProfissionalClick(Sender: TObject);
begin
  try

    form_profissionais := Tform_profissionais.Create( Self );
    form_profissionais.ShowModal;

  finally

    form_profissionais.Free;

  end;
end;

procedure Tform_agendamento.btn_selecionarClienteClick(Sender: TObject);
begin

  try
    form_cliente_consulta :=  Tform_cliente_consulta.Create(Self);
    form_cliente_consulta.ShowModal;
  finally
    form_cliente_consulta.Destroy;
  end;

end;

procedure Tform_agendamento.clndrpckr_agendamentoChange(Sender: TObject);
begin
    medt_agendamentoData.Text := DateToStr(clndrpckr_agendamento.Date);
end;

procedure Tform_agendamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

   form_Principal.pnl_lateralLefth.Enabled  := True;
   Agendamento.Destroy;

  // form_dados.GetProfissional().Destroy;
   Action := caFree;

end;

procedure Tform_agendamento.FormCreate(Sender: TObject);
begin

  Agendamento := TAgendamento.Create ( form_dados.FDConnection );

end;

procedure Tform_agendamento.FormShow(Sender: TObject);
begin
  dataSource_profissionais.DataSet := form_dados.GetProfissional().fnc_consulta('');
end;
end.
