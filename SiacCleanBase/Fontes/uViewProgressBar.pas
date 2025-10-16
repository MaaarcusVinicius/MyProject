unit uViewProgressBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, frxGIFGraphic, Vcl.Imaging.pngimage;

type
  TfrmProgressBar = class(TForm)
    pnl_fundo: TPanel;
    ProgressBar1: TProgressBar;
    lblStatus: TLabel;
    lbl_statusProcesso: TLabel;
    img_progressBar: TImage;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProgressBar: TfrmProgressBar;

implementation

{$R *.dfm}

end.

