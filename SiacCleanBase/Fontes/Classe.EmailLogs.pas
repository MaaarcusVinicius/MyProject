unit Classe.EmailLogs;

interface

uses
  System.SysUtils, System.IOUtils, Vcl.Dialogs, IdSMTP, IdMessage, IdSSLOpenSSL,
  IdSSL, IdGlobal, IdAttachmentFile, IdExplicitTLSClientServerBase,
  IdStack, IdStackWindows, Winapi.Windows, Vcl.Forms,
  uDataModule, System.Classes, IdComponent;

type
  TClasseEmailLogs = class
  private
    FSMTPHost: string;
    FSMTPPort: Integer;
    FUserName: string;
    FPassword: string;
    FFrom: string;
    FTo: string;
    FUseTLS: Boolean;

    procedure ConfigurarParametrosPadrao;
    procedure SMTPStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
  public
    constructor Create;
    destructor Destroy; override;

    procedure EnviarLog(const Assunto, Corpo: string);
    procedure EnviarLogOperacao(const NomeAcao: string);
  end;

implementation
uses
uViewMain;

{ ============================================================
  CONSTRUTOR / DESTRUTOR
  ============================================================ }
constructor TClasseEmailLogs.Create;
begin
  inherited Create;
  ConfigurarParametrosPadrao;
end;

destructor TClasseEmailLogs.Destroy;
begin
  inherited;
end;

{ ============================================================
  CONFIGURA PARÂMETROS PADRÃO (HARD-CODE)
  ============================================================ }
procedure TClasseEmailLogs.ConfigurarParametrosPadrao;
begin
  // 🔹 Configurações de SMTP fixas (KingHost)
  FSMTPHost := 'smtp.kinghost.net';
  FSMTPPort := 587; // Porta TLS recomendada
  FUserName := 'cliente@siacsistemas.com.br';
  FPassword := 'Siac@123';
  FFrom := 'cliente@siacsistemas.com.br';
  FTo := 'suporte@gruposiac.com.br;implantacao@gruposiac.com.br;ti@gruposiac.com.br';
  FUseTLS := True; // KingHost exige STARTTLS
end;

{ ============================================================
  EVENTO DE STATUS DO SMTP (LOG OPCIONAL)
  ============================================================ }
procedure TClasseEmailLogs.SMTPStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  OutputDebugString(PChar('SMTP: ' + AStatusText));

  // Opcional: grava log local de depuração
  try
    TFile.AppendAllText(ExtractFilePath(ParamStr(0)) + 'Email_Debug.txt',
      FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + AStatusText + sLineBreak,
      TEncoding.UTF8);
  except
    // ignora erro de log
  end;
end;

{ ============================================================
  ENVIA O E-MAIL DE LOG DETALHADO
  ============================================================ }
procedure TClasseEmailLogs.EnviarLog(const Assunto, Corpo: string);
var
  SMTP: TIdSMTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Msg: TIdMessage;
  InfoSistema: string;
  IPLocal, EmpresaID, RazaoSocial, VersaoWindows: string;
  UsuarioBanco, ServidorBanco: string;
  FuncionarioId, FuncionarioNome: string;
begin
  SMTP := TIdSMTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Msg := TIdMessage.Create(nil);
  try
    try
      // 🔹 IP local
      try
        IPLocal := GStack.LocalAddress;
      except
        IPLocal := 'Não identificado';
      end;

      // 🔹 Versão do Windows
      try
        VersaoWindows := Trim(GetEnvironmentVariable('OS'));
        if VersaoWindows = '' then
          VersaoWindows := 'Não identificada';
      except
        VersaoWindows := 'Não identificada';
      end;

      // 🔹 Empresa
      if Trim(vGbl_Empresa_id) <> '' then
        EmpresaID := vGbl_Empresa_id
      else
        EmpresaID := 'Não definida';

      if Trim(vGbl_RazaoSocial) <> '' then
        RazaoSocial := vGbl_RazaoSocial
      else
        RazaoSocial := 'Não definida';

      // 🔹 Dados Oracle
      if Assigned(DmModule) and Assigned(DmModule.orsConexao) then
      begin
        UsuarioBanco := DmModule.orsConexao.Username;
        ServidorBanco := DmModule.orsConexao.Server;
      end
      else
      begin
        UsuarioBanco := 'Não conectado';
        ServidorBanco := 'Não definido';
      end;

      // 🔹 Dados do funcionário (vindos do login)
      if Trim(vGbl_FuncionarioId) <> '' then
        FuncionarioId := vGbl_FuncionarioId
      else
        FuncionarioId := 'Não definido';

      if Trim(vGbl_FuncionarioNome) <> '' then
        FuncionarioNome := vGbl_FuncionarioNome
      else
        FuncionarioNome := 'Não definido';

      // 🔹 Corpo HTML do e-mail
      InfoSistema :=
        '<html><body style="font-family:Segoe UI; font-size:10pt;">' +

        '<h3 style="color:#2E86C1;">Informações de Execução</h3>' +
        '<p><b>Data/Hora:</b> ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '</p>' +

        '<h3 style="color:#2E86C1;">Dados do Funcionário</h3>' +
        '<p><b>Matrícula:</b> ' + FuncionarioId + '<br>' +
        '<b>Nome:</b> ' + FuncionarioNome + '</p>' +

        '<h3 style="color:#2E86C1;">Dados Empresariais</h3>' +
        '<p><b>Empresa ID:</b> ' + EmpresaID + '<br>' +
        '<b>Razão Social:</b> ' + RazaoSocial + '</p>' +

        '<h3 style="color:#2E86C1;">Dados da Máquina</h3>' +
        '<p><b>Usuário do Windows:</b> ' + GetEnvironmentVariable('USERNAME') + '<br>' +
        '<b>Computador:</b> ' + GetEnvironmentVariable('COMPUTERNAME') + '<br>' +
        '<b>Endereço IP Local:</b> ' + IPLocal + '<br>' +
        '<b>Versão do Windows:</b> ' + VersaoWindows + '</p>' +

        '<h3 style="color:#2E86C1;">Dados da Oracle</h3>' +
        '<p><b>Usuário Oracle:</b> ' + UsuarioBanco + '<br>' +
        '<b>Servidor Oracle:</b> ' + ServidorBanco + '</p>' +

        '<hr><p><i>Mensagem automática gerada pelo sistema SiacDBManager.</i></p>' +
        '</body></html>';

      // 🔹 Configuração SSL
      SSL.Host := FSMTPHost;
      SSL.Port := FSMTPPort;
      SSL.SSLOptions.Method := sslvTLSv1_2;
      SSL.SSLOptions.Mode := sslmClient;

      // 🔹 Configuração SMTP
      SMTP.IOHandler := SSL;
      SMTP.Host := FSMTPHost;
      SMTP.Port := FSMTPPort;
      SMTP.Username := FUserName;
      SMTP.Password := FPassword;
      SMTP.UseTLS := utUseExplicitTLS;
      SMTP.AuthType := satDefault;

      // 🔹 Monta a mensagem
      Msg.ContentType := 'text/html';
      Msg.CharSet := 'utf-8';
      Msg.From.Address := FUserName;
      Msg.From.Name := 'SIAC Sistemas - Log Automático';
      Msg.Recipients.EmailAddresses := FTo;
      Msg.Subject := Assunto;
      Msg.Body.Text := Corpo + sLineBreak + InfoSistema;

      // 🔹 Envia o e-mail
      SMTP.ConnectTimeout := 15000;
      SMTP.ReadTimeout := 15000;
      SMTP.Connect;

      try
        if SMTP.Connected then
        begin
          SMTP.Send(Msg);
         // MessageDlg('E-mail enviado com sucesso para: ' + FTo, mtInformation, [mbOK], 0);
        end
        else
         // MessageDlg('Falha ao conectar ao servidor SMTP.', mtError, [mbOK], 0);
      finally
        if SMTP.Connected then
          SMTP.Disconnect;
      end;

    except
      on E: Exception do
      begin
        MessageDlg('Falha ao enviar e-mail: ' + E.Message, mtError, [mbOK], 0);
        TFile.AppendAllText(ExtractFilePath(ParamStr(0)) + 'Email_Erro.txt',
          FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ERRO: ' + E.Message + sLineBreak,
          TEncoding.UTF8);
      end;
    end;
  finally
    Msg.Free;
    SSL.Free;
    SMTP.Free;
  end;
end;

{ ============================================================
  NOVO: ENVIO SIMPLIFICADO DE LOG DE OPERAÇÃO
  ============================================================ }
procedure TClasseEmailLogs.EnviarLogOperacao(const NomeAcao: string);
var
  Assunto, Corpo: string;
begin
  // 🔹 Monta assunto padrão com data/hora
  Assunto := Format('[SIAC LOG] %s executada em %s',
    [NomeAcao, FormatDateTime('dd/mm/yyyy hh:nn', Now)]);

  // 🔹 Corpo do e-mail padronizado
  Corpo :=
    Format('A rotina "%s" foi executada com sucesso.' + sLineBreak + sLineBreak +
           'Este é um registro automático do sistema Siac DBManager.' + sLineBreak +
           'Nenhuma ação do usuário é necessária.' + sLineBreak,
           [NomeAcao]);

  // 🔹 Chama o método principal
  EnviarLog(Assunto, Corpo);
end;

end.

