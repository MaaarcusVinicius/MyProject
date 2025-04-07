unit Converter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BoletoConverter;

type
  TForm1 = class(TForm)
    edtLinha: TEdit;
    btnGerar: TButton;
    lblResultado: TLabel;
    lbllinhadigital: TLabel;
    btnLinhadigitavel: TButton;
    edtLInhaDigitavel: TEdit;
    Label1: TLabel;
    procedure btnGerarClick(Sender: TObject);
    procedure btnLinhadigitavelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGerarClick(Sender: TObject);
var
 vCodigo : TBoletoConverter;
begin
vCodigo := TBoletoConverter.Create;
lblResultado.Caption := vCodigo.GerarLinhaDigitavel(edtLinha.text);
end;

procedure TForm1.btnLinhadigitavelClick(Sender: TObject);
var
 vCodigo : TBoletoConverter;
begin
  vCodigo := TBoletoConverter.Create;
  lblResultado.Caption := vCodigo.GerarCodigoBarras(edtLInhaDigitavel.text);
end;

end.
