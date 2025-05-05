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
    Fqry_agendamento_cliente : TFDQuery;
    Fqry_agendamento_profissional : TFDQuery;

  public
    property Conexao :TFDConnection read FConexao write FConexao;
    property qry_agendamento_periodo : TFDQuery read Fqry_agendamento_periodo write Fqry_agendamento_periodo;
    property qry_agendamento_cliente : TFDQuery read Fqry_agendamento_cliente write Fqry_agendamento_cliente;
    property qry_agendamento_profissional : TFDQuery read Fqry_agendamento_profissional write Fqry_agendamento_profissional;

    constructor Create ( Conexao : TFDConnection );
    destructor destroy; override;

    procedure prc_agendamento_periodo( Inicio, Fim: TDate);
    procedure prc_agendamento_cliente( Inicio, Fim: TDate; codigo_cliente: Integer);
    procedure prc_agendamento_proifissional( Inicio, Fim: TDate; codigo_profissional: Integer);

  end;

implementation

{ TRelatorios }

constructor TRelatorios.Create(Conexao: TFDConnection);
begin
   FConexao := Conexao;

   Fqry_agendamento_periodo := TFDQuery.Create(nil);
   Fqry_agendamento_periodo.Connection :=  Conexao;

   Fqry_agendamento_cliente := TFDQuery.Create(nil);
   Fqry_agendamento_cliente.Connection :=  Conexao;

   Fqry_agendamento_profissional := TFDQuery.Create(nil);
   Fqry_agendamento_profissional.Connection :=  Conexao;

end;

destructor TRelatorios.destroy;
begin

  Fqry_agendamento_periodo.destroy;
  Fqry_agendamento_cliente.destroy;
  Fqry_agendamento_profissional.Destroy;

  inherited;
end;

procedure TRelatorios.prc_agendamento_cliente(Inicio, Fim: TDate;
  codigo_cliente: Integer);
begin
                ////////////////////////////////////
  with Fqry_agendamento_cliente do
  begin
    Close;
    SQL.Clear;

      SQL.Add('SELECT A.ID_AGENDAMENTO,                          ');
      SQL.Add('       A.CLI_ID_CLIENTE,                          ');
      SQL.Add('       C.DS_CLIENTE,                              ');
      SQL.Add('       P.ds_profissional,                         ');
      SQL.Add('       A.PRO_ID_PROFISSIONAL as id_profissional,  ');
      SQL.Add('       UPPER(concat(P.ds_profissional, ''  -  '', ');
      SQL.Add('       P.ds_especialidade))  as DS_PROFISSIONAL2, ');
      SQL.Add('       A.USU_ID_USUARIOS,                         ');
      SQL.Add('       U.DS_USUARIO,                              ');
      SQL.Add('       A.DT_DATA,                                 ');
      SQL.Add('       A.HR_HORA,                                 ');
      SQL.Add('       A.DS_OBS                                   ');
      SQL.Add('  FROM AGENDAMENTO A, CLIENTES C,                 ');
      SQL.Add('       PROFISSIONAIS P, USUARIOS U                ');
      SQL.Add(' WHERE A.cli_id_cliente = C.ID_CLIENTE            ');
      SQL.Add('   AND A.PRO_ID_PROFISSIONAL = p.id_profissional  ');
      SQL.Add('   AND A.USU_ID_USUARIOS = U.ID_USUARIOS          ');
      SQL.Add('   AND A.CLI_ID_CLIENTE  = :p_id_cliente          ');
      SQL.Add('   AND A.DT_DATA BETWEEN :Inicio AND :Fim         ');
      SQL.Add(' ORDER BY A.DT_DATA, A.HR_HORA                    ');

    ParamByName('Inicio').AsDate := Inicio;
    ParamByName('Fim').AsDate    := Fim;
    ParamByName('p_id_cliente').asinteger := codigo_cliente;
   Open;
  end;
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

procedure TRelatorios.prc_agendamento_proifissional(Inicio, Fim: TDate;
  codigo_profissional: Integer);
begin

  with Fqry_agendamento_profissional do
  begin
    Close;
    SQL.Clear;

      SQL.Add('SELECT A.ID_AGENDAMENTO,                              ');
      SQL.Add('       A.CLI_ID_CLIENTE,                              ');
      SQL.Add('       C.DS_CLIENTE,                                  ');
      SQL.Add('       P.ds_profissional,                             ');
      SQL.Add('       A.PRO_ID_PROFISSIONAL as id_profissional,      ');
      SQL.Add('       UPPER(concat(P.ds_profissional, ''  -  '',     ');
      SQL.Add('       P.ds_especialidade))  as DS_PROFISSIONAL2,     ');
      SQL.Add('       A.USU_ID_USUARIOS,                             ');
      SQL.Add('       U.DS_USUARIO,                                  ');
      SQL.Add('       A.DT_DATA,                                     ');
      SQL.Add('       A.HR_HORA,                                     ');
      SQL.Add('       A.DS_OBS                                       ');
      SQL.Add('  FROM AGENDAMENTO A, CLIENTES C,                     ');
      SQL.Add('       PROFISSIONAIS P, USUARIOS U                    ');
      SQL.Add(' WHERE A.cli_id_cliente = C.ID_CLIENTE                ');
      SQL.Add('   AND A.PRO_ID_PROFISSIONAL = p.id_profissional      ');
      SQL.Add('   AND A.USU_ID_USUARIOS = U.ID_USUARIOS              ');
      SQL.Add('   AND A.PRO_ID_PROFISSIONAL = :p_codigo_profissional ');
      SQL.Add('   AND A.DT_DATA BETWEEN :Inicio AND :Fim             ');
      SQL.Add(' ORDER BY A.DT_DATA, A.HR_HORA                        ');

    ParamByName('Inicio').AsDate := Inicio;
    ParamByName('Fim').AsDate    := Fim;
    ParamByName('p_codigo_profissional').asinteger := codigo_profissional;
   Open;
  end;

end;

end.
