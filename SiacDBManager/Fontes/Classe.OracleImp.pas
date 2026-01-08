unit Classe.OracleImp;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils,
  Winapi.Windows, uDataModule, System.StrUtils, Ora;

type
  TOracleImpExp = class
  private
    FDumpFile: string;
    FOraclePath: string;
    FUsuarioDB: string;
    FSenhaDB: string;
    FServidorDB: string;
    FFromUser: string;
    FToUser: string;
    FLogPath: string;
    FFerramentaImp: string;
    FFerramentaImpDP: string;

    function GetOracleBinPath: string;
    function LocalizarFerramenta(const Ferramenta: string): string;
    procedure CriarDiretorioLog;
    function ExecutarComando(const Cmd: string): string;

    function GetFerramentaImp: string;
    function GetFerramentaImpDP: string;
  public
    constructor Create;

    procedure DetectarFerramentaOracle;
    procedure ImportarDados(const Cmd: string);

    property DumpFile: string read FDumpFile write FDumpFile;
    property FromUser: string read FFromUser write FFromUser;
    property ToUser: string read FToUser write FToUser;
    property ServidorDB: string read FServidorDB;


    property FerramentaImp: string read GetFerramentaImp;
    property FerramentaImpDP: string read GetFerramentaImpDP;

    function GetTnsAliases: TStringList;

    // abrindo o cmd para o usuario acompanhar
    procedure ExecutarComandoVisivel(const Cmd: string);
    procedure SelecionarArquivoDump(const DiretorioInicial: string = ''; const UsarImpDP: Boolean = False);
  end;

implementation

uses
  Vcl.Dialogs;

{ TOracleImpExp }

constructor TOracleImpExp.Create;
begin
  FDumpFile := '';
  FOraclePath := '';
  FLogPath := 'C:\SiacDBManagerLogs';

  // Usa dados da sessão Oracle atual
  if Assigned(DmModule) and DmModule.StatusConectado then
  begin
    FUsuarioDB := DmModule.orsConexao.Username;
    FSenhaDB   := DmModule.orsConexao.Password;
    FServidorDB := DmModule.orsConexao.Server;
  end;
end;

procedure TOracleImpExp.CriarDiretorioLog;
begin
  if not DirectoryExists(FLogPath) then
    ForceDirectories(FLogPath);
end;

function TOracleImpExp.ExecutarComando(const Cmd: string): string;
var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  Buffer: array [0..1023] of AnsiChar;
  BytesRead: DWORD;
  Output: AnsiString;
  CommandLine: string;
begin
  Result := '';
  ZeroMemory(@Security, SizeOf(Security));
  Security.nLength := SizeOf(Security);
  Security.bInheritHandle := True;
  Security.lpSecurityDescriptor := nil;

  if not CreatePipe(ReadPipe, WritePipe, @Security, 0) then
    Exit;

  try
    ZeroMemory(@StartInfo, SizeOf(StartInfo));
    StartInfo.cb := SizeOf(StartInfo);
    StartInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_HIDE;
    StartInfo.hStdOutput := WritePipe;
    StartInfo.hStdError  := WritePipe;

    ZeroMemory(@ProcInfo, SizeOf(ProcInfo));

    CommandLine := 'cmd.exe /C ' + Cmd;

    if CreateProcess(
         nil,
         PChar(CommandLine),
         nil,
         nil,
         True,
         CREATE_NO_WINDOW,
         nil,
         nil,
         StartInfo,
         ProcInfo) then
    begin
      CloseHandle(WritePipe);
      Output := '';
      repeat
        BytesRead := 0;
        if ReadFile(ReadPipe, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) and (BytesRead > 0) then
        begin
          Buffer[BytesRead] := #0;
          Output := Output + Buffer;
        end;
      until BytesRead = 0;

      WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      Result := Trim(string(Output));
    end;
  finally
    CloseHandle(ReadPipe);
  end;
end;

function TOracleImpExp.GetOracleBinPath: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'OracleDB\bin';
end;

function TOracleImpExp.LocalizarFerramenta(const Ferramenta: string): string;
var
  Resultado, Linha: string;
  Lista: TStringList;
begin
  Result := '';
  Resultado := ExecutarComando('where ' + Ferramenta);

  // Garante que existe retorno
  if Trim(Resultado) = '' then
    Exit;

  // Cria lista com as linhas retornadas
  Lista := TStringList.Create;
  try
    Lista.Text := Trim(Resultado);

    // Usa a primeira linha válida
    if Lista.Count > 0 then
    begin
      Linha := Trim(Lista[0]);

      // Confirma se o arquivo existe
      if FileExists(Linha) then
        Result := Linha
      else
        Result := '';
    end;
  finally
    Lista.Free;
  end;
end;


procedure TOracleImpExp.SelecionarArquivoDump(const DiretorioInicial: string = ''; const UsarImpDP: Boolean = False);
var
  Dialog: TFileOpenDialog;
  FileTypeItem: TFileTypeItem;
  PastaInicial: string;
begin
  Dialog := TFileOpenDialog.Create(nil);
  try
    Dialog.Title := 'Selecione o arquivo de dump do Oracle';

    //  Define extensão padrão conforme o modo
    if UsarImpDP then
      Dialog.DefaultExtension := 'DP'
    else
      Dialog.DefaultExtension := 'DMP';

    //  Normaliza o caminho recebido do Oracle
    PastaInicial := Trim(DiretorioInicial);
    if PastaInicial <> '' then
    begin
      // Substitui barras erradas e remove aspas
      PastaInicial := StringReplace(PastaInicial, '/', '\', [rfReplaceAll]);
      PastaInicial := StringReplace(PastaInicial, '"', '', [rfReplaceAll]);

      // Remove possíveis duplas barras e garante barra final correta
      while PastaInicial.Contains('\\\\') do
        PastaInicial := StringReplace(PastaInicial, '\\\\', '\', [rfReplaceAll]);
      PastaInicial := IncludeTrailingPathDelimiter(PastaInicial);

      //  Depuração: mostra pasta que será aberta
      OutputDebugString(PChar('Abrindo seletor em: ' + PastaInicial));

      if DirectoryExists(PastaInicial) then
      begin
        Dialog.DefaultFolder := PastaInicial;
        Dialog.FileName := PastaInicial; // força abrir dentro da pasta
      end;
    end;

    //  Garante opções compatíveis com o sistema de arquivos
    Dialog.Options := [fdoPathMustExist, fdoFileMustExist, fdoForceFileSystem];

    //  Define filtros
    if UsarImpDP then
    begin
      FileTypeItem := Dialog.FileTypes.Add;
      FileTypeItem.DisplayName := 'Arquivos Oracle Data Pump (*.DP;*.DMP)';
      FileTypeItem.FileMask := '*.DP;*.DMP';
    end
    else
    begin
      FileTypeItem := Dialog.FileTypes.Add;
      FileTypeItem.DisplayName := 'Arquivos Oracle Dump (*.DMP)';
      FileTypeItem.FileMask := '*.DMP';
    end;

    //  Executa o seletor
    if Dialog.Execute then
      FDumpFile := Dialog.FileName
    else
      FDumpFile := '';

  finally
    Dialog.Free;
  end;
end;


procedure TOracleImpExp.DetectarFerramentaOracle;
begin
  FFerramentaImp := LocalizarFerramenta('imp.exe');
  FFerramentaImpDP := LocalizarFerramenta('impdp.exe');

  // Define a ferramenta padrão de uso
  if FFerramentaImp <> '' then
    FOraclePath := FFerramentaImp
  else if FFerramentaImpDP <> '' then
    FOraclePath := FFerramentaImpDP
  else
    raise Exception.Create('Ferramenta Oracle (imp/impdp) não localizada no sistema.');
end;

procedure TOracleImpExp.ImportarDados(const Cmd: string);
begin
  if Trim(Cmd) = '' then
    raise Exception.Create('Nenhum comando informado para execução.');

  // Apenas executa o comando recebido (CmdPreview)
  ExecutarComando(Cmd);
end;


function TOracleImpExp.GetTnsAliases: TStringList;
var
  TnsPath: string;
  Lines: TStringList;
  Line, AliasName, Host: string;
  i, PosHostStart, PosHostEnd: Integer;
  ORACLE_HOME_Query: TOraQuery;

begin
  Result := TStringList.Create;
  Lines := TStringList.Create;
  try
    // Localiza o arquivo TNSNAMES.ORA
    if GetEnvironmentVariable('TNS_ADMIN') <> '' then
      TnsPath := IncludeTrailingPathDelimiter(GetEnvironmentVariable('TNS_ADMIN')) + 'tnsnames.ora'
      // Se não achar vai localizar pela variavel de ambiente definida no Windows
    else if GetEnvironmentVariable('ORACLE_HOME') <> '' then
      TnsPath := IncludeTrailingPathDelimiter(GetEnvironmentVariable('ORACLE_HOME')) + 'network\admin\tnsnames.ora'
    else

      try
        ORACLE_HOME_Query := TOraQuery.Create(nil);
        try
          ORACLE_HOME_Query.Session := DmModule.orsConexao;
          ORACLE_HOME_Query.SQL.Text :=
              'SELECT DIRECTORY_PATH'+
              '  FROM all_directories '+
              ' WHERE DIRECTORY_NAME = ''ORACLE_HOME'' ' ;


          ORACLE_HOME_Query.Open;

          if not ORACLE_HOME_Query.IsEmpty then
          begin
            TnsPath := Trim(ORACLE_HOME_Query.FieldByName('DIRECTORY_PATH').AsString) + '\network\admin\tnsnames.ora';
          end;
        finally
          ORACLE_HOME_Query.Free;
        end;
      except
        on E: Exception do
        begin
          ShowMessage('Falha ao localizar OracleHome ' + E.Message  );
        end;
      end;





    if not FileExists(TnsPath) then
    begin
      ShowMessage('Arquivo tnsnames.ora não encontrado:' + sLineBreak + TnsPath);
      Exit;
    end;

    Lines.LoadFromFile(TnsPath, TEncoding.UTF8);

    AliasName := '';
    Host := '';

    for i := 0 to Lines.Count - 1 do
    begin
      Line := Trim(Lines[i]);
      if (Line = '') or (Line[1] = '#') then
        Continue;

      // Detecta o nome do alias (ex: MASTER =)
      if (Pos('=', Line) > 0) and (Line[1] <> '(') then
      begin
        AliasName := Trim(Copy(Line, 1, Pos('=', Line) - 1));
        AliasName := StringReplace(AliasName, ' ', '', [rfReplaceAll]);
      end;

      // Agora busca especificamente "(HOST = ...)"
      PosHostStart := Pos('(HOST', UpperCase(Line));
      if PosHostStart > 0 then
      begin
        // Localiza o "=" após "(HOST"
        PosHostStart := Pos('(HOST', UpperCase(Line)) + Length('(HOST');
        PosHostStart := PosEx('=', Line, PosHostStart);
        if PosHostStart > 0 then
        begin
          // Localiza o fechamento do parêntese depois do HOST
          PosHostEnd := PosEx(')', Line, PosHostStart);
          if PosHostEnd > 0 then
            Host := Trim(Copy(Line, PosHostStart + 1, PosHostEnd - PosHostStart - 1))
          else
            Host := Trim(Copy(Line, PosHostStart + 1, MaxInt));

          // Limpa o valor extraído
          Host := StringReplace(Host, '(', '', [rfReplaceAll]);
          Host := StringReplace(Host, ')', '', [rfReplaceAll]);
          Host := Trim(Host);

          if (AliasName <> '') and (Host <> '') then
          begin
            Result.Add(Format('%s | %s', [AliasName, Host]));
            AliasName := '';
            Host := '';
          end;
        end;
      end;
    end;

  finally
    Lines.Free;
  end;
end;

procedure TOracleImpExp.ExecutarComandoVisivel(const Cmd: string);
var
  CommandLine: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  ZeroMemory(@ProcessInfo, SizeOf(ProcessInfo));

  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_SHOW; // Mostra o CMD na tela

  // Usa /K (mantém aberto) em vez de /C (fecha após executar)
  CommandLine := 'cmd.exe /K ' + Cmd;

  // Cria o processo sem travar a aplicação Delphi
  if not CreateProcess(
       nil,
       PChar(CommandLine),
       nil,
       nil,
       False,
       CREATE_NEW_CONSOLE, // abre uma nova janela de console
       nil,
       nil,
       StartupInfo,
       ProcessInfo
     ) then
    raise Exception.CreateFmt('Falha ao iniciar processo CMD: %s', [SysErrorMessage(GetLastError)])
  else
  begin
    // Fecha os handles — o CMD continua aberto, o Delphi continua livre
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

function TOracleImpExp.GetFerramentaImp: string;
begin
  Result := FFerramentaImp;
end;

function TOracleImpExp.GetFerramentaImpDP: string;
begin
  Result := FFerramentaImpDP;
end;

end.

