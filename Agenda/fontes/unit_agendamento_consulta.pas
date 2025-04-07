unit unit_agendamento_consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.WinXCalendars, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  Tform_agendamento_consulta = class(TForm)
    pnl_superior: TPanel;
    pnl_linha: TPanel;
    pnl_central: TPanel;
    btn__fechar: TSpeedButton;
    dblkcbb_selecionePorfissional: TDBLookupComboBox;
    lbl_selecioneProfissional: TLabel;
    clndrpckr_calendario: TCalendarPicker;
    cbb_hora: TComboBox;
    cbb_horarioMinutos: TComboBox;
    lbl_horarioHora: TLabel;
    edt_observacoes: TEdit;
    lbl_observacoes: TLabel;
    lbl_listaHorarioMarcado: TLabel;
    dbgrd_profissionais: TDBGrid;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    ds_consulta: TDataSource;
    procedure btn__fecharClick(Sender: TObject);
    procedure clndrpckr_calendarioChange(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_agendamento_consulta: Tform_agendamento_consulta;

implementation

uses
  unit_agendamento, unit_funcoes;

{$R *.dfm}

procedure Tform_agendamento_consulta.btn_confirmaClick(Sender: TObject);
begin
   prcValidarCamposObrigatorios( form_agendamento_consulta );

   if clndrpckr_calendario.IsEmpty then
     begin
       fnc_criar_menssagem('VALIDADAR DADOS',
                           'Dados Obrigatórios não Preenchidos',
                           'DATA AGENDAMENTO NÃO SELECIONADO!',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                           'OK')  ;
       Abort;
     end;


   try
     StrToTime(cbb_hora.Text + ':' + cbb_horarioMinutos.Text);
   except
       fnc_criar_menssagem('VALIDADAR DADOS',
                           'Dados Obrigatórios não Preenchidos',
                           'HORA AGENDAMENTO NÃO SELECIONADO!',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                           'OK')  ;
       cbb_hora.SetFocus;

       Abort;
   end;

   if form_agendamento.Agendamento.fnc_validar_agendamento( dblkcbb_selecionePorfissional.KeyValue,
                                                            clndrpckr_calendario.Date,
                                                            ( cbb_hora.Text + ':' + cbb_horarioMinutos.Text ) ) then
    begin

      form_agendamento.dblkcbb_selecionePorfissional.KeyValue := dblkcbb_selecionePorfissional.KeyValue;
      form_agendamento.edt_observacoes.text := edt_observacoes.text;
      form_agendamento.medt_agendamentoData.Text :=  DateToStr( clndrpckr_calendario.Date );
      form_agendamento.medt_horaAgendamento.Text :=  ( cbb_hora.Text + ':' + cbb_horarioMinutos.Text );

      Close;

    end else
    begin

       fnc_criar_menssagem('VALIDADAR DADOS',
                           'ERRO AO AGENDAR HORÁRIO',
                           'DIA OU HORA DO AGENDAMENTO JÁ UTILIZADO!',
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                           'OK')  ;
       cbb_hora.SetFocus;

    end;

end;

procedure Tform_agendamento_consulta.btn__fecharClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_agendamento_consulta.clndrpckr_calendarioChange(
  Sender: TObject);
begin

   if clndrpckr_calendario.IsEmpty then
      exit;

  if ( dblkcbb_selecionePorfissional.KeyValue = null ) then
    begin
       fnc_criar_menssagem('VALIDADOS DADOS',
                     'Dados Obrigatórios não Preenchidos',
                     'PRIMEIRAMENTE SELECIONE UM PROFISSIONAL!',
                     ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                     'OK')  ;

       clndrpckr_calendario.IsEmpty := True;
       dblkcbb_selecionePorfissional.SetFocus;

       Abort;

    end else
    begin

       ds_consulta.DataSet := form_agendamento.Agendamento.fnc_consulta(
       dblkcbb_selecionePorfissional.KeyValue, clndrpckr_calendario.Date);

    end;
end;

end.
