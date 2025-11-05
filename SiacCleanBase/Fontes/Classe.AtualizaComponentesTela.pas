unit Classe.AtualizaComponentesTela;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Graphics;

type
  TClasseAtualizaComponentesTela = class
  public
    // Atualiza um DBGrid baseado no nome do dataset que ele usa
    class procedure AtualizarDBGrid(const AQry: TDataSet);

    // Atualiza Label e variáveis globais
    class procedure AtualizarVariaveisGlobais(const ALabel: TLabel; const AQry: TDataSet);
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

class procedure TClasseAtualizaComponentesTela.AtualizarVariaveisGlobais(
  const ALabel: TLabel; const AQry: TDataSet);
begin
  if not Assigned(ALabel) then
    Exit;

  if (not Assigned(AQry)) or (AQry.IsEmpty) then
  begin
    // limpa variáveis globais
    vGbl_Empresa_id  := '';
    vGbl_RazaoSocial := '';

    // atualiza label
    ALabel.Caption := 'Nenhuma empresa selecionada';

    // define cores para estado vazio
    ALabel.Font.Color := clWhite;
    ALabel.Color := clBtnFace;
    Exit;
  end;

  // Atualiza variáveis globais a partir do dataset
  vGbl_Empresa_id  := AQry.FieldByName('EMPRESA_ID').AsString;
  vGbl_RazaoSocial := AQry.FieldByName('RAZAO_SOCIAL').AsString;

  // Atualiza label
  ALabel.Caption := 'Empresa Selecionada: ' + vGbl_Empresa_id + ' - ' + vGbl_RazaoSocial;

  // define cores para estado com empresa selecionada
  ALabel.Font.Color := clWebGreenYellow;
  ALabel.Color := clBtnFace;
end;

end.

