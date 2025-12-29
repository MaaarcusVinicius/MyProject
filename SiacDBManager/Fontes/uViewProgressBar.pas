unit uViewProgressBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmProgressBar = class(TForm)
    pnl_fundo: TPanel;
    ProgressBar1: TProgressBar;
    lblStatus: TLabel;
    lbl_statusProcesso: TLabel;
    img_progressBar: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFormTranslucido: TForm;
    procedure CriarFormTranslucido;
    procedure DestruirFormTranslucido;
  public
    procedure IniciarProcesso;
    procedure FinalizarProcesso;
  end;

var
  frmProgressBar: TfrmProgressBar;

implementation

uses
  uViewMain;

{$R *.dfm}

{ ==== Criação do formulário translúcido ==== }
procedure TfrmProgressBar.CriarFormTranslucido;
begin
  FFormTranslucido := TForm.Create(nil);
  FFormTranslucido.BorderStyle := bsNone;
  FFormTranslucido.AlphaBlend := True;
  FFormTranslucido.AlphaBlendValue := 125;
  FFormTranslucido.Color := clBlack;
  FFormTranslucido.Enabled := True;              // 🔒 bloqueia interação no fundo
  FFormTranslucido.FormStyle := fsStayOnTop;
  FFormTranslucido.ShowInTaskbar := False;
  FFormTranslucido.DoubleBuffered := True;

  // Pega posição e tamanho do form principal
  FFormTranslucido.SetBounds(
    uViewMain.ViewMain.Left,
    uViewMain.ViewMain.Top,
    uViewMain.ViewMain.Width,
    uViewMain.ViewMain.Height
  );

  // Exibe o overlay antes do progresso
  FFormTranslucido.Show;
  FFormTranslucido.BringToFront;
  FFormTranslucido.Update;
end;

{ ==== Destruição do formulário translúcido ==== }
procedure TfrmProgressBar.DestruirFormTranslucido;
begin
  if Assigned(FFormTranslucido) then
  begin
    FFormTranslucido.Close;
    FFormTranslucido.Free;
    FFormTranslucido := nil;
  end;
end;

{ ==== Quando o form principal (de progresso) for criado ==== }
procedure TfrmProgressBar.FormCreate(Sender: TObject);
begin
  CriarFormTranslucido;
end;

{ ==== Quando o form principal for destruído ==== }
procedure TfrmProgressBar.FormDestroy(Sender: TObject);
begin
  DestruirFormTranslucido;
end;

{ ==== Inicia o processo com bloqueio total ==== }
procedure TfrmProgressBar.IniciarProcesso;
begin
  if Assigned(FFormTranslucido) then
  begin
    FFormTranslucido.Enabled := True;  // bloqueia tudo
    FFormTranslucido.BringToFront;
  end;
  Self.Show;
  Self.BringToFront;
end;

{ ==== Finaliza o processo e libera o fundo ==== }
procedure TfrmProgressBar.FinalizarProcesso;
begin
  if Assigned(FFormTranslucido) then
  begin
    FFormTranslucido.Enabled := False; // libera cliques
    FFormTranslucido.Hide;
  end;
  Self.Hide;
end;

end.

