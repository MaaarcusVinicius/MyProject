unit classe.empresas;

interface
uses
  Vcl.Forms, System.SysUtils, Ora;

Type
  TEmpresas = class

  private
    FQryEmpresas: TOraQuery;

  public
    property QryEmpresas : TOraQuery read  FQryEmpresas write FQryEmpresas;

    function fnc_consulta_empresas( CNPJ_EMPRESA: string): Boolean;
  end;

implementation

{ TEmpresas }

function TEmpresas.fnc_consulta_empresas(CNPJ_EMPRESA: string): Boolean;
begin

end;

end.
