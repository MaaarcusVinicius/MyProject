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
  //  FTo := 'maaarcus.vinicius@gmail.com';    // Modo Debug
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
//procedure TClasseEmailLogs.EnviarLog(const Assunto, Corpo: string);
//var
//  SMTP: TIdSMTP;
//  SSL: TIdSSLIOHandlerSocketOpenSSL;
//  Msg: TIdMessage;
//  InfoSistema: string;
//  IPLocal, EmpresaID, RazaoSocial, VersaoWindows: string;
//  UsuarioBanco, ServidorBanco: string;
//  FuncionarioId, FuncionarioNome: string;
//begin
//  SMTP := TIdSMTP.Create(nil);
//  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
//  Msg := TIdMessage.Create(nil);
//  try
//    try
//      //  IP local
//      try
//        IPLocal := GStack.LocalAddress;
//      except
//        IPLocal := 'Não identificado';
//      end;
//
//      //  Versão do Windows
//      try
//        VersaoWindows := Trim(GetEnvironmentVariable('OS'));
//        if VersaoWindows = '' then
//          VersaoWindows := 'Não identificada';
//      except
//        VersaoWindows := 'Não identificada';
//      end;
//
//      //  Empresa
//      if Trim(vGbl_Empresa_id) <> '' then
//        EmpresaID := vGbl_Empresa_id
//      else
//        EmpresaID := 'Não definida';
//
//      if Trim(vGbl_RazaoSocial) <> '' then
//        RazaoSocial := vGbl_RazaoSocial
//      else
//        RazaoSocial := 'Não definida';
//
//      //  Dados Oracle
//      if Assigned(DmModule) and Assigned(DmModule.orsConexao) then
//      begin
//        UsuarioBanco := DmModule.orsConexao.Username;
//        ServidorBanco := DmModule.orsConexao.Server;
//      end
//      else
//      begin
//        UsuarioBanco := 'Não conectado';
//        ServidorBanco := 'Não definido';
//      end;
//
//      //  Dados do funcionário (vindos do login)
//      if Trim(vGbl_FuncionarioId) <> '' then
//        FuncionarioId := vGbl_FuncionarioId
//      else
//        FuncionarioId := 'Não definido';
//
//      if Trim(vGbl_FuncionarioNome) <> '' then
//        FuncionarioNome := vGbl_FuncionarioNome
//      else
//        FuncionarioNome := 'Não definido';
//
//      //  Corpo HTML do e-mail
//      InfoSistema :=
//        '<html><body style="font-family:Segoe UI; font-size:10pt;">' +
//
//        '<h3 style="color:#2E86C1;">Informações de Execução</h3>' +
//        '<p><b>Data/Hora:</b> ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '</p>' +
//
//        '<h3 style="color:#2E86C1;">Dados do Funcionário</h3>' +
//        '<p><b>Matrícula:</b> ' + FuncionarioId + '<br>' +
//        '<b>Nome:</b> ' + FuncionarioNome + '</p>' +
//
//        '<h3 style="color:#2E86C1;">Dados Empresariais</h3>' +
//        '<p><b>Empresa ID:</b> ' + EmpresaID + '<br>' +
//        '<b>Razão Social:</b> ' + RazaoSocial + '</p>' +
//
//        '<h3 style="color:#2E86C1;">Dados da Máquina</h3>' +
//        '<p><b>Usuário do Windows:</b> ' + GetEnvironmentVariable('USERNAME') + '<br>' +
//        '<b>Computador:</b> ' + GetEnvironmentVariable('COMPUTERNAME') + '<br>' +
//        '<b>Endereço IP Local:</b> ' + IPLocal + '<br>' +
//        '<b>Versão do Windows:</b> ' + VersaoWindows + '</p>' +
//
//        '<h3 style="color:#2E86C1;">Dados da Oracle</h3>' +
//        '<p><b>Usuário Oracle:</b> ' + UsuarioBanco + '<br>' +
//        '<b>Servidor Oracle:</b> ' + ServidorBanco + '</p>' +
//
//        '<hr><p><i>Mensagem automática gerada pelo sistema SiacDBManager.</i></p>' +
//        '</body></html>';
//
//      //  Configuração SSL
//      SSL.Host := FSMTPHost;
//      SSL.Port := FSMTPPort;
//      SSL.SSLOptions.Method := sslvTLSv1_2;
//      SSL.SSLOptions.Mode := sslmClient;
//
//      //  Configuração SMTP
//      SMTP.IOHandler := SSL;
//      SMTP.Host := FSMTPHost;
//      SMTP.Port := FSMTPPort;
//      SMTP.Username := FUserName;
//      SMTP.Password := FPassword;
//      SMTP.UseTLS := utUseExplicitTLS;
//      SMTP.AuthType := satDefault;
//
//      //  Monta a mensagem
//      Msg.ContentType := 'text/html';
//      Msg.CharSet := 'utf-8';
//      Msg.From.Address := FUserName;
//      Msg.From.Name := 'SIAC Sistemas - Log Automático';
//      Msg.Recipients.EmailAddresses := FTo;
//      Msg.Subject := Assunto;
//      Msg.Body.Text := Corpo + sLineBreak + InfoSistema;
//
//      //  Envia o e-mail
//      SMTP.ConnectTimeout := 15000;
//      SMTP.ReadTimeout := 15000;
//      SMTP.Connect;
//
//      try
//        if SMTP.Connected then
//        begin
//          SMTP.Send(Msg);
//         // MessageDlg('E-mail enviado com sucesso para: ' + FTo, mtInformation, [mbOK], 0);
//        end
//        else
//         // MessageDlg('Falha ao conectar ao servidor SMTP.', mtError, [mbOK], 0);
//      finally
//        if SMTP.Connected then
//          SMTP.Disconnect;
//      end;
//
//    except
//      on E: Exception do
//      begin
//        MessageDlg('Falha ao enviar e-mail: ' + E.Message, mtError, [mbOK], 0);
//        TFile.AppendAllText(ExtractFilePath(ParamStr(0)) + 'Email_Erro.txt',
//          FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ERRO: ' + E.Message + sLineBreak,
//          TEncoding.UTF8);
//      end;
//    end;
//  finally
//    Msg.Free;
//    SSL.Free;
//    SMTP.Free;
//  end;
//end;
             // -- Versão 2.0 do Email  -- //
procedure TClasseEmailLogs.EnviarLog(const Assunto, Corpo: string);
var
  SMTP: TIdSMTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Msg: TIdMessage;
  InfoSistema: string;
  IPLocal, EmpresaID, RazaoSocial, VersaoWindows: string;
  UsuarioBanco, ServidorBanco: string;
  FuncionarioId, FuncionarioNome: string;
  vHTML: TStringList;
begin
  SMTP := TIdSMTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Msg := TIdMessage.Create(nil);
  vHTML := TStringList.Create;
  try
    try
      //  IP local
      try
        IPLocal := GStack.LocalAddress;
      except
        IPLocal := 'Não identificado';
      end;

      //  Versão do Windows
      try
        VersaoWindows := Trim(GetEnvironmentVariable('OS'));
        if VersaoWindows = '' then
          VersaoWindows := 'Não identificada';
      except
        VersaoWindows := 'Não identificada';
      end;

      //  Empresa
      if Trim(vGbl_Empresa_id) <> '' then
        EmpresaID := vGbl_Empresa_id
      else
        EmpresaID := 'Não definida';

      if Trim(vGbl_RazaoSocial) <> '' then
        RazaoSocial := vGbl_RazaoSocial
      else
        RazaoSocial := 'Não definida';

      //  Dados Oracle
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

      //  Dados do funcionário (vindos do login)
      if Trim(vGbl_FuncionarioId) <> '' then
        FuncionarioId := vGbl_FuncionarioId
      else
        FuncionarioId := 'Não definido';

      if Trim(vGbl_FuncionarioNome) <> '' then
        FuncionarioNome := vGbl_FuncionarioNome
      else
        FuncionarioNome := 'Não definido';

      // ==========================================================
      //  Corpo HTML do e-mail (estrutura moderna)
      // ==========================================================
      vHTML.Add('<html lang="pt-br">');
      vHTML.Add('<head>');
      vHTML.Add('  <meta charset="utf-8" />');
      vHTML.Add('  <meta name="viewport" content="width=device-width, initial-scale=1.0" />');
      vHTML.Add('  <title>Siac DbManager - Log de Operação</title>');
      vHTML.Add('  <style>');
      vHTML.Add('    body { font-family: "Segoe UI", sans-serif; background-color: #f4f6f8; color: #333; margin: 0; padding: 20px; }');
      vHTML.Add('    .content { max-width: 700px; margin: auto; background: #ffffff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); overflow: hidden; }');
      vHTML.Add('    .header { background-color: #003366; color: white; text-align: center; padding: 20px; }');
      vHTML.Add('    .header h2 { margin: 0; font-size: 20px; }');
      vHTML.Add('    .body { padding: 25px 35px; }');
      vHTML.Add('    .body h3 { color: #2E86C1; margin-top: 25px; }');
      vHTML.Add('    .body p { font-size: 13px; margin-top: 8px; line-height: 1.5; }');
      vHTML.Add('    .highlight { background: #f8f9fa; padding: 8px; border-radius: 4px; }');
      vHTML.Add('    .footer { text-align: center; padding: 15px; background: #f0f0f0; font-size: 11px; color: #777; margin-top: 30px; }');
      vHTML.Add('    hr { border: none; border-top: 1px solid #ddd; margin: 30px 0; }');
      vHTML.Add('  </style>');
      vHTML.Add('</head>');
      vHTML.Add('<body>');
      vHTML.Add('  <div class="content">');
      vHTML.Add('    <div class="header">');
      vHTML.Add('      <h2>📄 Registro Automático de Log - Siac DBManager</h2>');
      vHTML.Add('    </div>');
      vHTML.Add('    <div class="body">');
      vHTML.Add('      <p>' + StringReplace(Corpo, sLineBreak, '<br>', [rfReplaceAll]) + '</p>');
      vHTML.Add('      <hr>');
      vHTML.Add('      <h3>Informações da Execução</h3>');
      vHTML.Add('      <p><b>Data/Hora:</b> ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '</p>');
      vHTML.Add('      <h3>Dados do Funcionário</h3>');
      vHTML.Add('      <div class="highlight">');
      vHTML.Add('        <p><b>Matrícula:</b> ' + FuncionarioId + '<br><b>Nome:</b> ' + FuncionarioNome + '</p>');
      vHTML.Add('      </div>');
      vHTML.Add('      <h3>Dados Empresariais</h3>');
      vHTML.Add('      <div class="highlight">');
      vHTML.Add('        <p><b>Empresa ID:</b> ' + EmpresaID + '<br><b>Razão Social:</b> ' + RazaoSocial + '</p>');
      vHTML.Add('      </div>');
      vHTML.Add('      <h3>Dados da Máquina</h3>');
      vHTML.Add('      <div class="highlight">');
      vHTML.Add('        <p><b>Usuário do Windows:</b> ' + GetEnvironmentVariable('USERNAME') + '<br>');
      vHTML.Add('        <b>Computador:</b> ' + GetEnvironmentVariable('COMPUTERNAME') + '<br>');
      vHTML.Add('        <b>Endereço IP Local:</b> ' + IPLocal + '<br>');
      vHTML.Add('        <b>Versão do Windows:</b> ' + VersaoWindows + '</p>');
      vHTML.Add('      </div>');
      vHTML.Add('      <h3>Dados da Oracle</h3>');
      vHTML.Add('      <div class="highlight">');
      vHTML.Add('        <p><b>Usuário Oracle:</b> ' + UsuarioBanco + '<br><b>Servidor Oracle:</b> ' + ServidorBanco + '</p>');
      vHTML.Add('      </div>');
      vHTML.Add('      <hr>');
      vHTML.Add('      <p style="font-size:11px; color:#888;">Mensagem gerada automaticamente pelo sistema <b>Siac DBManager</b>. Nenhuma ação é necessária.</p>');
      vHTML.Add('    </div>');
      vHTML.Add('    <div class="footer">');
      vHTML.Add('      <p>Desenvolvido por <a href="http://www.siacsistemas.com.br" target="_blank">SIAC Sistemas</a> - www.siacsistemas.com.br - (62) 4005-8550</p>');
      vHTML.Add('    </div>');
      vHTML.Add('  </div>');
      vHTML.Add('</body>');
      vHTML.Add('</html>');

      InfoSistema := vHTML.Text;

      // ==========================================================
      //  Configuração SSL
      // ==========================================================
      SSL.Host := FSMTPHost;
      SSL.Port := FSMTPPort;
      SSL.SSLOptions.Method := sslvTLSv1_2;
      SSL.SSLOptions.Mode := sslmClient;

      //  Configuração SMTP
      SMTP.IOHandler := SSL;
      SMTP.Host := FSMTPHost;
      SMTP.Port := FSMTPPort;
      SMTP.Username := FUserName;
      SMTP.Password := FPassword;
      SMTP.UseTLS := utUseExplicitTLS;
      SMTP.AuthType := satDefault;

      //  Monta a mensagem
      Msg.ContentType := 'text/html';
      Msg.CharSet := 'utf-8';
      Msg.From.Address := FUserName;
      Msg.From.Name := 'SIAC Sistemas - Log Automático';
      Msg.Recipients.EmailAddresses := FTo;
      Msg.Subject := Assunto;
      Msg.Body.Text := InfoSistema;

      // ==========================================================
      //  Envia o e-mail
      // ==========================================================
      SMTP.ConnectTimeout := 15000;
      SMTP.ReadTimeout := 15000;
      SMTP.Connect;

      try
        if SMTP.Connected then
        begin
          SMTP.Send(Msg);
        end;
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
    vHTML.Free;
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
  Assunto, Corpo, NomeAcaoHTML: string;
begin
  // 🔹 Monta o assunto padrão com data/hora
  Assunto := Format('[Siac DBManager] %s executada em %s',
    [NomeAcao, FormatDateTime('dd/mm/yyyy hh:nn', Now)]);

  // 🔹 Converte o nome da ação em HTML colorido
  NomeAcaoHTML := '<span style="color:#C0392B; font-weight:bold;">' + NomeAcao + '</span>';

  // 🔹 Corpo do e-mail padronizado, com destaque visual no nome da ação
  Corpo :=
    Format(
      'A rotina %s foi executada com sucesso.' + sLineBreak + sLineBreak +
      'Este é um registro automático do sistema Siac DBManager.' + sLineBreak +
      'Nenhuma ação do usuário é necessária.',
      [NomeAcaoHTML]
    );

  // 🔹 Chama o método principal para envio
  EnviarLog(Assunto, Corpo);
end;


end.

