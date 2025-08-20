program LimpaBase;





{$R *.dres}

uses
  Forms,
  LimpaBaseUnt in 'LimpaBaseUnt.pas' {LimpaBaseFrm},
  LoginUnt in 'LoginUnt.pas' {LoginFrm},
  BancoDadosUnt in 'BancoDadosUnt.pas' {BancoDadosDtMdl: TDataModule},
  TabelaUnt in 'TabelaUnt.pas' {TabelaFrm: TFrame},
  StatusUnt in 'StatusUnt.pas' {StatusFrm},
  SelecoesUnt in 'SelecoesUnt.pas' {SelecoesFrm},
  MensagensUnt in 'MensagensUnt.pas' {MensagensFrm},
  ConectadosUnt in 'ConectadosUnt.pas' {ConectadosFrm},
  LocalizarTabelaUnt in 'LocalizarTabelaUnt.pas' {LocalizarTabelaFrm},
  SequenciaisUnt in 'SequenciaisUnt.pas' {SequenciaisFrm},
  TrocaEmpresaUnt in 'TrocaEmpresaUnt.pas' {TrocaEmpresaFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Limpa Base';
  Application.CreateForm(TBancoDadosDtMdl, BancoDadosDtMdl);
  Application.CreateForm(TLoginFrm, LoginFrm);
  Application.CreateForm(TStatusFrm, StatusFrm);
  Application.CreateForm(TMensagensFrm, MensagensFrm);
  Application.CreateForm(TSelecoesFrm, SelecoesFrm);
  Application.CreateForm(TLocalizarTabelaFrm, LocalizarTabelaFrm);
  Application.ShowMainForm:=False;
  Application.Run;
end.
