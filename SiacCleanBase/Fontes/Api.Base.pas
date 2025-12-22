unit Api.Base;

interface

uses
  System.Classes,
  System.JSON, uViewMain;

type
  TApi= class(TComponent)
  private
    FURL: string;
    FAuthorization: string;
  public
    function Post(const pChave: string): Boolean;
    function Get(pChave : string): TJSonValue;
    function GetFile(pChave : string): TMemoryStream;
    function Put(const pJson: string; pId: string): TJSonValue;    
    property URL: string read FURL write FURL;
    property Authorization: string read FAuthorization write FAuthorization;
  end;

implementation

uses
  System.SysUtils,
  System.NetConsts,
  System.Net.HttpClient,
  System.Net.URLClient;


function TApi.Get(pChave: string): TJSonValue;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
begin
  HttpClient := THTTPClient.Create;
  try
    HttpClient.ContentType := 'application/json';
    HttpClient.AcceptCharSet := 'utf-8';

    FURL := FURL+ '/' + pChave;
    Response := HttpClient.Get(FURL, nil,
        TNetHeaders.Create(TNameValuePair.Create('authorization', 'Bearer '+ Authorization)));

    Result := TJSonObject.ParseJSONValue(Response.ContentAsString());

  finally
    HttpClient.Free;
  end;
end;

function TApi.GetFile(pChave: string): TMemoryStream;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  vArquivo : TMemoryStream;

begin
  HttpClient := THTTPClient.Create;
  vArquivo := TMemoryStream.Create;
  try
    HttpClient.ContentType := 'application/json';
    HttpClient.AcceptCharSet := 'utf-8';

    FURL := FURL+ '/' + pChave;
    Response := HttpClient.Get(FURL,vArquivo,
        TNetHeaders.Create(TNameValuePair.Create('authorization', 'Bearer '+ Authorization)));

    Result := vArquivo;

  finally
    HttpClient.Free;
    //vArquivo.Free;
  end;
end;

function TApi.Post(const pChave: string): Boolean;
var
  HttpClient: THTTPClient;
  ST: TStringStream;
  Response: IHTTPResponse;
  RetornoXML: string;
  InicioTag, FimTag: Integer;
  ValorTag: string;
  InicioFunc, FimFunc, InicioNome, FimNome: Integer;
  FuncionarioId, NomeFuncionario: string;
begin
  Result := False; // Valor padrão (falha)
  HttpClient := THTTPClient.Create;
  try
    HttpClient.ContentType := 'application/soap+xml; charset=utf-8';
    HttpClient.Accept := 'application/soap+xml';

    ST := TStringStream.Create(pChave, TEncoding.UTF8);
    try
      Response := HttpClient.Post(FURL, ST, nil, nil);
      RetornoXML := Response.ContentAsString(TEncoding.UTF8);

      // 🔹 Extrai o resultado do login
      InicioTag := Pos('<LoginTecnicoArqBaseResult>', RetornoXML);
      FimTag := Pos('</LoginTecnicoArqBaseResult>', RetornoXML);

      if (InicioTag > 0) and (FimTag > InicioTag) then
      begin
        ValorTag := Copy(RetornoXML,
                         InicioTag + Length('<LoginTecnicoArqBaseResult>'),
                         FimTag - (InicioTag + Length('<LoginTecnicoArqBaseResult>')));
        ValorTag := Trim(LowerCase(ValorTag));
        Result := (ValorTag = 'true');
      end;

      // 🔹 Mesmo se falhar no login, tentamos capturar informações adicionais
      // Captura o <FuncionarioId>
      InicioFunc := Pos('<FuncionarioId>', RetornoXML);
      FimFunc := Pos('</FuncionarioId>', RetornoXML);
      if (InicioFunc > 0) and (FimFunc > InicioFunc) then
        FuncionarioId := Copy(RetornoXML,
                              InicioFunc + Length('<FuncionarioId>'),
                              FimFunc - (InicioFunc + Length('<FuncionarioId>')))
      else
        FuncionarioId := '';

      // Captura o <Nome>
      InicioNome := Pos('<Nome>', RetornoXML);
      FimNome := Pos('</Nome>', RetornoXML);
      if (InicioNome > 0) and (FimNome > InicioNome) then
        NomeFuncionario := Copy(RetornoXML,
                                InicioNome + Length('<Nome>'),
                                FimNome - (InicioNome + Length('<Nome>')))
      else
        NomeFuncionario := '';

      // 🔹 Exemplo: salvar em variáveis globais (caso tenha definido no projeto)
      if FuncionarioId <> '' then
        vGbl_FuncionarioId := FuncionarioId;
      if NomeFuncionario <> '' then
        vGbl_FuncionarioNome := NomeFuncionario;

    finally
      ST.Free;
    end;
  finally
    HttpClient.Free;
  end;
end;



function TApi.Put(const pJson: string; pId: string): TJSonValue;
var
  HttpClient: THTTPClient;
  ST: TStream;
  Response: IHTTPResponse;
begin
  HttpClient := THTTPClient.Create;
  try
    FURL := FURL +'/'+pId;
    HttpClient.ContentType := 'application/json';

    ST := TStringStream.Create(pJson);
    try
      Response := HttpClient.Put(URL, ST, nil,
          TNetHeaders.Create(TNameValuePair.Create('Authorization', 'Bearer '+ Authorization)));

        Result := TJSonObject.ParseJSONValue(Response.ContentAsString());

    finally
      ST.Free;
    end;
  finally
    HttpClient.Free;
  end;
end;

end.
