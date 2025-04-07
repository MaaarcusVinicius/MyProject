unit BoletoConverter;
interface
type
  TBoletoConverter = class
  private
    function CalcularDigitoVerificador(Campo: string): string;
    function RemoverFormatacao(LinhaDigitavel: string): string;
  public
    function GerarLinhaDigitavel(CodigoBarras: string): string;
    function GerarCodigoBarras(LinhaDigitavel: string): string;
  end;
implementation
uses
  SysUtils;
{ TBoletoConverter }
function TBoletoConverter.CalcularDigitoVerificador(Campo: string): string;
var
  Soma, Peso, I, Multiplicacao, Digito: Integer;
begin
  Soma := 0;
  Peso := 2;
  for I := Length(Campo) downto 1 do
  begin
    Multiplicacao := StrToInt(Campo[I]) * Peso;
    if Multiplicacao > 9 then
      Multiplicacao := Multiplicacao - 9;
    Soma := Soma + Multiplicacao;
    if Peso = 2 then
      Peso := 1
    else
      Peso := 2;
  end;
  Digito := (10 - (Soma mod 10)) mod 10;
  Result := IntToStr(Digito);
end;
function TBoletoConverter.GerarCodigoBarras(LinhaDigitavel: string): string;
var
  CodigoBarras, Campo1, Campo2, Campo3, Campo4, Campo5: string;
begin
  // Remove a formatação da linha digitável (pontos e espaços)
  LinhaDigitavel := RemoverFormatacao(LinhaDigitavel);
  // Extrair os campos da linha digitável
  Campo1 := Copy(LinhaDigitavel, 1, 9);  // Primeiros 9 dígitos
  Campo2 := Copy(LinhaDigitavel, 11, 10); // Próximos 10 dígitos
  Campo3 := Copy(LinhaDigitavel, 22, 10); // Próximos 10 dígitos
  Campo4 := Copy(LinhaDigitavel, 33, 1);  // DAC (dígito verificador geral)
  Campo5 := Copy(LinhaDigitavel, 34, 14); // Fator de vencimento + Valor
  // Montar o código de barras
  CodigoBarras := Copy(Campo1, 1, 4) + Campo4 + Campo5 + Copy(Campo1, 5, 5) +
                  Copy(Campo2, 1, 10) + Copy(Campo3, 1, 10);
  Result := CodigoBarras;
end;


function TBoletoConverter.GerarLinhaDigitavel(CodigoBarras: string): string;
var
  Campo1, Campo2, Campo3, Campo4, Campo5: string;
begin
  if Length(CodigoBarras) <> 44 then
    raise Exception.Create('O código de barras deve conter 44 dígitos');
  Campo1 := Copy(CodigoBarras, 1, 4) + Copy(CodigoBarras, 20, 1) + Copy(CodigoBarras, 21, 4);
  Campo2 := Copy(CodigoBarras, 25, 5) + Copy(CodigoBarras, 30, 5);
  Campo3 := Copy(CodigoBarras, 35, 5) + Copy(CodigoBarras, 40, 5);
  Campo4 := Copy(CodigoBarras, 5, 1); // DAC (Dígito verificador do código de barras)
  Campo5 := Copy(CodigoBarras, 6, 4) + Copy(CodigoBarras, 10, 10); // Fator de vencimento + Valor
  Campo1 := Copy(Campo1, 1, 5) + '.' + Copy(Campo1, 6, 4) + CalcularDigitoVerificador(Campo1);
  Campo2 := Copy(Campo2, 1, 5) + '.' + Copy(Campo2, 6, 5) + CalcularDigitoVerificador(Campo2);
  Campo3 := Copy(Campo3, 1, 5) + '.' + Copy(Campo3, 6, 5) + CalcularDigitoVerificador(Campo3);
  Result := Campo1 + ' ' + Campo2 + ' ' + Campo3 + ' ' + Campo4 + ' ' + Campo5;
end;
function TBoletoConverter.RemoverFormatacao(LinhaDigitavel: string): string;
begin
  Result := StringReplace(LinhaDigitavel, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
end;

end.
