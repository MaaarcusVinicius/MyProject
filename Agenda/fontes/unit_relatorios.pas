unit unit_relatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, unit_funcoes, ACBrBase, ACBrEnterTab,
  Vcl.WinXCalendars, unit_relatorio_agendamento_periodo, classe.relatorios, unit_dados;

type
  Tform_relatorios = class(TForm)
    pnl_fundo: TPanel;
    pnl_linhaTop: TPanel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    lbl_nomeProfissional: TLabel;
    pnl_botoes: TPanel;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    pnl_nao: TPanel;
    btn_cancelar: TSpeedButton;
    cmb_tipo_relatorio: TComboBox;
    dbe_data_inicio: TMaskEdit;
    dbe_data_final: TMaskEdit;
    lbl_dataInicio: TLabel;
    lbl_dataFinal: TLabel;
    Acbr_tabEnter: TACBrEnterTab;
    clndrpckr_dataInicial: TCalendarPicker;
    clndrpckr_dataFinal: TCalendarPicker;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
    procedure dbe_data_inicioExit(Sender: TObject);
    procedure dbe_data_finalExit(Sender: TObject);
    procedure clndrpckr_dataInicialChange(Sender: TObject);
    procedure clndrpckr_dataFinalChange(Sender: TObject);
    procedure dbe_data_inicioDblClick(Sender: TObject);
    procedure dbe_data_finalDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Relatorios: TRelatorios;
  end;

var
  form_relatorios: Tform_relatorios;

implementation

{$R *.dfm}

procedure Tform_relatorios.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_relatorios.btn_confirmaClick(Sender: TObject);
begin

  prcValidarCamposObrigatorios( form_relatorios );

  if ( fnc_sonumeros(dbe_data_inicio.Text)  = '' ) then
      begin
       fnc_criar_menssagem('INSERIR DADOS',
                'DATA INICIAL NÃO FOI INFORMADA',
                'DATA FORA DO PADRÃO ESPERADO',
                ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                'OK') ;

        dbe_data_inicio.SetFocus;

        Exit;

      end;

  if ( fnc_sonumeros(dbe_data_final.Text)  = '' ) then
      begin
       fnc_criar_menssagem('INSERIR DADOS',
                  'DATA FINAL NÃO FOI INFORMADA',
                  'DATA FORA DO PADRÃO ESPERADO',
                  ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                  'OK')  ;

        dbe_data_final.SetFocus;

        Exit;

      end;

  if ( (dbe_data_inicio.Text) > (dbe_data_final.Text)   ) then
      begin
       fnc_criar_menssagem('INSERIR DADOS',
                'DATA INICIAL NÃO PODE SER MAIOR A DATA FINAL!',
                'DATA FORA DO PADRÃO ESPERADO',
                ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                'OK')  ;
        Exit;
      end;


 case cmb_tipo_relatorio.ItemIndex of
  0: begin
       try
         form_relatorio_agendamento_periodo := Tform_relatorio_agendamento_periodo.Create(Self);

         form_relatorio_agendamento_periodo.Tlbl_periodo.Caption :=
         'PERÍODO DE: ' + dbe_data_inicio.Text + ' ATÉ: ' + dbe_data_final.Text;


         Relatorios.prc_agendamento_periodo(StrToDate(dbe_data_inicio.Text), StrToDate(dbe_data_final.Text));

         form_relatorio_agendamento_periodo.ds_padrao.DataSet := Relatorios.qry_agendamento_periodo;
         form_relatorio_agendamento_periodo.Tlbl_total.Caption := IntToStr( Relatorios.qry_agendamento_periodo.RecordCount );

         form_relatorio_agendamento_periodo.rlr_agendamentos_periodo.Preview;

       finally
         form_relatorio_agendamento_periodo.Destroy;
       end;


     end;
 end;

end;

procedure Tform_relatorios.clndrpckr_dataFinalChange(Sender: TObject);
begin
  dbe_data_final.Text := DateToStr(clndrpckr_datafinal.Date);
end;

procedure Tform_relatorios.clndrpckr_dataInicialChange(Sender: TObject);
begin
  dbe_data_inicio.Text := DateToStr(clndrpckr_dataInicial.Date);
end;

procedure Tform_relatorios.dbe_data_inicioDblClick(Sender: TObject);
begin
  // SE CLICAR DUAS VEZES SOBRE O CAMPO DATA FINAL O SISTEMA PREENCHE O CAMPO COM SYSDATE
  dbe_data_inicio.text :=  DateToStr(now());

end;

procedure Tform_relatorios.dbe_data_finalDblClick(Sender: TObject);
begin
  // SE CLICAR DUAS VEZES SOBRE O CAMPO DATA FINAL O SISTEMA PREENCHE O CAMPO COM SYSDATE
  dbe_data_final.text :=  DateToStr(now());

end;

procedure Tform_relatorios.dbe_data_inicioExit(Sender: TObject);
begin
    if ( fnc_sonumeros(dbe_data_inicio.Text)  <> '' ) and
     ( dbe_data_inicio.Text <> '__/__/____' ) then
    begin
      try
      dbe_data_inicio.Text := FormatDateTime('DD/MM/YYYY', StrToDate(dbe_data_inicio.Text))  ;
      except

        fnc_criar_menssagem('INSERIR DADOS',
                            'DATA INICIAL INVÁLIDA',
                            'DATA FORA DO PADRÃO ESPERADO',
                            ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                            'OK')  ;

      dbe_data_inicio.SetFocus;

      end;
    end;
end;


procedure Tform_relatorios.FormCreate(Sender: TObject);
begin
  Relatorios := TRelatorios.Create (form_dados.FDConnection );
end;

procedure Tform_relatorios.FormDestroy(Sender: TObject);
begin
  Relatorios.Destroy;
end;

procedure Tform_relatorios.dbe_data_finalExit(Sender: TObject);
begin
    if ( fnc_sonumeros(dbe_data_final.Text)  <> '' ) and
     ( dbe_data_final.Text <> '__/__/____' ) then
    begin
      try
      dbe_data_final.Text := FormatDateTime('DD/MM/YYYY', StrToDate(dbe_data_final.Text))  ;
      except

        fnc_criar_menssagem('INSERIR DADOS',
                            'DATA FINAL INVÁLIDA',
                            'DATA FORA DO PADRÃO ESPERADO',
                            ExtractFilePath(Application.ExeName ) + '\icones\icon_erro.png',
                            'OK')  ;

      dbe_data_final.SetFocus;

      end;
    end;
end;

end.
