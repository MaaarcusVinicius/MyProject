unit DataModuloOracle;

interface

uses
  System.SysUtils, System.Classes, OraCall, Data.DB, DBAccess, Ora;

type
  TSetOracle = class(TDataModule)
    OracleConexao: TOraSession;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetOracle: TSetOracle;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
