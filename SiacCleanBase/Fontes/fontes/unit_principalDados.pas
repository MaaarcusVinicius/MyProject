unit unit_principalDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript, OraScript, Data.DB, DBAccess,
  Ora, MemDS, Vcl.Grids, Vcl.DBGrids;

type
  Tform_principalDados = class(TForm)
    ds_deletandoEmpresa: TOraDataSource;
    qry_deletandoEmpresas: TOraQuery;
    field_deletandoEmpresasSCRIPT: TStringField;
    OraScriptDeletandoEmpresa: TOraScript;
    dbGrid_QryEmpresas: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_principalDados: Tform_principalDados;

implementation

{$R *.dfm}

end.
