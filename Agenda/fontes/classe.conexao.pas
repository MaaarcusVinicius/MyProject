unit classe.conexao;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Intf, System.SysUtils, System.IniFiles,
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
    FConexao: TFDConnection;


    public

      constructor Create ( NomeConexao : TFDConnection);
      destructor Destroy; override;

      function fnc_conectar_banco_dados: Boolean;
      procedure prcGravarArquivoIni;
      function fnc_ler_ArquivoIni: Boolean;

      property Conexao  : TFDConnection  Read FConexao   Write FConexao;
      property Servidor : String         Read FServidor  Write FServidor;
      property Base     : String         Read FBase      Write FBase;
      property Login    : String         Read FLogin     Write FLogin;
      property Senha    : String         Read FSenha     Write FSenha;
      property Porta    : String         Read FPorta     Write FPorta;
      property MsgErro  : String         Read FMsgErro   Write FMsgErro;


  end;

implementation



{ Tconexao }

constructor Tconexao.Create(NomeConexao: TFDConnection);
begin
   FConexao := NomeConexao;
end;

destructor Tconexao.Destroy;
begin
   FConexao.Connected := False;
  inherited;
end;

function Tconexao.fnc_conectar_banco_dados: Boolean;
begin
  FConexao.Params.Clear;

  if not fnc_ler_ArquivoIni then
  begin
    Result := False;
    FMsgErro := 'O arquivo de confiugração não foi encontrado!';
    Exit;
  end;

  FConexao.Params.Add('Server='    + FServidor);
  FConexao.Params.Add('user_name=' + FLogin);
  FConexao.Params.Add('password='  + FSenha);
  FConexao.Params.Add('porta='     + FPorta);
  FConexao.Params.Add('Database='  + FBase);
  FConexao.Params.Add('DriverID='  + 'MySQL');

  try
   // FConexao.ConnectionString := 'conection string do arquivo';
    FConexao.Connected := True;
   // ShowMessage(FConexao.ConnectionString);
    Result := True;
  except
    on E: Exception do
    begin
      FMsgErro := e.Message;
      Result   := False;
    end;
  end;
end;

procedure Tconexao.prcGravarArquivoIni;
var
 IniFile: String;
 Ini : TiniFile;

begin

  IniFile := ChangeFileExt( Application.Exename, '.ini' ) ;
  Ini     := TIniFile.Create( IniFile );

  try

    Ini.WriteString('Configuracao', 'Servidor', FServidor );
    Ini.WriteString('Configuracao', 'Base', FBase );
    Ini.WriteString('Configuracao', 'Porta', FPorta );
    Ini.WriteString('Acesso', 'Login', FLogin );
    Ini.WriteString('Acesso', 'Senha', Criptografia(FSenha, 'Siac@123') );

  finally
    Ini.Free;
  end;

end;

function Tconexao.fnc_ler_ArquivoIni: Boolean;
var
 IniFile: String;
 Ini : TiniFile;
begin
  IniFile := ChangeFileExt( Application.Exename, '.ini' ) ;
  Ini     := TIniFile.Create( IniFile );

  if not FileExists( IniFile ) then
  begin
    Result := False;
    Exit;
  end;

  try
    FServidor := Ini.ReadString('Configuracao', 'Servidor', '' );
    FBase     := Ini.ReadString('Configuracao', 'Base'    , '' );
    FPorta    := Ini.ReadString('Configuracao', 'Porta'   , '' );
    FLogin    := Ini.ReadString('Acesso'      , 'Login'   , '' );
    FSenha    := Ini.ReadString('Acesso'      , 'Senha'   , '' );
    FSenha    := Criptografia(FSenha, 'Siac@123');

  finally
    Result := True;
    Ini.Free;
  end;
end;

end.
