unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, DBAccess, OraTransaction, Data.DB, Ora,
  OraCall;

type
  TDmModule = class(TDataModule)
    orsConexao: TOraSession;
    ortConexao: TOraTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
    function ConectarBd(vUser,vPassword,vServer : string) : Boolean;
    function DesconectarBd : Boolean;
  end;

var
  DmModule: TDmModule;

implementation

uses
  Principal, _Biblioteca, VarGlobal;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmModule }

function TDmModule.ConectarBd(vUser, vPassword, vServer: string): Boolean;
begin
  try
    // Origem
    orsConexao.Username := vUser;
    orsConexao.Password :=vPassword;
    orsConexao.Server := vServer;
    orsConexao.Options.Direct := True;
    orsConexao.Connected := True;

    VarGlobal._QRepositorio := TOraQuery.Create(nil);
    _QRepositorio.Session   := orsConexao;

    RESULT := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;
function TDmModule.DesconectarBd: Boolean;
begin
  try
    if orsConexao.Connected then orsConexao.Disconnect;
    Result := true;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

end.
