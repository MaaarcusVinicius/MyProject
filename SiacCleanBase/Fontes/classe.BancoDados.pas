unit Classe.BancoDados;

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

    // Configurações de LOG
    procedure EnableLog(const AFilePath: string);
    procedure DisableLog;

    // SQL base
    procedure SetSQL(const ASQL: string);
    procedure AddSQL(const ASQL: string);
    procedure AddWhere(const ACond: string);
    procedure AddDateBetween(const AField, AParamIni, AParamFim: string;
                             const ADataIni, ADataFim: TDateTime);

    procedure AddParam(const AParamName: string; const AValue: Variant);
    procedure ClearParams;

    // Execução
    procedure ExecutarConsulta; overload;
    procedure ExecutarComando;

    // Transações (NOVOS MÉTODOS)
    procedure IniciarTransacao;
    procedure ConfirmarTransacao;
    procedure CancelarTransacao;

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
    // Ignorar falhas de log silenciosamente
  end;
end;

procedure TClasseBancoDados.SetSQL(const ASQL: string);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(ASQL);
  Log('SQL definido: ' + ASQL);
end;

procedure TClasseBancoDados.AddSQL(const ASQL: string);
begin
  if FQuery.Active then
    FQuery.Close;

  FQuery.SQL.Add(ASQL);
  Log('SQL adicionado: ' + ASQL);
end;

procedure TClasseBancoDados.AddWhere(const ACond: string);
var
  HasWhere: Boolean;
  SQLText: string;
begin
  SQLText := UpperCase(FQuery.SQL.Text);
  HasWhere := Pos(' WHERE ', SQLText) > 0;

  if not HasWhere then
    AddSQL(' WHERE ' + ACond)
  else
    AddSQL('   AND ' + ACond);
end;

procedure TClasseBancoDados.AddDateBetween(const AField,
                                           AParamIni, AParamFim: string;
                                           const ADataIni, ADataFim: TDateTime);
begin
  if (ADataIni = 0) and (ADataFim = 0) then
    Exit;

  if (ADataIni <> 0) and (ADataFim <> 0) then
  begin
    AddWhere(Format('%s BETWEEN :%s AND :%s', [AField, AParamIni, AParamFim]));
    AddParam(AParamIni, ADataIni);
    AddParam(AParamFim, ADataFim);
  end
  else if (ADataIni <> 0) then
  begin
    AddWhere(Format('%s >= :%s', [AField, AParamIni]));
    AddParam(AParamIni, ADataIni);
  end
  else if (ADataFim <> 0) then
  begin
    AddWhere(Format('%s <= :%s', [AField, AParamFim]));
    AddParam(AParamFim, ADataFim);
  end;
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
  //FQuery.Params.ClearValues;
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

{ ============================ NOVOS MÉTODOS ============================ }

procedure TClasseBancoDados.IniciarTransacao;
begin
  if Assigned(FQuery.Session) and not FQuery.Session.InTransaction then
  begin
    FQuery.Session.StartTransaction;
    Log('Transação iniciada.');
  end;
end;

procedure TClasseBancoDados.ConfirmarTransacao;
begin
  if Assigned(FQuery.Session) and FQuery.Session.InTransaction then
  begin
    FQuery.Session.Commit;
    Log('Transação confirmada (commit).');
  end;
end;

procedure TClasseBancoDados.CancelarTransacao;
begin
  if Assigned(FQuery.Session) and FQuery.Session.InTransaction then
  begin
    FQuery.Session.Rollback;
    Log('Transação cancelada (rollback).');
  end;
end;

end.

