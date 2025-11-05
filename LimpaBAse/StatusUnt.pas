unit StatusUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, pngimage, ExtCtrls, MensagensUnt;

type
  TStatusFrm = class(TForm)
    StatusMmo: TMemo;
    StatusPrsBr: TProgressBar;
    SalvarImg: TImage;
    FecharImg: TImage;
    SalvarDlg: TSaveDialog;
    procedure FecharImgClick(Sender: TObject);
    procedure SalvarImgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    procedure Status(Mensagem: String);
    procedure Visualizar;
    procedure Salvar;
  end;

var
  StatusFrm: TStatusFrm;

implementation

{$R *.dfm}

procedure TStatusFrm.FecharImgClick(Sender: TObject);
{Executa Close.}
begin
  Close;
end;

procedure TStatusFrm.FormCreate(Sender: TObject);
{Atribui diretório inicial para SalvarDlg.}
begin
  SalvarDlg.InitialDir:= ExtractFilePath(Application.ExeName);
end;

procedure TStatusFrm.FormHide(Sender: TObject);
{Bloqueia seleção de MainForm.}
begin
  Application.MainForm.Enabled:= not Showing;
end;

procedure TStatusFrm.FormShow(Sender: TObject);
{Desbloqueia seleção de MainForm.}
begin
  Application.MainForm.Enabled:= not Showing;
end;

procedure TStatusFrm.Salvar;
{Salvar Status no local indicado.}
begin
  try
    if SalvarDlg.Execute then
      begin
        StatusMmo.Lines.SaveToFile(SalvarDlg.Files[0]);
        MensagensFrm.MsgBox(INF_ARQUIVO_SALVO, SalvarDlg.Files[0]);
      end;
  except
    on E : Exception do
      MensagensFrm.MsgBox(ERRO_SALVAR_ARQUIVO, SalvarDlg.Files[0] + sLineBreak
      + E.Message);
  end;
end;

procedure TStatusFrm.SalvarImgClick(Sender: TObject);
{Executa Salvar e Close.}
begin
  Salvar;
  Close;
end;

procedure TStatusFrm.Status(Mensagem: String);
{Inseri linha no campo memo.}
begin
  StatusPrsBr.Visible:= True;
  SalvarImg.Enabled:= False;
  FecharImg.Enabled:= False;
  if not StatusFrm.Visible then
    begin
      StatusFrm.Show;
    end;
  StatusMmo.Lines.Add('[' + TimeToStr(Now) + '] ' + Mensagem);
end;
procedure TStatusFrm.Visualizar;
{Chama Form para visualização.}
begin
  StatusPrsBr.Visible:= False;
  SalvarImg.Enabled:= True;
  FecharImg.Enabled:= True;
  ShowModal;
end;

end.
