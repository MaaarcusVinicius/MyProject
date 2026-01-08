unit Classe.OracleExp;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils,
  Winapi.Windows, uDataModule, System.StrUtils, Ora;

type
  TOracleExp = class
  private
    FDumpFile: string;
    FOraclePath: string;
    FUsuarioDB: string;
    FSenhaDB: string;
    FServidorDB: string;
    FFromUser: string;
    FLogPath: string;
    FFerramentaExp: string;
    FFerramentaExpDP: string;

    function GetOracleBinPath: string;
    function LocalizarFerramenta(const Ferramenta: string): string;
    procedure CriarDiretorioLog;
    function ExecutarComando(const Cmd: string): string;

    function GetFerramentaExp: string;
    function GetFerramentaExpDP: string;
  public
    constructor Create;

    procedure DetectarFerramentaOracle;
    procedure ExportarDados(const Cmd: string);
    procedure SelecionarArquivoDestino(const DiretorioInicial: string = ''; const UsarExpDP: Boolean = False);
    procedure ExecutarComandoVisivel(const Cmd: string);

    function GetTnsAliases: TStringList;

    property DumpFile: string read FDumpFile write FDumpFile;
    property FromUser: string read FFromUser write FFromUser;
    property ServidorDB: string read FServidorDB;

    property FerramentaExp: string read GetFerramentaExp;
    property FerramentaExpDP: string read GetFerramentaExpDP;
  end;

implementation

uses
  Vcl.Dialogs;

{ TOracleExp }

constructor TOracleExp.Create;
begin
  FDumpFile := '';
  FOraclePath := '';
  FLogPath := 'C:\SiacDBManagerLogs';

  if Assigned(DmModule) and DmModule.StatusConectado then
  begin
    FUsuarioDB := DmModule.orsConexao.Username;
    FSenhaDB   := DmModule.orsConexao.Password;
    FServidorDB := DmModule.orsConexao.Server;
  end;
end;

procedure TOracleExp.CriarDiretorioLog;
begin
  if not DirectoryExists(FLogPath) then
    ForceDirectories(FLogPath);
end;

function TOracleExp.ExecutarComando(const Cmd: string): string;
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

function TOracleExp.LocalizarFerramenta(const Ferramenta: string): string;
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


procedure TOracleExp.DetectarFerramentaOracle;
begin
  FFerramentaExp := LocalizarFerramenta('exp.exe');
  FFerramentaExpDP := LocalizarFerramenta('expdp.exe');

  if FFerramentaExp = '' then
    raise Exception.Create('Ferramenta Oracle (exp.exe ou expdp.exe) não encontrada no PATH.');
end;

procedure TOracleExp.ExportarDados(const Cmd: string);
begin
  if Trim(Cmd) = '' then
    raise Exception.Create('Nenhum comando informado para execução.');

  ExecutarComando(Cmd);
end;

procedure TOracleExp.ExecutarComandoVisivel(const Cmd: string);
var
  CommandLine: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  ZeroMemory(@ProcessInfo, SizeOf(ProcessInfo));

  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_SHOW;

  CommandLine := 'cmd.exe /K ' + Cmd;

  if not CreateProcess(
       nil,
       PChar(CommandLine),
       nil,
       nil,
       False,
       CREATE_NEW_CONSOLE,
       nil,
       nil,
       StartupInfo,
       ProcessInfo
     ) then
    raise Exception.CreateFmt('Falha ao iniciar processo CMD: %s', [SysErrorMessage(GetLastError)])
  else
  begin
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

function TOracleExp.GetOracleBinPath: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'OracleDB\bin';
end;

function TOracleExp.GetFerramentaExp: string;
begin
  Result := FFerramentaExp;
end;

function TOracleExp.GetFerramentaExpDP: string;
begin
  Result := FFerramentaExpDP;
end;

function TOracleExp.GetTnsAliases: TStringList;
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

procedure TOracleExp.SelecionarArquivoDestino(const DiretorioInicial: string = ''; const UsarExpDP: Boolean = False);
var
  Dialog: TFileSaveDialog;
  FileTypeItem: TFileTypeItem;
  PastaInicial: string;
  Query: TOraQuery;
  DirOracle: string;
begin
  if UsarExpDP then
  begin
    // --- MODO EXPDP (DATA PUMP): Diretório automático no Oracle ---
    try
      Query := TOraQuery.Create(nil);
      try
        Query.Session := DmModule.orsConexao;
        Query.SQL.Text :=
          'SELECT DIRECTORY_PATH ' +
          '  FROM dba_directories ' +
          ' WHERE DIRECTORY_NAME = ''DATA_PUMP_DIR'' ' +
          '    OR DIRECTORY_NAME LIKE ''%PUMP%''';
        Query.Open;

        if not Query.IsEmpty then
        begin
          // Pega o diretório raiz
          DirOracle := Trim(Query.FieldByName('DIRECTORY_PATH').AsString);

          // Corrige a barra invertida (substitui "/" por "\")
          DirOracle := StringReplace(DirOracle, '/', '\', [rfReplaceAll]);

          // Garante o final com barra
          DirOracle := IncludeTrailingPathDelimiter(DirOracle);

          // Monta o nome do arquivo sugerido com prefixo EXPORT_
          FDumpFile := DirOracle +
                       'EXPORT_' + UpperCase(DmModule.orsConexao.Username) + '.DMP';
        end
        else
          raise Exception.Create('Nenhum diretório DATA_PUMP_DIR encontrado no banco de dados.');
      finally
        Query.Free;
      end;
    except
      on E: Exception do
        raise Exception.Create('Erro ao localizar diretório do Data Pump: ' + E.Message);
    end;
  end
  else
  begin
    // --- MODO EXP (CLÁSSICO): Usuário escolhe onde salvar o arquivo ---
    Dialog := TFileSaveDialog.Create(nil);
    try
      Dialog.Title := 'Salvar arquivo de exportação Oracle';
      Dialog.DefaultExtension := 'DMP';

      // Define diretório inicial
      PastaInicial := DiretorioInicial;
      if (PastaInicial <> '') and DirectoryExists(PastaInicial) then
        Dialog.DefaultFolder := PastaInicial
      else
        Dialog.DefaultFolder := 'C:\';

      // Define filtro
      FileTypeItem := Dialog.FileTypes.Add;
      FileTypeItem.DisplayName := 'Arquivos Oracle Dump (*.DMP)';
      FileTypeItem.FileMask := '*.DMP';

      // Sugere nome padrão com prefixo EXPORT_
      Dialog.FileName := 'EXPORT_' + UpperCase(DmModule.orsConexao.Username) + '_' +
                         FormatDateTime('yyyymmdd_hhnnss', Now) + '.DMP';

      // Executa o seletor
      if Dialog.Execute then
        FDumpFile := Dialog.FileName
      else
        FDumpFile := '';
    finally
      Dialog.Free;
    end;
  end;
end;


end.

