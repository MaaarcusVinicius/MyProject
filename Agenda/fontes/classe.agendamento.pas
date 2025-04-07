unit classe.agendamento;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms, unit_funcoes;



  Type TAgendamento = class

    private
    FConexao            : TFDConnection;
    Fcli_id_cliente     : Integer;
    Fhr_hora            : string;
    Fpro_id_profissional: Integer;
    Fid_agendamento     : Integer;
    Fds_obs             : string;
    Fdt_data            : TDateTime;
    Fusu_id_usuarios    : Integer;

    public
      property  Conexao       :TFDConnection   read FConexao             write FConexao;
      property  id_agendamento      :Integer   read Fid_agendamento      write Fid_agendamento;
      property  cli_id_cliente      :Integer   read Fcli_id_cliente      write Fcli_id_cliente;
      property  pro_id_profissional :Integer   read Fpro_id_profissional write Fpro_id_profissional;
      property  usu_id_usuarios     :Integer   read Fusu_id_usuarios     write Fusu_id_usuarios;
      property  dt_data             :TDateTime read Fdt_data             write Fdt_data;
      property  hr_hora             :string    read Fhr_hora             write Fhr_hora;
      property  ds_obs              :string    read Fds_obs              write Fds_obs;


    constructor Create ( Conexao : TFDConnection );
    destructor destroy; override;
    function fnc_consulta(id_profissional: Integer; Data: TDateTime): TFDQuery;
    function fnc_validar_agendamento(id_profissional: Integer; Data: TDateTime; hr_hora: string): Boolean;

  end;

var
  QryConsulta : TFDQuery;

implementation

{ TAgendamento }

constructor TAgendamento.Create(Conexao: TFDConnection);
begin
   FConexao := Conexao;

   QryConsulta := TFDQuery.Create(nil);

   QryConsulta.Connection :=  FConexao;

end;

destructor TAgendamento.destroy;
begin
  QryConsulta.Destroy;
  inherited;
end;

function TAgendamento.fnc_consulta( id_profissional : Integer; Data: TDateTime) : TFDQuery;
begin

   FConexao.Connected := True;

   try

     QryConsulta.Close;
     QryConsulta.SQL.Clear;

      QryConsulta.SQL.Add('SELECT A.ID_AGENDAMENTO,                ');
      QryConsulta.SQL.Add('       A.CLI_ID_CLIENTE,                ');
      QryConsulta.SQL.Add('       C.DS_CLIENTE,                    ');
      QryConsulta.SQL.Add('       A.PRO_ID_PROFISSIONAL,           ');
      QryConsulta.SQL.Add('       A.USU_ID_USUARIOS,               ');
      QryConsulta.SQL.Add('       A.DT_DATA,                       ');
      QryConsulta.SQL.Add('       A.HR_HORA,                       ');
      QryConsulta.SQL.Add('       A.DS_OBS                         ');
      QryConsulta.SQL.Add('  FROM AGENDAMENTO A, CLIENTES C        ');
      QryConsulta.SQL.Add(' WHERE A.cli_id_cliente = C.ID_CLIENTE  ');
      QryConsulta.SQL.Add('   AND A.PRO_ID_PROFISSIONAL = :p_id_profissional  ');
      QryConsulta.SQL.Add('   AND A.DT_DATA             = :p_data             ');
      QryConsulta.SQL.Add(' ORDER BY A.HR_HORA                     ');

     QryConsulta.ParamByName('p_id_profissional').AsInteger := id_profissional;
     QryConsulta.ParamByName('p_data').AsDate               := Data;
     QryConsulta.Open;

   finally

     Result  := QryConsulta;

   end;



end;

function TAgendamento.fnc_validar_agendamento( id_profissional : Integer; Data: TDateTime; hr_hora: string ) : Boolean;
var
  QryValida : TFDQuery;

begin

   FConexao.Connected := True;

   try

     QryValida := TFDQuery.Create( nil );
     QryValida.Connection := FConexao;

     QryValida.Close;
     QryValida.SQL.Clear;

     QryValida.SQL.Add('SELECT A.ID_AGENDAMENTO                            ');
     QryValida.SQL.Add('  FROM AGENDAMENTO A                               ');
     QryValida.SQL.Add(' WHERE A.PRO_ID_PROFISSIONAL = :p_id_profissional  ');
     QryValida.SQL.Add('   AND A.DT_DATA             = :p_data             ');
     QryValida.SQL.Add('   AND A.hr_hora             = :p_hora             ');

     QryValida.ParamByName('p_id_profissional').AsInteger := id_profissional;
     QryValida.ParamByName('p_data').AsDate               := Data;
     QryValida.ParamByName('p_hora').AsString             := hr_hora;
     QryValida.Open;

     Result := QryValida.IsEmpty;

   finally

     QryValida.Destroy;

   end;



end;

end.
