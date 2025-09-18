unit classe.uScriptGeneratorTriggers;

interface

uses
  System.SysUtils, System.Classes, DAScript, OraScript,
  Data.DB, DBAccess, Ora, MemDS;

type
  TScriptGeneratorTriggers = class
  private
    qry_DeleteTriggers: TOraQuery;
    OraScriptDeleteTriggers: TOraScript;
  public
    constructor Create(AConnection: TOraSession);
    destructor Destroy; override;

    procedure Gerar(const AUsuario: string);
    function GetScripts: string;
    procedure Executar;
  end;

implementation

{ TScriptGeneratorTriggers }

constructor TScriptGeneratorTriggers.Create(AConnection: TOraSession);
begin
  qry_DeleteTriggers := TOraQuery.Create(nil);
  qry_DeleteTriggers.Session := AConnection;

  OraScriptDeleteTriggers := TOraScript.Create(nil);
  OraScriptDeleteTriggers.Session := AConnection;

  qry_DeleteTriggers.SQL.Text :=
    'SELECT ''ALTER TRIGGER '' || OBJECT_NAME || '' DISABLE ;'' AS SCRIPT ' +
    '  FROM USER_OBJECTS C ' +
    ' WHERE C.OBJECT_TYPE = ''TRIGGER'' ' +
    'UNION ALL ' +
    'SELECT ''ALTER TABLE '' || OWNER || ''.'' || CC.TABLE_NAME || ' +
    '       '' DISABLE CONSTRAINT '' || CONSTRAINT_NAME || '';'' AS SCRIPT ' +
    '  FROM DBA_CONSTRAINTS CC ' +
    ' WHERE CC.OWNER = :vUSER';
end;

destructor TScriptGeneratorTriggers.Destroy;
begin
  qry_DeleteTriggers.Free;
  OraScriptDeleteTriggers.Free;
  inherited;
end;

procedure TScriptGeneratorTriggers.Gerar(const AUsuario: string);
begin
  OraScriptDeleteTriggers.SQL.Clear;

  qry_DeleteTriggers.Close;
  if qry_DeleteTriggers.Params.FindParam('vUSER') <> nil then
    qry_DeleteTriggers.ParamByName('vUSER').AsString := AUsuario;

  qry_DeleteTriggers.Open;

  qry_DeleteTriggers.First;
  while not qry_DeleteTriggers.Eof do
  begin
    OraScriptDeleteTriggers.SQL.Add(qry_DeleteTriggers.FieldByName('SCRIPT').AsString);
    qry_DeleteTriggers.Next;
  end;
end;

function TScriptGeneratorTriggers.GetScripts: string;
begin
  Result := OraScriptDeleteTriggers.SQL.Text;
end;

procedure TScriptGeneratorTriggers.Executar;
begin
  if OraScriptDeleteTriggers.SQL.Count = 0 then
    raise Exception.Create('Nenhum script gerado para executar.');

  OraScriptDeleteTriggers.Execute;
end;

end.

