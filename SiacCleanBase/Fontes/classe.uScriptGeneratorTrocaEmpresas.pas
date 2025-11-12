unit classe.uScriptGeneratorTrocaEmpresas;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript,
  OraScript, Data.DB, DBAccess, Ora, OraSmart, MemDS, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, Classe.funcoes, Vcl.StdCtrls, Vcl.Mask;



type
  TScriptGeneratorTrocaEmpresa = class
  private
    qry_TrocaEmpresa: TOraQuery;
    OraScriptTrocaEmpresa: TOraScript;
  public
    constructor Create(AConnection: TOraSession);
    destructor Destroy; override;

    procedure Gerar(const OldEmpresa, NewEmpresa: string);
    function GetScripts: string;
    procedure Executar;
  end;

implementation

uses
  Principal, Classe.ConsultaEmpresa;

{ TScriptGeneratorTrocaEmpresa }

constructor TScriptGeneratorTrocaEmpresa.Create(AConnection: TOraSession);
begin
  qry_TrocaEmpresa := TOraQuery.Create(nil);
  qry_TrocaEmpresa.Session := AConnection;

  OraScriptTrocaEmpresa := TOraScript.Create(nil);
  OraScriptTrocaEmpresa.Session := AConnection;

  // SQL padrão já configurado direto no construtor
  qry_TrocaEmpresa.SQL.Text :=
      'SELECT ''UPDATE '' || C.TABLE_NAME ||'' SET '' || C.COLUMN_NAME ||'' = '' || :vEMPRESA_ID ||    '' WHERE '' || C.COLUMN_NAME ||'' = '' || :pEMPRESA_ID || '';'' AS SCRIPT '+
      '  FROM COLS C, USER_TABLES T '+
      ' WHERE C.TABLE_NAME = T.TABLE_NAME '+
      '   AND C.COLUMN_NAME IN (''EMPRESA_ID'', ''SIAC_EMPRESA_ID'',''EMPRESA_ALTERACAO'')  '+
      '   AND C.TABLE_NAME NOT IN (''EMPRESAS'',''PROMOCOES'') '+
      '   AND C.TABLE_NAME NOT LIKE ''%PARAMETRO%''  '+
      ' GROUP BY C.TABLE_NAME, C.COLUMN_NAME '+
      'UNION ALL '+
      'SELECT ''UPDATE '' || C.TABLE_NAME ||'' SET '' || C.COLUMN_NAME ||'' = '' || :vEMPRESA_ID ||    '' WHERE '' || C.COLUMN_NAME ||'' = '' || :pEMPRESA_ID || '';'' AS SCRIPT '+
      '  FROM COLS C, USER_TABLES T '+
      ' WHERE C.TABLE_NAME = T.TABLE_NAME '+
      '   AND C.COLUMN_NAME IN (''EMPRESA_ID'', ''SIAC_EMPRESA_ID'',''EMPRESA_ALTERACAO'')  '+
      '   AND C.TABLE_NAME NOT IN (''EMPRESAS'',''PROMOCOES'') '+
      '   AND C.TABLE_NAME LIKE ''%PARAMETRO%''  '+
      ' GROUP BY C.TABLE_NAME, C.COLUMN_NAME '+
      'UNION ALL '+
      'SELECT ''UPDATE '' || C.TABLE_NAME ||'' SET '' || C.COLUMN_NAME ||'' = '' || :vEMPRESA_ID ||    '' WHERE '' || C.COLUMN_NAME ||'' = '' || :pEMPRESA_ID || '';'' AS SCRIPT '+
      '  FROM COLS C, USER_TABLES T '+
      ' WHERE C.TABLE_NAME = T.TABLE_NAME '+
      '   AND C.COLUMN_NAME IN (''EMPRESA_ID'', ''SIAC_EMPRESA_ID'',''EMPRESA_ALTERACAO'')  '+
      '   AND C.TABLE_NAME IN (''EMPRESAS'') '+
      ' GROUP BY C.TABLE_NAME, C.COLUMN_NAME ';

end;

destructor TScriptGeneratorTrocaEmpresa.Destroy;
begin
  qry_TrocaEmpresa.Free;
  OraScriptTrocaEmpresa.Free;
  inherited;
end;

procedure TScriptGeneratorTrocaEmpresa.Gerar(const OldEmpresa, NewEmpresa: string);
var
  saveScriptOracle: TStringList;
begin
  saveScriptOracle := TStringList.Create;
  OraScriptTrocaEmpresa.SQL.Clear;

  qry_TrocaEmpresa.Close;
  if qry_TrocaEmpresa.Params.FindParam('pEMPRESA_ID') <> nil then
    qry_TrocaEmpresa.ParamByName('pEMPRESA_ID').AsString := OldEmpresa;
    qry_TrocaEmpresa.ParamByName('vEMPRESA_ID').AsString := NewEmpresa;

  qry_TrocaEmpresa.Open;

  qry_TrocaEmpresa.First;
  while not qry_TrocaEmpresa.Eof do
  begin
    OraScriptTrocaEmpresa.SQL.Add(qry_TrocaEmpresa.FieldByName('SCRIPT').AsString);
    qry_TrocaEmpresa.Next;
  end;

  try
      saveScriptOracle.Text := OraScriptTrocaEmpresa.SQL.Text;
      saveScriptOracle.SaveToFile('C:\sqlExportObjetos.txt', TEncoding.UTF8);
  finally
    saveScriptOracle.Free;
  end;


end;

function TScriptGeneratorTrocaEmpresa.GetScripts: string;
begin
  Result := OraScriptTrocaEmpresa.SQL.Text;
end;

procedure TScriptGeneratorTrocaEmpresa.Executar;
begin
  if OraScriptTrocaEmpresa.SQL.Count = 0 then
    raise Exception.Create('Nenhum script gerado para executar.');

  OraScriptTrocaEmpresa.Execute;
end;

end.

