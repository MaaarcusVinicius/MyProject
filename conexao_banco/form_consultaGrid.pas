unit form_consultaGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Ora,
  DBAccess;

type
  TConsultaGrid = class(TForm)
    dbgrd_oracle: TDBGrid;
    OraDataSource: TOraDataSource;

  private
    { Private declarations }
    FqryConsulta: TOraQuery;

  public
    { Public declarations }
    property QryConsulta : TOraQuery  read FqryConsulta write FqryConsulta;


    constructor Create( Conexao : TOraSession);
    destructor Destroy; override;



  end;

var
  ConsultaGrid: TConsultaGrid;

implementation

{$R *.dfm}

{ TForm2 }

constructor TConsultaGrid.Create(Conexao: TOraSession);
begin
end;

destructor TConsultaGrid.Destroy;
begin
   QryConsulta.destroy;
  inherited;
end;

end.
