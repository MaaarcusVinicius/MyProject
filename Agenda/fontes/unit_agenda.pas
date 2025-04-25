unit unit_agenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.WinXCalendars, Data.DB, Vcl.Grids, Vcl.DBGrids, classe.agendamento, unit_dados;

type
  Tform_agenda = class(TForm)
    pnl_central: TPanel;
    dbgrd_consulta_agenda: TDBGrid;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    clndrpckr_calendario: TCalendarPicker;
    btn_consultaCliente: TSpeedButton;
    btn_consultaProfissionais: TSpeedButton;
    dblkcbb_consultaPorfissional: TDBLookupComboBox;
    lbl_selecioneProfissional: TLabel;
    lbl_data: TLabel;
    lbl_cliente: TLabel;
    edt_consultaCliente: TEdit;
    pnl_novoAgendamento: TPanel;
    btn_novoAgendamento: TSpeedButton;
    btn_encerrar: TSpeedButton;
    ds_consulta_agenda: TDataSource;
    dataSource_profissionais: TDataSource;
    procedure btn_encerrarClick(Sender: TObject);
    procedure btn_novoAgendamentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_consultaProfissionaisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_consultaClienteClick(Sender: TObject);
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

procedure Tform_agenda.btn_consultaProfissionaisClick(Sender: TObject);
begin
 dbgrd_consulta_agenda.Canvas.CleanupInstance;

   if clndrpckr_calendario.IsEmpty then
     begin
       fnc_criar_menssagem('VALIDADAR DADOS',
                           'Dados Obrigatórios não Preenchidos',
                           'DATA AGENDAMENTO NÃO SELECIONADO!',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                           'OK')  ;

       clndrpckr_calendario.SetFocus;
       Abort;
     end;

     if dblkcbb_consultaPorfissional.KeyValue = null then
     begin
       fnc_criar_menssagem('VALIDADAR DADOS',
                           'Dados Obrigatórios não Preenchidos',
                           'PROFISSIONAL NÃO SELECIONADO!',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                           'OK')  ;

       dblkcbb_consultaPorfissional.SetFocus;
       Abort;
     end;

    ds_consulta_agenda.DataSet := Agendamento.fnc_consulta(dblkcbb_consultaPorfissional.KeyValue,
                                                           clndrpckr_calendario.Date );

end;

procedure Tform_agenda.btn_consultaClienteClick(Sender: TObject);
begin
     if edt_consultaCliente.text = '' then
     begin
       fnc_criar_menssagem('VALIDADAR DADOS',
                           'Dados Obrigatórios não Preenchidos',
                           'O NOME DO CLIENTE CLIENTE NÃO INFORMADO!',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                           'OK')  ;

       edt_consultaCliente.SetFocus;
       Abort;
     end;

     ds_consulta_agenda.DataSet := Agendamento.fnc_consulta_por_cliente(edt_consultaCliente.text)   ;
end;

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

procedure Tform_agenda.FormShow(Sender: TObject);
begin
  dataSource_profissionais.DataSet := form_dados.GetProfissional().fnc_consulta('');
  clndrpckr_calendario.Date := now;
end;

end.
