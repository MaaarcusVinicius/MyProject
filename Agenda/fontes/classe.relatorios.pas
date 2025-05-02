unit classe.relatorios;

interface
uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms, unit_funcoes,
  Datasnap.DBClient;

type
  TRelatorios = Class

  private
    FConexao : TFDConnection;
    Fqry_agendamento_periodo : TFDQuery;

  public
    property Conexao :TFDConnection read FConexao write FConexao;
    property qry_agendamento_periodo : TFDQuery read Fqry_agendamento_periodo write Fqry_agendamento_periodo;

    constructor Create ( Conexao : TFDConnection );
    destructor destroy; override;

    procedure prc_agendamento_periodo( Inicio, Fim: TDate);

  end;

implementation

{ TRelatorios }

constructor TRelatorios.Create(Conexao: TFDConnection);
begin
   FConexao := Conexao;

   Fqry_agendamento_periodo := TFDQuery.Create(nil);
   Fqry_agendamento_periodo.Connection :=  Conexao;
end;

destructor TRelatorios.destroy;
begin

  Fqry_agendamento_periodo.destroy;

  inherited;
end;

procedure TRelatorios.prc_agendamento_periodo(Inicio, Fim: TDate);
begin
  Fqry_agendamento_periodo.Close;
  Fqry_agendamento_periodo.SQL.Clear;


    Fqry_agendamento_periodo.SQL.Add('SELECT A.ID_AGENDAMENTO,                          ');
    Fqry_agendamento_periodo.SQL.Add('       A.CLI_ID_CLIENTE,                          ');
    Fqry_agendamento_periodo.SQL.Add('       C.DS_CLIENTE,                              ');
    Fqry_agendamento_periodo.SQL.Add('       P.ds_profissional,                         ');
    Fqry_agendamento_periodo.SQL.Add('       A.PRO_ID_PROFISSIONAL as id_profissional,  ');
    Fqry_agendamento_periodo.SQL.Add('       UPPER(concat(P.ds_profissional, ''  -  '', ');
    Fqry_agendamento_periodo.SQL.Add('       P.ds_especialidade))  as DS_PROFISSIONAL2, ');
    Fqry_agendamento_periodo.SQL.Add('       A.USU_ID_USUARIOS,                         ');
    Fqry_agendamento_periodo.SQL.Add('       U.DS_USUARIO,                              ');
    Fqry_agendamento_periodo.SQL.Add('       A.DT_DATA,                                 ');
    Fqry_agendamento_periodo.SQL.Add('       A.HR_HORA,                                 ');
    Fqry_agendamento_periodo.SQL.Add('       A.DS_OBS                                   ');
    Fqry_agendamento_periodo.SQL.Add('  FROM AGENDAMENTO A, CLIENTES C,                 ');
    Fqry_agendamento_periodo.SQL.Add('       PROFISSIONAIS P, USUARIOS U                ');
    Fqry_agendamento_periodo.SQL.Add(' WHERE A.cli_id_cliente = C.ID_CLIENTE            ');
    Fqry_agendamento_periodo.SQL.Add('   AND A.PRO_ID_PROFISSIONAL = p.id_profissional  ');
    Fqry_agendamento_periodo.SQL.Add('   AND A.USU_ID_USUARIOS = U.ID_USUARIOS          ');
    Fqry_agendamento_periodo.SQL.Add('   AND A.DT_DATA BETWEEN :Inicio AND :Fim         ');
    Fqry_agendamento_periodo.SQL.Add(' ORDER BY A.DT_DATA, A.HR_HORA                    ');

 Fqry_agendamento_periodo.ParamByName('Inicio').AsDate := Inicio;
 Fqry_agendamento_periodo.ParamByName('Fim').AsDate       := Fim;
 Fqry_agendamento_periodo.Open;


end;

end.
