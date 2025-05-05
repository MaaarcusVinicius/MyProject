unit unit_relatorio_agendamento_cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  Tform_relatorio_agendamento_cliente = class(TForm)
    rlr_agendamentos_cliente: TRLReport;
    rlr_band_1: TRLBand;
    Tlbl_periodo: TRLLabel;
    Tlbl_titulo: TRLLabel;
    rlsystmnf1_page: TRLSystemInfo;
    rlsystmnf2_date: TRLSystemInfo;
    rlr_band_2: TRLBand;
    Tlbl_1: TRLLabel;
    Tlbl_2: TRLLabel;
    Tlbl_3: TRLLabel;
    Tlbl_5: TRLLabel;
    rlr_band_3: TRLBand;
    rldbtxt1: TRLDBText;
    rldbtxt2: TRLDBText;
    rldbtxt3: TRLDBText;
    rldbtxt5: TRLDBText;
    rlr_band_4: TRLBand;
    Tlbl_tota_Agendamentos: TRLLabel;
    Tlbl_total: TRLLabel;
    ds_padrao: TDataSource;
    lbl_cliente: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_relatorio_agendamento_cliente: Tform_relatorio_agendamento_cliente;

implementation

uses
  unit_relatorios;

{$R *.dfm}

end.
