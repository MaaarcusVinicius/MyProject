unit unit_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, unit_configurarServidor;

type
  Tform_Principal = class(TForm)
    lbl_nomeSistema: TLabel;
    lbl_siacSistemas: TLabel;
    pnl_fundo: TPanel;
    btn_close: TSpeedButton;
    btn_minimizar: TSpeedButton;
    pnl_lateralLefth: TPanel;
    pnl_lateralRigth: TPanel;
    pnl_linhaCentral: TPanel;
    pnl_linhaTop: TPanel;
    pnl_linhaBootom: TPanel;
    pnl_botoesForm: TPanel;
    img_logoSiacAgenda: TImage;
    lbl_logoTipo: TLabel;
    img_logoCentral: TImage;
    pnl_user: TPanel;
    btn_user: TSpeedButton;
    pnl_relatorio: TPanel;
    btn_relatorio: TSpeedButton;
    pnl_configuracao: TPanel;
    btn_1: TSpeedButton;
    pnl_agendamento: TPanel;
    btn_agendamento: TSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure btn_minimizarClick(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure btn_agendamentoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_Principal: Tform_Principal;

implementation

{$R *.dfm}

uses unit_funcoes, unit_agendamento;




procedure Tform_Principal.btn_1Click(Sender: TObject);
begin
  try

    form_configurarServidor := Tform_configurarServidor.Create( Self );
    form_configurarServidor.ShowModal;
    form_Principal.pnl_fundo.Enabled  := False;
    form_Principal.pnl_fundo.Visible  := False;

  finally

    form_configurarServidor.Free;
    form_Principal.pnl_fundo.Enabled  := True;
    form_Principal.pnl_fundo.Visible  := True;

  end;
end;

procedure Tform_Principal.btn_agendamentoClick(Sender: TObject);
begin

  form_agendamento          := Tform_agendamento.Create( Self );
  form_agendamento.Parent   := pnl_lateralRigth;
  form_agendamento.Show;

  pnl_lateralLefth.Enabled  := False;

end;

procedure Tform_Principal.btn_closeClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tform_Principal.btn_minimizarClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure Tform_Principal.FormResize(Sender: TObject);
begin

  pnl_fundo.top  := Round (( form_Principal.Height - pnl_fundo.Height )  / 2 );
  pnl_fundo.left := Round (( form_Principal.Width - pnl_fundo.Width )  / 2 );

end;

end.
