unit SelecoesUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ExtDlgs;

type
  TSelecoesFrm = class(TForm)
    FecharImg: TImage;
    SalvarImg: TImage;
    SelecoesMmo: TMemo;
    SalvarDlg: TSaveDialog;
    procedure FecharImgClick(Sender: TObject);
    procedure SalvarImgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Salvar;
  end;

var
  SelecoesFrm: TSelecoesFrm;

implementation
uses
  MensagensUnt;
{$R *.dfm}
procedure TSelecoesFrm.FecharImgClick(Sender: TObject);
{Executa Close.}
begin
  Close;
end;


procedure TSelecoesFrm.FormCreate(Sender: TObject);
{Define diretório inicial em SalvarDlg.}
begin
  SalvarDlg.InitialDir:= ExtractFilePath(Application.ExeName);
end;

procedure TSelecoesFrm.Salvar;
{Salva histórico de mensagens em arquivo.}
begin
  try
    if SalvarDlg.Execute then
      begin
        SelecoesMmo.Lines.SaveToFile(SalvarDlg.Files[0]);
        MensagensFrm.MsgBox(INF_ARQUIVO_SALVO, SalvarDlg.Files[0]);
      end;
  except
    on E : Exception do
      MensagensFrm.MsgBox(ERRO_SALVAR_ARQUIVO, SalvarDlg.Files[0] + sLineBreak
                          + E.Message);
  end;
end;

procedure TSelecoesFrm.SalvarImgClick(Sender: TObject);
{Executa Salvar e Close.}
begin
  Salvar;
  Close;
end;
end.
