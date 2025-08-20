unit classe.Conexao;

interface

uses
  Ora, // ODAC main unit
  System.SysUtils, System.IniFiles,
  Vcl.Forms, Dialogs;

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

    constructor Create ( NomeConexao :  TOraSession );

    property Conexao : TOraSession  read FConexao  write FConexao;
    property Servidor: String       read FServidor write FServidor;
    property Base    : String       read FBase     write FBase;
    property Login   : String       read FLogin    write FLogin;
    property Senha   : String       read FSenha    write FSenha;
    property Porta   : String       read FPorta    write FPorta;
    property MsgErro : String       read FMsgErro  write FMsgErro;



   end;
implementation

{ Tconexao }

constructor Tconexao.Create(NomeConexao: TOraSession);
begin

end;

end.
