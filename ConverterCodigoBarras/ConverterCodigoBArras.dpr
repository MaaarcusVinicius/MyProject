program ConverterCodigoBArras;

uses
  Vcl.Forms,
  Converter in 'Converter.pas' {Form1},
  BoletoConverter in 'BoletoConverter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
