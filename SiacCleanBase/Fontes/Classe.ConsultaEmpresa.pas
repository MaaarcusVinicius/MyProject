unit Classe.ConsultaEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.StrUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,classe.BancoDados;

type
  TConsultaEmpresa = class
  private
    FConsultaEmpresa : TClasseBancoDados;
    FBancoUpdate  : TClasseBancoDados;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AtualizarEmpresaStatus(const AEmpresaID: string; const AStatus: string);

procedure CarregarConsultaEmpresa( const AEmpresaID: string;
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

{ TConsultaEmpresa }

constructor TConsultaEmpresa.Create;
var
  vLogPath: string;
begin
  vLogPath := 'C:\SiacDBManagerLogs\Banco.log';

  if not DirectoryExists(ExtractFilePath(vLogPath)) then
    ForceDirectories(ExtractFilePath(vLogPath));

  FConsultaEmpresa := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoUpdate  := TClasseBancoDados.Create(DmModule.orsConexao);

//  FConsultaEmpresa.EnableLog(vLogPath);
//  FBancoUpdate.EnableLog(vLogPath);
end;

destructor TConsultaEmpresa.Destroy;
begin
  FConsultaEmpresa.Free;
  FBancoUpdate.Free;
  inherited;
end;
procedure TConsultaEmpresa.CarregarConsultaEmpresa( const AEmpresaID: string;
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
  FConsultaEmpresa.SetSQL( ' SELECT E.EMPRESA_ID,              '+
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
  FConsultaEmpresa.AddParam('vEMPRESA_ID', AEmpresaID);

  // Executa a consulta
  FConsultaEmpresa.ExecutarConsulta;

  // Se não houver resultados, limpa os edits
  if FConsultaEmpresa.GetQuery.IsEmpty then
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
    edt_EMPRESA_ID.Text 	    := FConsultaEmpresa.GetQuery.FieldByName('EMPRESA_ID').AsString;
    edt_INSC_MUNICIPAL.Text   := FConsultaEmpresa.GetQuery.FieldByName('INSC_MUNICIPAL').AsString;
    edt_INSC_ESTADUAL.Text    := FConsultaEmpresa.GetQuery.FieldByName('INSC_ESTADUAL').AsString;
    edt_RAZAO_SOCIAL.Text 	  := FConsultaEmpresa.GetQuery.FieldByName('RAZAO_SOCIAL').AsString;
    edt_FANTASIA.Text 	      := FConsultaEmpresa.GetQuery.FieldByName('FANTASIA').AsString;
    edt_RAZAO_SOCIAL_NFE.Text := FConsultaEmpresa.GetQuery.FieldByName('RAZAO_SOCIAL_NFE').AsString;
    edt_CEP.Text 		      	  := FConsultaEmpresa.GetQuery.FieldByName('CEP').AsString;
    edt_ENDERECO.Text         := FConsultaEmpresa.GetQuery.FieldByName('ENDERECO').AsString;
    edt_BAIRRO.Text           := FConsultaEmpresa.GetQuery.FieldByName('BAIRRO').AsString;
    edt_CIDADE_ID.Text        := FConsultaEmpresa.GetQuery.FieldByName('CIDADE_ID').AsString;
    edt_NOME_CIDADE.Text 		  := FConsultaEmpresa.GetQuery.FieldByName('NOME').AsString;
    edt_ESTADO_ID.Text	   	  := FConsultaEmpresa.GetQuery.FieldByName('ESTADO_ID').AsString;
    edt_DDD.Text 			        := FConsultaEmpresa.GetQuery.FieldByName('DDD').AsString;
    edt_FONE_VOZ.Text 		    := FConsultaEmpresa.GetQuery.FieldByName('FONE_VOZ').AsString;
    edt_FONE_FAX.Text 		    := FConsultaEmpresa.GetQuery.FieldByName('FONE_FAX').AsString;
    edt_FONE_DADOS.Text       := FConsultaEmpresa.GetQuery.FieldByName('FONE_DADOS').AsString;
    edt_E_MAIL.Text           := FConsultaEmpresa.GetQuery.FieldByName('E_MAIL').AsString;
    edt_FONE_WHATSAPP.Text    := FConsultaEmpresa.GetQuery.FieldByName('FONE_WHATSAPP').AsString;

end;

procedure TConsultaEmpresa.AtualizarEmpresaStatus(const AEmpresaID: string; const AStatus: string);
begin
  FBancoUpdate.SetSQL('UPDATE EMPRESAS SET STATUS = :PSTATUS WHERE EMPRESA_ID = :PID');
  FBancoUpdate.AddParam('PSTATUS', AStatus);
  FBancoUpdate.AddParam('PID', AEmpresaID);
  FBancoUpdate.ExecutarComando;
end;

end.

