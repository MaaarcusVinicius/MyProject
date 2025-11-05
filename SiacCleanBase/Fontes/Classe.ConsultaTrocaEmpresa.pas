unit Classe.ConsultaTrocaEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.StrUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,classe.BancoDados;

type
  TConsultaTrocaEmpresa = class
  private
    FTrocaEmpresa : TClasseBancoDados;
    FBancoUpdate  : TClasseBancoDados;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AtualizarEmpresaStatus(const AEmpresaID: string; const AStatus: string);

procedure CarregarTrocaEmpresa( const AEmpresaID: string;
                                const edt_EMPRESA_ID       : TMaskEdit;
                                      edt_INSC_MUNICIPAL   : TEdit;
                                      edt_INSC_ESTADUAL    : TEdit;
                                      edt_RAZAO_SOCIAL     : TEdit;
                                      edt_FANTASIA         : TEdit;
                                      edt_RAZAO_SOCIAL_NFE : TEdit;
                                      edt_CEP              : TMaskEdit;
                                      edt_ENDERECO         : TEdit;
                                      edt_BAIRRO           : TEdit;
                                      edt_CIDADE_ID        : TEdit;
                                      edt_NOME_CIDADE      : TEdit;
                                      edt_ESTADO_ID        : TEdit;
                                      edt_DDD              : TMaskEdit;
                                      edt_FONE_VOZ         : TMaskEdit;
                                      edt_FONE_FAX         : TMaskEdit;
                                      edt_FONE_DADOS       : TMaskEdit;
                                      edt_E_MAIL           : TEdit;
                                      edt_FONE_WHATSAPP    : TMaskEdit);
  end;

implementation

uses
  uDataModule, uViewMain;

{ TConsultaTrocaEmpresa }

constructor TConsultaTrocaEmpresa.Create;
var
  vLogPath: string;
begin
  vLogPath := 'C:\CleanBaseLogs\Banco.log';

  if not DirectoryExists(ExtractFilePath(vLogPath)) then
    ForceDirectories(ExtractFilePath(vLogPath));

  FTrocaEmpresa := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoUpdate  := TClasseBancoDados.Create(DmModule.orsConexao);

//  FTrocaEmpresa.EnableLog(vLogPath);
//  FBancoUpdate.EnableLog(vLogPath);
end;

destructor TConsultaTrocaEmpresa.Destroy;
begin
  FTrocaEmpresa.Free;
  FBancoUpdate.Free;
  inherited;
end;
procedure TConsultaTrocaEmpresa.CarregarTrocaEmpresa( const AEmpresaID: string;
                                                      const edt_EMPRESA_ID       : TMaskEdit;
                                                            edt_INSC_MUNICIPAL   : TEdit;
                                                            edt_INSC_ESTADUAL    : TEdit;
                                                            edt_RAZAO_SOCIAL     : TEdit;
                                                            edt_FANTASIA         : TEdit;
                                                            edt_RAZAO_SOCIAL_NFE : TEdit;
                                                            edt_CEP              : TMaskEdit;
                                                            edt_ENDERECO         : TEdit;
                                                            edt_BAIRRO           : TEdit;
                                                            edt_CIDADE_ID        : TEdit;
                                                            edt_NOME_CIDADE      : TEdit;
                                                            edt_ESTADO_ID        : TEdit;
                                                            edt_DDD              : TMaskEdit;
                                                            edt_FONE_VOZ         : TMaskEdit;
                                                            edt_FONE_FAX         : TMaskEdit;
                                                            edt_FONE_DADOS       : TMaskEdit;
                                                            edt_E_MAIL           : TEdit;
                                                            edt_FONE_WHATSAPP    : TMaskEdit);
begin
  FTrocaEmpresa.SetSQL( ' SELECT E.EMPRESA_ID,              '+
                        '        E.INSC_MUNICIPAL,          '+
                        '        E.INSC_ESTADUAL,           '+
                        '        E.RAZAO_SOCIAL,            '+
                        '        E.FANTASIA,                '+
                        '        E.RAZAO_SOCIAL_NFE,        '+
                        '        E.CEP,                     '+
                        '        E.ENDERECO,                '+
                        '        E.BAIRRO,                  '+
                        '        E.CIDADE_ID,               '+
                        '        CI.NOME,                   '+
                        '        CI.ESTADO_ID,              '+
                        '        E.DDD,                     '+
                        '        E.FONE_VOZ,                '+
                        '        E.FONE_FAX,                '+
                        '        E.FONE_DADOS,              '+
                        '        E.E_MAIL,                  '+
                        '        E.FONE_WHATSAPP            '+
                        '   FROM EMPRESAS E, CIDADES CI     '+
                        '  WHERE E.CIDADE_ID = CI.CIDADE_ID '+
                        '    AND E.EMPRESA_ID = :vEMPRESA_ID ' );

  // Adiciona o parâmetro corretamente
  FTrocaEmpresa.AddParam('vEMPRESA_ID', AEmpresaID);

  // Executa a consulta
  FTrocaEmpresa.ExecutarConsulta;

  // Se não houver resultados, limpa os edits
  if FTrocaEmpresa.GetQuery.IsEmpty then
  begin
    edt_EMPRESA_ID.Clear;
    edt_INSC_MUNICIPAL.Clear;
    edt_INSC_ESTADUAL.Clear;
    edt_RAZAO_SOCIAL.Clear;
    edt_FANTASIA.Clear;
    edt_RAZAO_SOCIAL_NFE.Clear;
    edt_CEP.Clear;
    edt_ENDERECO.Clear;
    edt_BAIRRO.Clear;
    edt_CIDADE_ID.Clear;
    edt_NOME_CIDADE.Clear;
    edt_ESTADO_ID.Clear;
    edt_DDD.Clear;
    edt_FONE_VOZ.Clear;
    edt_FONE_FAX.Clear;
    edt_FONE_DADOS.Clear;
    edt_E_MAIL.Clear;
    edt_FONE_WHATSAPP.Clear;
    Exit;
  end;

  // Preenche os campos
    edt_EMPRESA_ID.Text 	    := FTrocaEmpresa.GetQuery.FieldByName('EMPRESA_ID').AsString;
    edt_INSC_MUNICIPAL.Text   := FTrocaEmpresa.GetQuery.FieldByName('INSC_MUNICIPAL').AsString;
    edt_INSC_ESTADUAL.Text    := FTrocaEmpresa.GetQuery.FieldByName('INSC_ESTADUAL').AsString;
    edt_RAZAO_SOCIAL.Text 	  := FTrocaEmpresa.GetQuery.FieldByName('RAZAO_SOCIAL').AsString;
    edt_FANTASIA.Text 	      := FTrocaEmpresa.GetQuery.FieldByName('FANTASIA').AsString;
    edt_RAZAO_SOCIAL_NFE.Text := FTrocaEmpresa.GetQuery.FieldByName('RAZAO_SOCIAL_NFE').AsString;
    edt_CEP.Text 		      	  := FTrocaEmpresa.GetQuery.FieldByName('CEP').AsString;
    edt_ENDERECO.Text         := FTrocaEmpresa.GetQuery.FieldByName('ENDERECO').AsString;
    edt_BAIRRO.Text           := FTrocaEmpresa.GetQuery.FieldByName('BAIRRO').AsString;
    edt_CIDADE_ID.Text        := FTrocaEmpresa.GetQuery.FieldByName('CIDADE_ID').AsString;
    edt_NOME_CIDADE.Text 		  := FTrocaEmpresa.GetQuery.FieldByName('NOME').AsString;
    edt_ESTADO_ID.Text	   	  := FTrocaEmpresa.GetQuery.FieldByName('ESTADO_ID').AsString;
    edt_DDD.Text 			        := FTrocaEmpresa.GetQuery.FieldByName('DDD').AsString;
    edt_FONE_VOZ.Text 		    := FTrocaEmpresa.GetQuery.FieldByName('FONE_VOZ').AsString;
    edt_FONE_FAX.Text 		    := FTrocaEmpresa.GetQuery.FieldByName('FONE_FAX').AsString;
    edt_FONE_DADOS.Text       := FTrocaEmpresa.GetQuery.FieldByName('FONE_DADOS').AsString;
    edt_E_MAIL.Text           := FTrocaEmpresa.GetQuery.FieldByName('E_MAIL').AsString;
    edt_FONE_WHATSAPP.Text    := FTrocaEmpresa.GetQuery.FieldByName('FONE_WHATSAPP').AsString;

end;

procedure TConsultaTrocaEmpresa.AtualizarEmpresaStatus(const AEmpresaID: string; const AStatus: string);
begin
  FBancoUpdate.SetSQL('UPDATE EMPRESAS SET STATUS = :PSTATUS WHERE EMPRESA_ID = :PID');
  FBancoUpdate.AddParam('PSTATUS', AStatus);
  FBancoUpdate.AddParam('PID', AEmpresaID);
  FBancoUpdate.ExecutarComando;
end;

end.

