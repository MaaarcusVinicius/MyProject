unit classe.clientes;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms, unit_funcoes;

type
  TClientes = class
     private
      FConexao       : TFDConnection;
      Fid_cliente    : Integer;
      Fds_cliente    : string;
      Fdt_nascimento : TDateTime;
      Fnr_cpf        : string;
      Fnr_rg         : string;
      Fnr_cep        : string;
      Fds_endereco   : string;
      Fnr_numero     : string;
      Fds_complemento: string;
      Fds_bairro     : string;
      Fds_cidade     : string;
      Fds_uf         : string;
      Fnr_telefone   : string;
      Fnr_telefone2  : string;
      Fds_obs        : string;

     public

      property  Conexao       : TFDConnection read FConexao        write FConexao;
      property  id_cliente    : Integer       read Fid_cliente     write Fid_cliente;
      property  ds_cliente    : string        read Fds_cliente     write Fds_cliente;
      property  dt_nascimento : TDateTime     read Fdt_nascimento  write Fdt_nascimento;
      property  nr_cpf        : string        read Fnr_cpf         write Fnr_cpf;
      property  nr_rg         : string        read Fnr_rg          write Fnr_rg;
      property  nr_cep        : string        read Fnr_cep         write Fnr_cep;
      property  ds_endereco   : string        read Fds_endereco    write Fds_endereco;
      property  nr_numero     : string        read Fnr_numero      write Fnr_numero;
      property  ds_complemento: string        read Fds_complemento write Fds_complemento;
      property  ds_bairro     : string        read Fds_bairro      write Fds_bairro;
      property  ds_cidade     : string        read Fds_cidade      write Fds_cidade;
      property  ds_uf         : string        read Fds_uf          write Fds_uf;
      property  nr_telefone   : string        read Fnr_telefone    write Fnr_telefone;
      property  nr_telefone2  : string        read Fnr_telefone2   write Fnr_telefone2;
      property  ds_obs        : string        read Fds_obs         write Fds_obs;

     constructor Create ( Conexao : TFDConnection );
     destructor destroy; override;

    function fnc_inserir_alterar (TipoOperacao: string; out Erro : string ) : Boolean;
    procedure prc_deleta (id_chave: Integer );
    function fnc_cosnulta ( Texto: String ) : TFDQuery;


  end;
implementation

 var
   QryConsulta : TFDQuery;


{ Tclientes }

constructor TClientes.Create(Conexao: TFDConnection);
begin

  FConexao               := Conexao;
  QryConsulta            := TFDQuery.Create(nil);
  QryConsulta.Connection := FConexao;

end;

destructor TClientes.destroy;
begin
   QryConsulta.Destroy;
  inherited;
end;

function TClientes.fnc_cosnulta(Texto: String): TFDQuery;
begin
   try
    // FConexao.Connected := False;
     FConexao.Connected := True;

     QryConsulta.SQL.Clear;
      QryConsulta.SQL.Add('Select id_cliente,    ');
      QryConsulta.SQL.Add('       ds_cliente,    ');
      QryConsulta.SQL.Add('       dt_nascimento, ');
      QryConsulta.SQL.Add('       nr_cpf,        ');
      QryConsulta.SQL.Add('       nr_rg,         ');
      QryConsulta.SQL.Add('       nr_cep,        ');
      QryConsulta.SQL.Add('       ds_endereco,   ');
      QryConsulta.SQL.Add('       nr_numero,     ');
      QryConsulta.SQL.Add('       ds_complemento,');
      QryConsulta.SQL.Add('       ds_bairro,     ');
      QryConsulta.SQL.Add('       ds_cidade,     ');
      QryConsulta.SQL.Add('       ds_uf,         ');
      QryConsulta.SQL.Add('       nr_telefone,   ');
      QryConsulta.SQL.Add('       nr_telefone2,  ');
      QryConsulta.SQL.Add('       ds_obs         ');
      QryConsulta.SQL.Add('  From Clientes       ');

      QryConsulta.SQL.Add(' where ((ds_cliente like :p_texto) or ( ds_endereco like :p_texto )) ');

      QryConsulta.ParamByName('p_texto').AsString := '%' + Texto + '%';
     QryConsulta.Open();


   finally

     Result := QryConsulta;

   end;
end;

function TClientes.fnc_inserir_alterar(TipoOperacao: string;
  out Erro: string): Boolean;
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

      if TipoOperacao = 'INSERIR' then
      begin
           // Insert
        QryInserir.SQL.Add('insert into clientes (id_cliente, ');
        QryInserir.SQL.Add('       ds_cliente,                ');
        QryInserir.SQL.Add('       dt_nascimento,             ');
        QryInserir.SQL.Add('       nr_cpf,                    ');
        QryInserir.SQL.Add('       nr_rg,                     ');
        QryInserir.SQL.Add('       nr_cep,                    ');
        QryInserir.SQL.Add('       ds_endereco,               ');
        QryInserir.SQL.Add('       nr_numero,                 ');
        QryInserir.SQL.Add('       ds_complemento,            ');
        QryInserir.SQL.Add('       ds_bairro,                 ');
        QryInserir.SQL.Add('       ds_cidade,                 ');
        QryInserir.SQL.Add('       ds_uf,                     ');
        QryInserir.SQL.Add('       nr_telefone,               ');
        QryInserir.SQL.Add('       nr_telefone2,              ');
        QryInserir.SQL.Add('       ds_obs)                    ');
        QryInserir.SQL.Add(' values                           ');
        QryInserir.SQL.Add('      (:p_id_cliente,             ');
        QryInserir.SQL.Add('       :ds_cliente,               ');
        QryInserir.SQL.Add('       :dt_nascimento,            ');
        QryInserir.SQL.Add('       :nr_cpf,                   ');
        QryInserir.SQL.Add('       :nr_rg,                    ');
        QryInserir.SQL.Add('       :nr_cep,                   ');
        QryInserir.SQL.Add('       :ds_endereco,              ');
        QryInserir.SQL.Add('       :nr_numero,                ');
        QryInserir.SQL.Add('       :ds_complemento,           ');
        QryInserir.SQL.Add('       :ds_bairro,                ');
        QryInserir.SQL.Add('       :ds_cidade,                ');
        QryInserir.SQL.Add('       :ds_uf,                    ');
        QryInserir.SQL.Add('       :nr_telefone,              ');
        QryInserir.SQL.Add('       :nr_telefone2,             ');
        QryInserir.SQL.Add('       :ds_obs)                   ');

        QryInserir.ParamByName('p_id_cliente').AsInteger := fnc_proximo_codigo('clientes', 'id_cliente') ;

     end else
     begin  //update

        QryInserir.SQL.Add('update clientes set                     ');
        QryInserir.SQL.Add('       id_cliente     = :p_id_cliente,  ');
        QryInserir.SQL.Add('       ds_cliente     = :ds_cliente,    ');
        QryInserir.SQL.Add('       dt_nascimento  = :dt_nascimento, ');
        QryInserir.SQL.Add('       nr_cpf         = :nr_cpf,        ');
        QryInserir.SQL.Add('       nr_rg          = :nr_rg,         ');
        QryInserir.SQL.Add('       nr_cep         = :nr_cep,        ');
        QryInserir.SQL.Add('       ds_endereco    = :ds_endereco,   ');
        QryInserir.SQL.Add('       nr_numero      = :nr_numero,     ');
        QryInserir.SQL.Add('       ds_complemento = :ds_complemento,');
        QryInserir.SQL.Add('       ds_bairro      = :ds_bairro,     ');
        QryInserir.SQL.Add('       ds_cidade      = :ds_cidade,     ');
        QryInserir.SQL.Add('       ds_uf          = :ds_uf,         ');
        QryInserir.SQL.Add('       nr_telefone    = :nr_telefone,   ');
        QryInserir.SQL.Add('       nr_telefone2   = :nr_telefone2,  ');
        QryInserir.SQL.Add('       ds_obs         = :ds_obs         ');
        QryInserir.SQL.Add(' where id_cliente     = :p_id_cliente    ');

        QryInserir.ParamByName('p_id_cliente').AsInteger := Fid_cliente;
     end;

       QryInserir.ParamByName('ds_cliente').AsString     := Fds_cliente    ;
       QryInserir.ParamByName('dt_nascimento').AsDate    := Fdt_nascimento ;
       QryInserir.ParamByName('nr_cpf').AsString         := Fnr_cpf        ;
       QryInserir.ParamByName('nr_rg').AsString          := Fnr_rg         ;
       QryInserir.ParamByName('nr_cep').AsString         := Fnr_cep        ;
       QryInserir.ParamByName('ds_endereco').AsString    := Fds_endereco   ;
       QryInserir.ParamByName('nr_numero').AsString      := Fnr_numero     ;
       QryInserir.ParamByName('ds_complemento').AsString := Fds_complemento;
       QryInserir.ParamByName('ds_bairro').AsString      := Fds_bairro     ;
       QryInserir.ParamByName('ds_cidade').AsString      := Fds_cidade     ;
       QryInserir.ParamByName('ds_uf').AsString          := Fds_uf         ;
       QryInserir.ParamByName('nr_telefone').AsString    := Fnr_telefone   ;
       QryInserir.ParamByName('nr_telefone2').AsString   := Fnr_telefone2  ;
       QryInserir.ParamByName('ds_obs').AsString         := Fds_obs        ;

       QryInserir.ExecSQL;

       Result := True;

    except
      on E: Exception do
      begin
        Erro   := E.Message;
        Result := False;
      end;
    end;

  finally
    QryInserir.Destroy;
  end;


end;

procedure TClientes.prc_deleta(id_chave: Integer);
begin
  if fnc_criar_menssagem('CONFIRMAÇÃO',
                         'Excluir Dados',
                         ' Tem certeza que deseja excluir esse CLIENTE?' ,
                         ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                         '')  then
  begin

    FConexao.Connected := False;
    FConexao.Connected := True;

    FConexao.ExecSQL('Delete from clientes where id_cliente = :id_chave' , [id_chave])	;

    // Chama novamente a consulta para atualziar o Grid, depois da exclusão.
    //fnc_consulta('');

  end;
end;

end.
