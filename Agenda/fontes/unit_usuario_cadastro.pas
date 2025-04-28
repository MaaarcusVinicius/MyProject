unit unit_usuario_cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  Tform_usuario_cadastro = class(TForm)
    pnl_fundo: TPanel;
    lbl_nomeUsuario: TLabel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    pnl_botoes: TPanel;
    pnl_confirma: TPanel;
    btn_confirma: TSpeedButton;
    pnl_nao: TPanel;
    btn_cancelar: TSpeedButton;
    edt_nomeUsuario: TEdit;
    pnl_linhaTop: TPanel;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    edt_senha1: TEdit;
    lbl_1: TLabel;
    edt_senha11: TEdit;
    lbl_senha2: TLabel;
    edt_grupoUsuario: TEdit;
    btn_consultaProfissionais: TSpeedButton;
    lbl_grupoUsuario: TLabel;
    procedure btn_cancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_usuario_cadastro: Tform_usuario_cadastro;

implementation

{$R *.dfm}

procedure Tform_usuario_cadastro.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

end.
