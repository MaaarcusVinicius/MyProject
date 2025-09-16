unit classe.uScriptGenerator;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript,
  OraScript, Data.DB, DBAccess, Ora, OraSmart, MemDS, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, unit_funcoes, Vcl.StdCtrls, Vcl.Mask;



type
  TScriptGenerator = class
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

uses
  Principal;

{ TScriptGenerator }

constructor TScriptGenerator.Create(AConnection: TOraSession);
begin
  qry_DeleteTriggers := TOraQuery.Create(nil);
  qry_DeleteTriggers.Session := AConnection;

  OraScriptDeleteTriggers := TOraScript.Create(nil);
  OraScriptDeleteTriggers.Session := AConnection;

  // SQL padrão já configurado direto no construtor
  qry_DeleteTriggers.SQL.Text :=
    'SELECT ''ALTER TRIGGER '' || OBJECT_NAME || '' DISABLE ;'' AS SCRIPT ' +
    '  FROM USER_OBJECTS C ' +
    ' WHERE C.OBJECT_TYPE = ''TRIGGER'' ' +
    //'   AND C.OBJECT_NAME = ''PARAMETROS1_AUD_JN'' ' +
    'UNION ALL ' +
    'SELECT ''ALTER TABLE '' || OWNER || ''.'' || CC.TABLE_NAME || ' +
    '       '' DISABLE CONSTRAINT '' || CONSTRAINT_NAME || '';'' AS SCRIPT ' +
    '  FROM DBA_CONSTRAINTS CC ' +
    //' WHERE CC.TABLE_NAME =  ''ESTOQUES'' ' +
    ' WHERE 1 =  1' +
    '   AND CC.OWNER = :vUSER';

end;

destructor TScriptGenerator.Destroy;
begin
  qry_DeleteTriggers.Free;
  OraScriptDeleteTriggers.Free;
  inherited;
end;

procedure TScriptGenerator.Gerar(const AUsuario: string);
var
  saveScriptOracle: TStringList;
begin
  saveScriptOracle := TStringList.Create;
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

  try
      saveScriptOracle.Text := OraScriptDeleteTriggers.SQL.Text;
      saveScriptOracle.SaveToFile('C:\sqlExportObjetos.txt', TEncoding.UTF8);
  finally
    saveScriptOracle.Free;
  end;


end;

function TScriptGenerator.GetScripts: string;
begin
  Result := OraScriptDeleteTriggers.SQL.Text;
end;

procedure TScriptGenerator.Executar;
begin
  if OraScriptDeleteTriggers.SQL.Count = 0 then
    raise Exception.Create('Nenhum script gerado para executar.');

  OraScriptDeleteTriggers.Execute;
end;

end.

