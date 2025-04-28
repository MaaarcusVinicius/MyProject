unit unit_usuario_consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, unit_usuario_cadastro;

type
  Tform_usuario_consulta = class(TForm)
    pnl_fundo: TPanel;
    lbl_obsProfissional: TLabel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    lbl_aviso: TLabel;
    lbl_aviso2: TLabel;
    lbl_pesParte1: TLabel;
    pnl_clientebotoes: TPanel;
    pnl_seleciona: TPanel;
    btn_seleciona: TSpeedButton;
    pnl_cancelar: TPanel;
    btn_cancelar: TSpeedButton;
    edt_nomeCliente: TEdit;
    pnl_linhaTop: TPanel;
    dbgrd_consultaUsuario: TDBGrid;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    pnl_novoUsuário: TPanel;
    pnl_11: TPanel;
    btn_1: TSpeedButton;
    ds_consultaUsuario: TDataSource;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_usuario_consulta: Tform_usuario_consulta;

implementation

{$R *.dfm}

procedure Tform_usuario_consulta.btn_1Click(Sender: TObject);
begin
  try

    form_usuario_consulta.Visible:= False;

    form_usuario_cadastro := Tform_usuario_cadastro.Create( Self );
    form_usuario_cadastro.ShowModal;

  finally
    form_usuario_cadastro.Free;
    form_usuario_consulta.Visible:= true;
  end;
end;

procedure Tform_usuario_consulta.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

end.
