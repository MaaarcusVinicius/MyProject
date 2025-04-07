unit unitFuncoes;

interface

 uses
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, System.SysUtils;

   procedure prcValidarCamposObrigatorios ( Form : TForm );

   function TrocaCaracterEspecial(aTexto : string; aLimExt : boolean = False) : string;


implementation

procedure prcValidarCamposObrigatorios ( Form : TForm );
var i: Integer;

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

end.
