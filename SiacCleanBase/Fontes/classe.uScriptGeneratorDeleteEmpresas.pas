unit classe.uScriptGeneratorDeleteEmpresas;

interface

uses
  System.SysUtils, System.Classes, DAScript, OraScript,
  Data.DB, DBAccess, Ora, MemDS;

type
  TScriptGeneratorDeleteEmpresas = class
  private
    qry_deletandoEmpresas: TOraQuery;
    OraScriptDeletandoEmpresa: TOraScript;
  public
    constructor Create(AConnection: TOraSession);
    destructor Destroy; override;

    procedure Gerar(const AEmpresaID: string);
    function GetScripts: string;
    procedure Executar;
  end;

implementation

{ TScriptGeneratorDeleteEmpresas }

constructor TScriptGeneratorDeleteEmpresas.Create(AConnection: TOraSession);
begin
  qry_deletandoEmpresas := TOraQuery.Create(nil);
  qry_deletandoEmpresas.Session := AConnection;

  OraScriptDeletandoEmpresa := TOraScript.Create(nil);
  OraScriptDeletandoEmpresa.Session := AConnection;

  qry_deletandoEmpresas.SQL.Text :=
    'SELECT ''DELETE FROM '' || C.TABLE_NAME || '' WHERE '' || C.COLUMN_NAME ||'' = '' ||:pEMPRESA_ID|| '';'' AS SCRIPT '+
    '  FROM COLS C, USER_TABLES T '+
    ' WHERE C.TABLE_NAME = T.TABLE_NAME '+
    '   AND C.COLUMN_NAME IN (''EMPRESA_ID'', ''SIAC_EMPRESA_ID'') '+
    '   AND C.TABLE_NAME NOT IN (''CADASTROS'', ''EMPRESAS'',''PROMOCOES'') '+
    '   AND C.TABLE_NAME NOT LIKE ''%PARAMETRO%''  '+
    '   UNION ALL '+
    'SELECT ''DELETE FROM '' || C.TABLE_NAME || '' WHERE '' || C.COLUMN_NAME || '' = '' ||:pEMPRESA_ID|| '';'' AS SCRIPT '+
    '  FROM COLS C, USER_TABLES T '+
    ' WHERE C.TABLE_NAME = T.TABLE_NAME '+
    '   AND C.COLUMN_NAME IN (''EMPRESA_ID'', ''SIAC_EMPRESA_ID'') '+
    '   AND C.TABLE_NAME LIKE ''%PARAMETRO%'' '+
    '   UNION ALL '+
    'SELECT ''DELETE FROM '' || C.TABLE_NAME || '' WHERE '' || C.COLUMN_NAME || '' = '' ||:pEMPRESA_ID|| '';'' AS SCRIPT '+
    '  FROM COLS C, USER_TABLES T '+
    ' WHERE C.TABLE_NAME = T.TABLE_NAME '+
    '   AND (C.COLUMN_NAME IN (''EMPRESA_ID'', ''SIAC_EMPRESA_ID'')) '+
    '   AND C.TABLE_NAME = ''EMPRESAS'' ';
end;

destructor TScriptGeneratorDeleteEmpresas.Destroy;
begin
  qry_deletandoEmpresas.Free;
  OraScriptDeletandoEmpresa.Free;
  inherited;
end;

procedure TScriptGeneratorDeleteEmpresas.Gerar(const AEmpresaID: string);
begin
  OraScriptDeletandoEmpresa.SQL.Clear;

  qry_deletandoEmpresas.Close;
  if qry_deletandoEmpresas.Params.FindParam('pEMPRESA_ID') <> nil then
    qry_deletandoEmpresas.ParamByName('pEMPRESA_ID').AsString := AEmpresaID;

  qry_deletandoEmpresas.Open;

  qry_deletandoEmpresas.First;
  while not qry_deletandoEmpresas.Eof do
  begin
    OraScriptDeletandoEmpresa.SQL.Add(qry_deletandoEmpresas.FieldByName('SCRIPT').AsString);
    qry_deletandoEmpresas.Next;
  end;
end;

function TScriptGeneratorDeleteEmpresas.GetScripts: string;
begin
  Result := OraScriptDeletandoEmpresa.SQL.Text;
end;

procedure TScriptGeneratorDeleteEmpresas.Executar;
begin
  if OraScriptDeletandoEmpresa.SQL.Count = 0 then
    raise Exception.Create('Nenhum script gerado para executar.');

  OraScriptDeletandoEmpresa.Execute;
end;

end.

