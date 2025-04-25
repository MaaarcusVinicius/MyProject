program Agenda;

uses
  Vcl.Forms,
  unit_principal in 'unit_principal.pas' {form_Principal},
  unit_login in 'unit_login.pas' {form_login},
  unit_mensagens in 'unit_mensagens.pas' {form_menssagens},
  unit_funcoes in 'unit_funcoes.pas',
  classe.conexao in 'classe.conexao.pas',
  unit_dados in 'unit_dados.pas' {form_dados: TDataModule},
  unit_configurarServidor in 'unit_configurarServidor.pas' {form_configurarServidor},
  System.SysUtils {form_configurarServidor},
  unit_agendamento in 'unit_agendamento.pas' {form_agendamento},
  unit_profissionais in 'unit_profissionais.pas' {form_profissionais},
  classe.profissionais in 'classe.profissionais.pas',
  uLoggerSingleton in 'uLoggerSingleton.pas' {/ unit_cliente_consulta in 'unit_cliente_consulta.pas' {form_cliente_consulta},
  unit_cliente_consulta in 'unit_cliente_consulta.pas' {form_cliente_consulta},
  unit_cliente_cadastro in 'unit_cliente_cadastro.pas' {form_cliente_cadastro},
  classe.clientes in 'classe.clientes.pas',
  classe.agendamento in 'classe.agendamento.pas',
  unit_agendamento_consulta in 'unit_agendamento_consulta.pas' {form_agendamento_consulta},
  unit_agenda in 'unit_agenda.pas' {form_agenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tform_dados, form_dados);

    //Application.CreateForm(Tform_agenda,form_agenda);

 // Application.CreateForm(Tform_agendamento_consulta, form_agendamento_consulta);
 // Application.CreateForm(Tform_Principal, form_Principal);
 // Application.CreateForm(Tform_cliente_cadastro, form_cliente_cadastro);
 // Application.CreateForm(Tform_cliente_consulta, form_cliente_consulta);
  if form_dados.Conexao.fnc_conectar_banco_dados then
     begin
       form_login := Tform_login.Create(nil);
       form_login.ShowModal;

       Application.CreateForm(Tform_Principal, form_Principal);

       form_login.Hide;
       form_login.Free;

       Application.Run;
     end
   else
     begin

      fnc_criar_menssagem('CONEXÃO AO BANCO DE DADOS',
                          'PROBLEMAS AO CONECTAR AO BANCO DE DADOS',
                          'Não foi possível conectar ao banco de dados, possível causa: ' +
                          form_dados.Conexao.MsgErro,
                          ExtractFilePath(Application.ExeName ) + '\icones\database_error.png',
                          'OK')  ;
      //Application.Terminate;
      Application.CreateForm(Tform_configurarServidor, form_configurarServidor);
      form_configurarServidor.ShowModal;

     end;

end.
