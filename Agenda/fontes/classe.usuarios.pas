unit classe.usuarios;

interface

uses
  FireDAC.Comp.Client, unit_funcoes, Vcl.Forms, System.SysUtils;

Type

  TUsuarios = Class

   private
    FqryConsulta: TFDQuery;
    Fcd_permissao: Integer;
    Fds_senha: String;
    Fds_login: String;
    Fds_usuario: String;
    Fid_usuarios: Integer;
    FConexao: TFDConnection;



   public
    property QryConsulta : TFDQuery  read FqryConsulta write FqryConsulta;
    property Conexao     : TFDConnection read FConexao write FConexao;
    property id_usuarios  : Integer read Fid_usuarios  write Fid_usuarios ;
    property ds_usuario   : String  read Fds_usuario   write Fds_usuario ;
    property ds_login     : String  read Fds_login     write Fds_login ;
    property ds_senha     : String  read Fds_senha     write Fds_senha ;
    property cd_permissao : Integer read Fcd_permissao write Fcd_permissao ;

    constructor Create( Conexao : TFDConnection);
    destructor Destroy; override;
    function fnc_operacoes_crud( TipoOperacao, parametro : string; out Erro: String ): Boolean;
    function fnc_valida_login ( usuario, senha : string): Boolean;

  End;


implementation

uses
  unit_principal;

{ TUsuarios }

constructor TUsuarios.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;

  FqryConsulta := TFDQuery.Create ( nil );
  FqryConsulta.Connection := FConexao;
end;

destructor TUsuarios.Destroy;
begin
  FqryConsulta.Destroy;

  inherited;
end;

function TUsuarios.fnc_operacoes_crud(TipoOperacao, parametro: string;
  out Erro: String): Boolean;
var
  qryAuxiliar: TFDQuery;

begin
  try
    Fconexao.Connected := False;
    Fconexao.Connected := True;

    if TipoOperacao = 'CONSULTAR' then
    begin

      FqryConsulta.Close;
      FqryConsulta.SQL.Clear;
        FqryConsulta.SQL.Add('select id_usuarios,               ');
        FqryConsulta.SQL.Add('       ds_usuario,                ');
        FqryConsulta.SQL.Add('       cd_permissao,              ');
        FqryConsulta.SQL.Add('       ds_login,                  ');
        FqryConsulta.SQL.Add('       ds_senha                   ');
        FqryConsulta.SQL.Add('  from usuarios                   ');
        FqryConsulta.SQL.Add(' where ds_usuario like :p_ds_usuario ');
      FqryConsulta.ParamByName('p_ds_usuario').AsString := '%' + parametro + '%' ;
      FqryConsulta.Open;

    end else
    if TipoOperacao = 'EXCLUIR' then
      FConexao.ExecSQL('Delete from usuarios where id_usuarios = :id_usuario', [StrToInt( parametro )] )
    else
    begin

      try
        qryAuxiliar := TFDQuery.Create( nil );
        qryAuxiliar.Connection := FConexao;

        qryAuxiliar.Close;
        qryAuxiliar.SQL.Clear;

        if TipoOperacao = 'INSERIR' then
        begin

          qryAuxiliar.SQL.Add('insert into usuarios (     ');
          qryAuxiliar.SQL.Add('            id_usuarios,   ');
          qryAuxiliar.SQL.Add('            ds_usuario,    ');
          qryAuxiliar.SQL.Add('            cd_permissao,  ');
          qryAuxiliar.SQL.Add('            ds_login,      ');
          qryAuxiliar.SQL.Add('            ds_senha )     ');
          qryAuxiliar.SQL.Add('     values (:id_usuarios, ');
          qryAuxiliar.SQL.Add('            :ds_usuario,   ');
          qryAuxiliar.SQL.Add('            :cd_permissao, ');
          qryAuxiliar.SQL.Add('            :ds_login,     ');
          qryAuxiliar.SQL.Add('            :ds_senha)     ');

          qryAuxiliar.ParamByName('id_usuarios').AsInteger :=  unit_funcoes.fnc_proximo_codigo('usuarios','id_usuarios');

        end else
        if TipoOperacao = 'ALTERAR' then
        begin

          qryAuxiliar.SQL.Add('update usuarios                     ');
          qryAuxiliar.SQL.Add('   set ds_usuario   = :ds_usuario,  ');
          qryAuxiliar.SQL.Add('       cd_permissao = :cd_permissao,');
          qryAuxiliar.SQL.Add('       ds_login     = :ds_login,    ');
          qryAuxiliar.SQL.Add('       ds_senha     = :ds_senha     ');
          qryAuxiliar.SQL.Add(' where id_usuarios = :p_id_usuarios ');

          qryAuxiliar.ParamByName('p_id_usuarios').AsInteger := Fid_usuarios;

        end;

        qryAuxiliar.ParamByName('cd_permissao').AsInteger := cd_permissao;
        qryAuxiliar.ParamByName('ds_usuario').AsString    := Fds_usuario;
        qryAuxiliar.ParamByName('ds_login').AsString      := Fds_login;
        qryAuxiliar.ParamByName('ds_senha').AsString      := Fds_senha;
        qryAuxiliar.ExecSQL;

      finally
        qryAuxiliar.Destroy;
      end;

    end;

     Result := True;

  except

   on E: Exception do
   begin
     Erro   := E.Message;
     Result := False;
   end;
  end;

end;

function TUsuarios.fnc_valida_login(usuario, senha: string): Boolean;
var
  Qry_Login: TFDQuery;

begin
  Result := False;

  try
    Qry_Login := TFDQuery.Create( nil );
    Qry_Login.Connection := FConexao;

    Qry_Login.Close;
    Qry_Login.SQL.Clear;

    Qry_Login.SQL.Add('select id_usuarios,              ');
    Qry_Login.SQL.Add('       ds_usuario,               ');
    Qry_Login.SQL.Add('       ds_senha,                 ');
    Qry_Login.SQL.Add('       ds_login,                 ');
    Qry_Login.SQL.Add('       cd_permissao              ');
    Qry_Login.SQL.Add('  from usuarios                  ');
    Qry_Login.SQL.Add(' where ds_login = :p_ds_login    ');
    Qry_Login.ParamByName('p_ds_login').AsString := usuario;
    Qry_Login.Open;

    if Qry_Login.IsEmpty then
    begin
    // usuario não encontrado.
      fnc_criar_menssagem('PROBLEMAS AO ACESSAR O SISTEMA ',
                          'USUÁRIO OU SENHA INVÁLIDOS!',
                          'VERIFIQUE COM ADMINISTRADOR DO SISTEMA',
                          ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                          'OK')  ;
      Result := False;

    end else
    begin
    // usuario encontrado, inicia validação da senha.
      if Qry_Login.FieldByName('ds_senha').AsString = senha then
      begin
      // preenchendo o nome do usuario logado na variavel global.

      var_gbl_nome_usuario := Qry_Login.FieldByName('ds_usuario').AsString;
      var_gbl_id_usuario := Qry_Login.FieldByName('id_usuarios').AsInteger;
      Result := True;

      end else
      begin
        // Usuario = OK porem senha invalida.
        fnc_criar_menssagem('PROBLEMAS AO ACESSAR O SISTEMA ',
                    'SENHA INVÁLIDA!',
                    'VERIFIQUE COM ADMINISTRADOR DO SISTEMA',
                    ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                    'OK')  ;
        Result := False;

      end;

    end;

  finally
    Qry_Login.Destroy;
  end;

end;

end.
