unit classe.agendamento;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms, unit_funcoes,
  Datasnap.DBClient;



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
    function fnc_consulta_por_cliente(nome_cliente: string): TFDQuery;
    function fnc_validar_agendamento(id_profissional: Integer; Data: TDateTime; hr_hora: string): Boolean;
    function fnc_inserir: string;
    procedure fnc_montar_agenda( dt_data: TDate;  cds_agenda: TClientDataSet );

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

      QryConsulta.SQL.Add('SELECT A.ID_AGENDAMENTO,                          ');
      QryConsulta.SQL.Add('       A.CLI_ID_CLIENTE,                          ');
      QryConsulta.SQL.Add('       C.DS_CLIENTE,                              ');
      QryConsulta.SQL.Add('       P.ds_profissional,                         ');
      QryConsulta.SQL.Add('       A.PRO_ID_PROFISSIONAL as id_profissional,  ');
      QryConsulta.SQL.Add('       UPPER(concat(P.ds_profissional, ''  -  '', ');
      QryConsulta.SQL.Add('       P.ds_especialidade))  as DS_PROFISSIONAL2, ');
      QryConsulta.SQL.Add('       A.USU_ID_USUARIOS,                         ');
      QryConsulta.SQL.Add('       A.DT_DATA,                                 ');
      QryConsulta.SQL.Add('       A.HR_HORA,                                 ');
      QryConsulta.SQL.Add('       A.DS_OBS                                   ');
      QryConsulta.SQL.Add('  FROM AGENDAMENTO A, CLIENTES C, profissionais p ');
      QryConsulta.SQL.Add(' WHERE A.cli_id_cliente = C.ID_CLIENTE            ');
      QryConsulta.SQL.Add('   AND A.PRO_ID_PROFISSIONAL = p.id_profissional  ');
      QryConsulta.SQL.Add('   AND A.PRO_ID_PROFISSIONAL = :p_id_profissional ');
      QryConsulta.SQL.Add('   AND A.DT_DATA             = :p_data            ');
      QryConsulta.SQL.Add(' ORDER BY A.HR_HORA                               ');

     QryConsulta.ParamByName('p_id_profissional').AsInteger := id_profissional;
     QryConsulta.ParamByName('p_data').AsDate               := Data;
     QryConsulta.Open;

   finally

     Result  := QryConsulta;

   end;

end;

function TAgendamento.fnc_consulta_por_cliente( nome_cliente : string) : TFDQuery;
begin

   FConexao.Connected := True;

   try

     QryConsulta.Close;
     QryConsulta.SQL.Clear;

      QryConsulta.SQL.Add('SELECT A.ID_AGENDAMENTO,                          ');
      QryConsulta.SQL.Add('       A.CLI_ID_CLIENTE,                          ');
      QryConsulta.SQL.Add('       C.DS_CLIENTE,                              ');
      QryConsulta.SQL.Add('       A.PRO_ID_PROFISSIONAL,                     ');
      QryConsulta.SQL.Add('       A.USU_ID_USUARIOS,                         ');
      QryConsulta.SQL.Add('       P.ds_profissional,                         ');
      QryConsulta.SQL.Add('       A.DT_DATA,                                 ');
      QryConsulta.SQL.Add('       A.HR_HORA,                                 ');
      QryConsulta.SQL.Add('       A.DS_OBS                                   ');
      QryConsulta.SQL.Add('  FROM AGENDAMENTO A, CLIENTES C, profissionais p ');
      QryConsulta.SQL.Add(' WHERE A.cli_id_cliente = C.ID_CLIENTE            ');
      QryConsulta.SQL.Add('   AND A.PRO_ID_PROFISSIONAL = p.id_profissional  ');
      QryConsulta.SQL.Add('   AND C.DS_CLIENTE like :p_nome_cliente          ');
      QryConsulta.SQL.Add(' ORDER BY C.DS_CLIENTE                            ');

     QryConsulta.ParamByName('p_nome_cliente').AsString :=  '%' + nome_cliente + '%';

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

function TAgendamento.fnc_inserir: string;
var
  QryInserir : TFDQuery;

begin
  try

    try

      FConexao.Connected := False;
      FConexao.Connected := True;

      QryInserir := TFDQuery.Create ( nil );
      QryInserir.Connection := FConexao;

      QryInserir.Close;
      QryInserir.SQL.Clear;
      QryInserir.SQL.Add('insert into agendamento           ');
      QryInserir.SQL.Add('           (id_Agendamento,       ');
      QryInserir.SQL.Add('            cli_id_cliente,       ');
      QryInserir.SQL.Add('            pro_id_profissional,  ');
      QryInserir.SQL.Add('            usu_id_usuarios,      ');
      QryInserir.SQL.Add('            dt_data,              ');
      QryInserir.SQL.Add('            hr_hora,              ');
      QryInserir.SQL.Add('            ds_obs)               ');
      QryInserir.SQL.Add('     values(:id_agendamento,      ');
      QryInserir.SQL.Add('            :cli_id_cliente,      ');
      QryInserir.SQL.Add('            :pro_id_profissional, ');
      QryInserir.SQL.Add('            :usu_id_usuarios,     ');
      QryInserir.SQL.Add('            :dt_data,             ');
      QryInserir.SQL.Add('            :hr_hora,             ');
      QryInserir.SQL.Add('            :ds_obs)              ');

      QryInserir.ParamByName('id_Agendamento').AsInteger      := fnc_proximo_codigo('agendamento', 'id_Agendamento') ;
      QryInserir.ParamByName('cli_id_cliente').AsInteger      := Fcli_id_cliente;
      QryInserir.ParamByName('pro_id_profissional').AsInteger := Fpro_id_profissional;
      QryInserir.ParamByName('usu_id_usuarios').AsInteger     := 1;
      QryInserir.ParamByName('dt_data').AsDate                := Fdt_data;
      QryInserir.ParamByName('hr_hora').AsString              := Fhr_hora;
      QryInserir.ParamByName('ds_obs').AsString               := Fds_obs;

      QryInserir.ExecSQL;

      Result := '' ;

     except

       On E: Exception Do
           Result := E.message;

    end;

  finally

    QryInserir.Destroy;

  end;

end;

procedure TAgendamento.fnc_montar_agenda(dt_data: TDate; cds_agenda: TClientDataSet);
var
  I ,Minutos, Hora : Word;

begin

   Minutos := 0;

   for Hora := 8 to 18 do
   begin
     for I := 0 to 3 do
     begin

       cds_agenda.Append;
       cds_agenda.FieldByName('dt_data').AsDateTime := dt_data;
       cds_agenda.FieldByName('hr_hora').AsString := FormatFloat('00',Hora) + ':' + FormatFloat('00',Minutos);

       cds_agenda.Post;

       Minutos := Minutos + 15;

     end;

     Minutos := 0 ;

   end;


end;

end.
