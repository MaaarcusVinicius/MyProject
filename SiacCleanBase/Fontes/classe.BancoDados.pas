unit classe.BancoDados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Ora, MemDS,
  uDataModule, Vcl.Dialogs;

type
  TClasseBancoDados = class
  private
    FQuery: TOraQuery;
    FDataSource: TDataSource;
    FLogEnabled: Boolean;
    FLogFile: string;

    procedure Log(const AMsg: string);
  public
    constructor Create(AConnection: TOraSession);
    destructor Destroy; override;

    // Configurações
    procedure EnableLog(const AFilePath: string);
    procedure DisableLog;

    // Métodos principais
    procedure SetSQL(const ASQL: string);
    procedure AddParam(const AParamName: string; const AValue: Variant);
    procedure ClearParams;

    // Execuções
    procedure ExecutarConsulta;          // SELECT
    procedure ExecutarComando;           // INSERT / UPDATE / DELETE

    // Acesso a dados
    function GetDataSource: TDataSource;
    function GetQuery: TOraQuery;
  end;

implementation

{ TClasseBancoDados }

constructor TClasseBancoDados.Create(AConnection: TOraSession);
begin
  FQuery := TOraQuery.Create(nil);
  FQuery.Session := AConnection;

  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := FQuery;
end;

destructor TClasseBancoDados.Destroy;
begin
  FQuery.Free;
  FDataSource.Free;
  inherited;
end;

procedure TClasseBancoDados.EnableLog(const AFilePath: string);
begin
  FLogEnabled := True;
  FLogFile := AFilePath;
end;

procedure TClasseBancoDados.DisableLog;
begin
  FLogEnabled := False;
end;

procedure TClasseBancoDados.Log(const AMsg: string);
var
  LFile: TextFile;
begin
  if not FLogEnabled then Exit;

  try
    AssignFile(LFile, FLogFile);
    if FileExists(FLogFile) then
      Append(LFile)
    else
      Rewrite(LFile);

    Writeln(LFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + AMsg);
    CloseFile(LFile);
  except
    // Em caso de falha no log, apenas ignora
    ShowMessage('erro log exec Sql');
  end;
end;

procedure TClasseBancoDados.SetSQL(const ASQL: string);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(ASQL);
  Log('SQL definido: ' + ASQL);
end;

procedure TClasseBancoDados.AddParam(const AParamName: string; const AValue: Variant);
begin
  if FQuery.Params.FindParam(AParamName) <> nil then
    FQuery.ParamByName(AParamName).Value := AValue
  else
    Log('Parâmetro não encontrado: ' + AParamName);
end;

procedure TClasseBancoDados.ClearParams;
begin
 // FQuery.Params.ClearValues;
end;

procedure TClasseBancoDados.ExecutarConsulta;
begin
  try
    FQuery.Close;
    FQuery.Open;
    Log('Consulta executada com sucesso');

  except
    on E: Exception do
    begin
      Log('Erro ao executar consulta: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TClasseBancoDados.ExecutarComando;
begin
  try
    FQuery.ExecSQL;
    Log('Comando executado com sucesso');
  except
    on E: Exception do
    begin
      Log('Erro ao executar comando: ' + E.Message);
      raise;
    end;
  end;
end;

function TClasseBancoDados.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TClasseBancoDados.GetQuery: TOraQuery;
begin
  Result := FQuery;
end;

end.

