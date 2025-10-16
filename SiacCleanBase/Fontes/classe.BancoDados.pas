unit classe.BancoDados;

interface

uses
  System.SysUtils, System.Classes, DAScript, OraScript,
  Data.DB, DBAccess, Ora, MemDS;

type
  TClasseBancoDados = class
 private
  qry_VerisonOracle: TOraQuery;

 public
  public
    constructor Create(AConnection: TOraSession);
    destructor Destroy; override;


  end;
implementation

{ TClasseBancoDados }

constructor TClasseBancoDados.Create(AConnection: TOraSession);
begin
  qry_VerisonOracle := TOraQuery.Create(nil);
  qry_VerisonOracle.Session := AConnection;

  qry_VerisonOracle.Session := AConnection;
end;

destructor TClasseBancoDados.Destroy;
begin
  qry_VerisonOracle.Destroy;
  inherited;
end;

end.
