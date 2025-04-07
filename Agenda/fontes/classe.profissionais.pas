unit classe.profissionais;

interface

uses
  FireDAC.Comp.Client, unit_funcoes, Vcl.Forms, System.SysUtils;

Type
 TProfissionais = class
   private
     FConexao         : TFDConnection;
     FId_Profissional : Integer;
     Fds_Profissional : String;
     Fds_especialidade: String;
     Fnr_contato      : String;

   public

     property  Conexao         : TFDConnection read FConexao          write FConexao;
     property  Id_Profissional : Integer       read FId_Profissional  write FId_Profissional;
     property  ds_Profissional : String        read Fds_Profissional  write Fds_Profissional;
     property  ds_especialidade: String        read Fds_especialidade write Fds_especialidade;
     property  nr_contato      : String        read Fnr_contato       write Fnr_contato;

     constructor Create( Conexao : TFDConnection);
     destructor Destroy; override;

     function fnc_inserir_alterar (TipoOperacao: string; out Erro: string) : Boolean;
     procedure prc_deleta ( id_chave: Integer );
     function fnc_consulta ( texto : string ): TFDQuery;

 end;

 var
   QryConsulta : TFDQuery;

implementation

{ TProfissionais }

constructor TProfissionais.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;

  QryConsulta := TFDQuery.Create ( nil );
  QryConsulta.Connection := FConexao;

end;

destructor TProfissionais.Destroy;
begin
  QryConsulta.Destroy;
  inherited;
end;

function TProfissionais.fnc_consulta(texto: string): TFDQuery;

begin

   try
     FConexao.Connected := False;
     FConexao.Connected := True;

     QryConsulta.Close;
     QryConsulta.SQL.Clear;
     QryConsulta.SQL.Add('SELECT id_profissional, upper(ds_profissional) as ds_profissional, ds_especialidade, nr_contato');
     QryConsulta.SQL.Add('FROM profissionais where ds_profissional like :p_texto');
     QryConsulta.ParamByName('p_texto').AsString := '%'+texto+'%';
     QryConsulta.Open;

   finally
     Result := QryConsulta;
   end;

end;

function TProfissionais.fnc_inserir_alterar(TipoOperacao: string; out Erro: string): Boolean;
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
      begin   // Insert Into na Tabela

        QryInserir.SQL.Add('insert into profissionais (id_profissional,ds_profissional,ds_especialidade,nr_contato)');
        QryInserir.SQL.Add('VALUES ( :p_id_profissional, :p_ds_profissional, :p_ds_especialidade, :p_nr_contato)');

        QryInserir.ParamByName('p_id_profissional').AsInteger := fnc_proximo_codigo('profissionais', 'id_profissional') ;

      end else
      begin    // Update na Tabela

        QryInserir.SQL.Add('UPADTE profissionais SET ');
        QryInserir.SQL.Add(' ds_profissional  = :p_ds_profissional, ');
        QryInserir.SQL.Add(' ds_especialidade = :p_ds_especialidade, ');
        QryInserir.SQL.Add(' nr_contato       = :p_nr_contato ');
        QryInserir.SQL.Add(' WHERE id_profissional = p_id_profissional ');

        QryInserir.ParamByName('p_id_profissional').AsInteger := FId_Profissional;


      end;

      QryInserir.ParamByName('p_ds_profissional').AsString := Fds_Profissional ;
      QryInserir.ParamByName('p_ds_especialidade').AsString := Fds_especialidade ;
      QryInserir.ParamByName('p_nr_contato').AsString := Fnr_contato ;
      QryInserir.ExecSQL;

      Result := True;

      fnc_consulta('');

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

procedure TProfissionais.prc_deleta(id_chave: Integer);
begin
  if fnc_criar_menssagem('CONFIRMAÇÃO',
                         'Excluir Dados',
                         ' Tem certeza que deseja excluir esse PROFISSIONAL?' ,
                         ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                         '')  then
  begin                      
  
    FConexao.Connected := False;
    FConexao.Connected := True;

    FConexao.ExecSQL('Delete from profissionais where id_profissional = :id_chave' , [id_chave])	;

    // Chama novamente a consulta para atualziar o Grid, depois da exclusão.
    fnc_consulta('');

  end;
end;

end.
