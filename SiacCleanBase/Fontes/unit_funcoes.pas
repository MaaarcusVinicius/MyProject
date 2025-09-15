unit unit_funcoes;

interface

uses unit_mensagens, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,  System.SysUtils,
  FireDAC.Comp.Client, Vcl.DBCtrls, IdHashMessageDigest,  Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, DAScript, OraScript;

  function Criptografia ( Senha, Chave: String ): string;
  function fnc_criar_menssagem ( TituloJanela, TituloMSG, MSG, Icone, Tipo : String ): boolean;
  procedure prcValidarCamposObrigatorios ( Form: TForm );
  function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean = False) : string;
  function fnc_sonumeros (AString: string): string;
  function fnc_proximo_codigo(Tabela, Campo : string): Integer;
  function MD5(const Value:string):string;

var
  var_gbl_nome_usuario : string;
  var_gbl_id_usuario : integer;

implementation

uses
   uDataModule;

     // Função de Criptografia de String
  function Criptografia ( Senha, Chave: String ): string;
  var
    x , y : Integer;
    NovaSenha: string;

  begin
     for x := 1 to Length ( Chave ) do
       begin
        NovaSenha := '';

        for y := 1 to Length ( Senha ) do
          begin
            NovaSenha := NovaSenha + Chr( (  Ord( Chave[x] ) xor Ord( Senha[y] ) ) );
          end;
          Senha := NovaSenha;
       end;
       Result := Senha;
  end;


  function fnc_criar_menssagem ( TituloJanela, TituloMSG, MSG, Icone, Tipo : String ): boolean;
  begin

    Result :=  False;

    form_menssagens               := Tform_menssagens.Create( nil );

    form_menssagens.sTituloJanela := TituloJanela;
    form_menssagens.sTituloMSG    := TituloMSG;
    form_menssagens.sMSG          := MSG;
    form_menssagens.sCaminhoIcone := Icone;
    form_menssagens.sTipo         := Tipo;

    form_menssagens.ShowModal;

    Result := form_menssagens.bRespostaMSG;

  end;

  procedure prcValidarCamposObrigatorios ( Form: TForm );
  var
   i: Integer;

   begin
    for I := 0 to Form.ComponentCount - 1  do
    begin

       if Form.Components[i].Tag = 5  then
      begin


          // Tedit
        if Form.Components[i] is Tedit then
        begin
          if ( ( Form.Components[i] as TEdit).Hint <> '' ) and
             ( TrocaCaracterEspecial( ( Form.Components[i] as TEdit ).Text, true ) = '' )
          then
            begin
            ShowMessage( 'Falta preencher o campo: '+ ( ( Form.Components[i] as TEdit).Hint  ) ) ;
             ( Form.Components[i] as TEdit).SetFocus;
            Abort;
            end;


        end;

        // TmaskEdit

        if Form.Components[i] is TMaskEdit then
        begin
          if ( ( Form.Components[i] as TMaskEdit).Hint <> '' ) and
             ( ( Form.Components[i] as TMaskEdit).Text = '' )
          then
            begin
            ShowMessage( 'Falta preencher o campo: '+ ( ( Form.Components[i] as TMaskEdit).Hint  ) ) ;
              ( Form.Components[i] as TMaskEdit).SetFocus;
            Abort;
            end;


        end;

        // TComboBox
        if Form.Components[i] is TComboBox then
        begin
          if ( ( Form.Components[i] as TComboBox).Hint <> '' ) and
             ( ( Form.Components[i] as TComboBox).Text = '' )
          then
            begin
            ShowMessage( 'Falta preencher o campo: '+ ( ( Form.Components[i] as TComboBox).Hint  ) ) ;
              ( Form.Components[i] as TComboBox).SetFocus;
            Abort;
            end;

        end;


        // TmaskEdit

        if Form.Components[i] is TDBLookupComboBox then
        begin
          if ( ( Form.Components[i] as TDBLookupComboBox).Hint <> '' ) and
             ( ( Form.Components[i] as TDBLookupComboBox).Text = '' )
          then
            begin
            ShowMessage( 'Falta preencher o campo: '+ ( ( Form.Components[i] as TDBLookupComboBox).Hint  ) ) ;
              ( Form.Components[i] as TDBLookupComboBox).SetFocus;
            Abort;
            end;


        end;

      end;

    end;

end;


function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean = False) : string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
  //Lista de Caracteres Extras
  xCarExt: array[1..48] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                     '(',')','_','+','=','{','}','[',']','?',
                                     ';',':',',','|','*','"','~','^','´','`',
                                     '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                     '®','½','¼','ß','µ','þ','ý','Ý');
var
  xTexto : string;
  i : Integer;
begin
   xTexto := aTexto;
   for i:=1 to 38 do
     xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   //De acordo com o parâmetro aLimExt, elimina caracteres extras.
   if (aLimExt) then
     for i:=1 to 48 do
       xTexto := StringReplace(xTexto, xCarExt[i], '', [rfreplaceall]);
   Result := xTexto;
end;

  function fnc_sonumeros (AString: string): string;
  var
    I : Integer;
    Limpos : string;

  begin

    Limpos := '';

    for I := 1 to Length(AString) do
      begin
          if Pos(Copy(AString, I , 1), '0123456789') <> 0 then
            Limpos := Limpos + Copy(AString , I, 1);
      end;

      Result := Limpos;
  end;

function fnc_proximo_codigo(Tabela, Campo : string): Integer;
 var
   QryConsulta : TOraQuery;

begin
   Result := 1;

   try

     QryConsulta.Session := DmModule.orsConexao;

    if not DmModule.orsConexao.Connected then
      DmModule.ConectarBd('usuario', 'senha', 'servidor'); // <- ajuste com seus parâmetros

     QryConsulta := TOraQuery.Create(nil);

     QryConsulta.Close;
     QryConsulta.SQL.Clear;
     QryConsulta.SQL.Add('SELECT MAX( '+Campo+' )  as CODIGO FROM ' + Tabela);
     QryConsulta.Open;

     if QryConsulta.FieldByName('CODIGO').AsString <> '' then
        Result := QryConsulta.FieldByName('CODIGO').AsInteger + 1;

   finally
     QryConsulta.Destroy;
   end;

end;

function MD5(const Value :string):string;
var
  xMD5 : TIdHashMessageDigest5;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  try
    result := xMD5.HashStringAsHex(Value);
  finally
    xMD5.Free;
  end;
end;

end.
