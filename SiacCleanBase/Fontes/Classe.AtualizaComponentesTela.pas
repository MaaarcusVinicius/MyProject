unit Classe.AtualizaComponentesTela;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Vcl.DBGrids, Vcl.StdCtrls;

type
  TClasseAtualizaComponentesTela = class
  public
    // Atualiza um DBGrid baseado no nome do dataset que ele usa
    class procedure AtualizarDBGrid(const AQry: TDataSet);

    // Atualiza um Label (passado por parâmetro)
    {class procedure AtualizarLabel(const ALabel: TLabel; const AQry: TDataSet);  }

    // Atualiza variáveis globais
    class procedure AtualizarVariaveisGlobais( const ALabel: TLabel; const AQry: TDataSet);
  end;

implementation

uses
  uViewMain;
{ TClasseAtualizaComponentesTela }

class procedure TClasseAtualizaComponentesTela.AtualizarDBGrid(const AQry: TDataSet);
begin
  if Assigned(AQry) then
  begin
    try
      AQry.DisableControls;
      AQry.Close;
      AQry.Open;
    finally
      AQry.EnableControls;
    end;
  end;
end;
{
class procedure TClasseAtualizaComponentesTela.AtualizarLabel(const ALabel: TLabel; const AQry: TDataSet);
begin
  if (Assigned(ALabel)) and (Assigned(AQry)) and (not AQry.IsEmpty) then
  begin
   // Exemplo de como atualizar um Tlabel
    ALabel.Caption := 'Empresa Selecionada: ' +
                      AQry.FieldByName('EMPRESA_ID').AsString + ' / ' +
                      AQry.FieldByName('RAZAO_SOCIAL').AsString;
  end;
end; }


class procedure TClasseAtualizaComponentesTela.AtualizarVariaveisGlobais(
  const ALabel: TLabel; const AQry: TDataSet);
begin
  if not Assigned(ALabel) then
    Exit;

  if (not Assigned(AQry)) or (AQry.IsEmpty) then
  begin
    ALabel.Caption := 'Nenhuma empresa selecionada';
    vGbl_Empresa_id  := '';
    vGbl_RazaoSocial := '';
    Exit;
  end;

  // Atualiza variáveis globais
  vGbl_Empresa_id  := AQry.FieldByName('EMPRESA_ID').AsString;
  vGbl_RazaoSocial := AQry.FieldByName('RAZAO_SOCIAL').AsString;

  // Atualiza label
  ALabel.Caption := 'Empresa Selecionada: ' +
                    vGbl_Empresa_id + ' / ' + vGbl_RazaoSocial;
end;

end.

