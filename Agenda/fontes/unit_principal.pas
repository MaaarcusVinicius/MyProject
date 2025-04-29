unit unit_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, unit_configurarServidor, unit_agenda;

type
  Tform_Principal = class(TForm)
    pnl_fundo: TPanel;
    pnl_lateralLefth: TPanel;
    pnl_lateralRigth: TPanel;
    pnl_linhaCentral: TPanel;
    pnl_linhaTop: TPanel;
    pnl_linhaBootom: TPanel;
    img_logoCentral: TImage;
    pnl_user: TPanel;
    btn_user: TSpeedButton;
    pnl_relatorio: TPanel;
    btn_relatorio: TSpeedButton;
    pnl_configuracao: TPanel;
    btn_1: TSpeedButton;
    pnl_agendamento: TPanel;
    btn_agendamento: TSpeedButton;
    pnl_rodape: TPanel;
    lbl_siacSistemas: TLabel;
    pnl_cabecario: TPanel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    lbl_nomeUser: TLabel;
    pnl_botoesForm: TPanel;
    btn_close: TSpeedButton;
    btn_minimizar: TSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure btn_minimizarClick(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure btn_agendamentoClick(Sender: TObject);
    procedure btn_userClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_Principal: Tform_Principal;

implementation

{$R *.dfm}

uses unit_funcoes, unit_agendamento, unit_usuario_consulta;




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
  try
    form_agenda := Tform_agenda.Create( Self );
    form_agenda.ShowModal;
  finally
    form_agenda.Free;
  end;
end;

procedure Tform_Principal.btn_closeClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tform_Principal.btn_minimizarClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure Tform_Principal.btn_userClick(Sender: TObject);
begin
  try
    form_usuario_consulta := Tform_usuario_consulta.Create( Self );
    form_usuario_consulta.ShowModal;
  finally
    form_usuario_consulta.Free;
  end;
end;

procedure Tform_Principal.FormResize(Sender: TObject);
begin

  pnl_fundo.top  := Round (( form_Principal.Height - pnl_fundo.Height )  / 2 );
  pnl_fundo.left := Round (( form_Principal.Width - pnl_fundo.Width )  / 2 );

end;

procedure Tform_Principal.FormShow(Sender: TObject);
begin
  form_Principal.lbl_nomeUser.Caption := 'Usuário: ' + var_gbl_nome_usuario;
end;

end.
