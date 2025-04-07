unit Unit_DM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Ora, OraCall,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    conexao: TOraSession;
    Tqry_CadClientes: TOraQuery;
    dt_qry_CadClientes: TDataSource;
    Tqry_CadClientesTIPO_CADASTRO: TStringField;
    Tqry_CadClientesNOME_CLIENTE: TStringField;
    Tqry_CadClientesRAZAO_SOCIAL: TStringField;
    Tqry_CadClientesESTADO_CIVIL: TStringField;
    Tqry_CadClientesOBSERVACOES_CADASTRAIS: TStringField;
    Tqry_CadClientesENDERECO: TStringField;
    Tqry_CadClientesCEP: TIntegerField;
    Tqry_CadClientesBAIRRO: TStringField;
    Tqry_CadClientesCIDADE: TStringField;
    Tqry_CadClientesEND_OBSERVACOES: TStringField;
    Tqry_CadClientesATIVO: TStringField;
    Tqry_CadClientesDT_CADASTRO: TDateTimeField;
    Tqry_CadClientesID: TFloatField;
    FDTable1: TFDTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
