unit classe.conexao;

interface

uses
  Ora, // ODAC main unit
  System.SysUtils, System.IniFiles,
  Vcl.Forms, unit_funcoes, Dialogs;

type
  Tconexao = class
  private
    FServidor: String;
    FMsgErro: String;
    FSenha: String;
    FBase: String;
    FLogin: String;
    FPorta: String;
    FConexao: TOraSession;

  public
    constructor Create(NomeConexao: TOraSession);
    destructor Destroy; override;

    function fnc_conectar_banco_dados: Boolean;
    procedure prcGravarArquivoIni;
    function fnc_ler_ArquivoIni: Boolean;

    property Conexao  : TOraSession  read FConexao  write FConexao;
    property Servidor : String       read FServidor write FServidor;
    property Base     : String       read FBase     write FBase;
    property Login    : String       read FLogin    write FLogin;
    property Senha    : String       read FSenha    write FSenha;
    property Porta    : String       read FPorta    write FPorta;
    property MsgErro  : String       read FMsgErro  write FMsgErro;
  end;

implementation

{ Tconexao }

constructor Tconexao.Create(NomeConexao: TOraSession);
begin
  FConexao := NomeConexao;
end;

destructor Tconexao.Destroy;
begin
  if Assigned(FConexao) then
    FConexao.Connected := False;
  inherited;
end;

function Tconexao.fnc_conectar_banco_dados: Boolean;
begin
  Result := False;

  FConexao.Connected := False;
  FConexao.Options.Clear;

  if not fnc_ler_ArquivoIni then
  begin
    FMsgErro := 'O arquivo de configuração não foi encontrado!';
    Exit;
  end;

  try
    // Exemplo de string para ODAC: servidor:porta/serviço
    FConexao.Username := FLogin;
    FConexao.Password := FSenha;
    FConexao.Server   := Format('%s:%s/%s', [FServidor, FPorta, FBase]);
    FConexao.Direct   := True; // Conexão direta sem Oracle Client

    FConexao.Connected := True;
    Result := True;

  except
    on E: Exception do
    begin
      FMsgErro := E.Message;
      Result := False;
    end;
  end;
end;

procedure Tconexao.prcGravarArquivoIni;
var
  IniFile: String;
  Ini: TIniFile;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');
  Ini := TIniFile.Create(IniFile);
  try
    Ini.WriteString('Configuracao', 'Servidor', FServidor);
    Ini.WriteString('Configuracao', 'Base', FBase);
    Ini.WriteString('Configuracao', 'Porta', FPorta);
    Ini.WriteString('Acesso', 'Login', FLogin);
    Ini.WriteString('Acesso', 'Senha', Criptografia(FSenha, 'Siac@123'));
  finally
    Ini.Free;
  end;
end;

function Tconexao.fnc_ler_ArquivoIni: Boolean;
var
  IniFile: String;
  Ini: TIniFile;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');
  if not FileExists(IniFile) then
  begin
    Result := False;
    Exit;
  end;

  Ini := TIniFile.Create(IniFile);
  try
    FServidor := Ini.ReadString('Configuracao', 'Servidor', '');
    FBase     := Ini.ReadString('Configuracao', 'Base', '');
    FPorta    := Ini.ReadString('Configuracao', 'Porta', '');
    FLogin    := Ini.ReadString('Acesso', 'Login', '');
    FSenha    := Ini.ReadString('Acesso', 'Senha', '');
    FSenha    := Criptografia(FSenha, 'Siac@123');
    Result := True;
  finally
    Ini.Free;
  end;
end;

end.

