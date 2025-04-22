unit unit_agenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.WinXCalendars, Data.DB, Vcl.Grids, Vcl.DBGrids, classe.agendamento, unit_dados;

type
  Tform_agenda = class(TForm)
    pnl_superior: TPanel;
    pnl_linha: TPanel;
    pnl_central: TPanel;
    btn_encerrar: TSpeedButton;
    dblkcbb_selecionePorfissional: TDBLookupComboBox;
    lbl_selecioneProfissional: TLabel;
    dbgrd_profissionais: TDBGrid;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    ds_consulta: TDataSource;
    clndrpckr_calendario: TCalendarPicker;
    lbl_data: TLabel;
    edt_consultaCliente: TEdit;
    lbl_cliente: TLabel;
    pnl_novoAgendamento: TPanel;
    btn_novoAgendamento: TSpeedButton;
    btn_diaHorario: TSpeedButton;
    btn_consultaProfissionais: TSpeedButton;
    procedure btn_encerrarClick(Sender: TObject);
    procedure btn_novoAgendamentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Agendamento :TAgendamento;
  end;

var
  form_agenda: Tform_agenda;

implementation

uses
  unit_agendamento, unit_funcoes;

{$R *.dfm}

procedure Tform_agenda.btn_encerrarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_agenda.btn_novoAgendamentoClick(Sender: TObject);
begin
  try
    form_agendamento          := Tform_agendamento.Create( Self );
    form_agendamento.ShowModal;
  finally
    form_agendamento.Destroy;
  end;

end;

procedure Tform_agenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Agendamento.Destroy;
end;

procedure Tform_agenda.FormCreate(Sender: TObject);
begin
  Agendamento := TAgendamento.Create ( form_dados.FDConnection );
end;

end.
