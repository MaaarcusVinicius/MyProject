unit DM;

interface

uses
  System.SysUtils, System.Classes, OraCall, Data.DB, DBAccess, Ora, MemDS;

type
  TDataModule3 = class(TDataModule)
    ds_oracle: TOraDataSource;
    qry_oracle: TOraQuery;
    qry_oracleEMPRESA_ID: TStringField;
    qry_oracleRAZAO_SOCIAL: TStringField;
    OraSession: TOraSession;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule3: TDataModule3;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
