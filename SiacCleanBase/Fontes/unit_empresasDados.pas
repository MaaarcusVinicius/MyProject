unit unit_empresasDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript,
  OraScript, Data.DB, DBAccess, Ora, MemDS, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, unit_funcoes, Vcl.StdCtrls, Vcl.Mask;

type
  Tform_empresaDados = class(TForm)
    pnl_fundo: TPanel;
    qry_trocandoEmpresas: TOraQuery;
    StringField1: TStringField;
    OraScriptTrocandoEmpresas: TOraScript;
    ds_trocandoEmpresas: TOraDataSource;
    qry_deletandoEmpresas: TOraQuery;
    field_deletandoEmpresasSCRIPT: TStringField;
    OraScriptDeletandoEmpresa: TOraScript;
    ds_deletandoEmpresa: TOraDataSource;
    qryEmpresas: TOraQuery;
    qryEmpresasEMPRESA_ID: TStringField;
    qryEmpresasRAZAO_SOCIAL: TStringField;
    qryEmpresasFANTASIA: TStringField;
    qryEmpresasATIVO: TStringField;
    qryEmpresasQTD_PRODUTOS_EMPRESA: TFloatField;
    qryEmpresasQTD_CADASTROS: TFloatField;
    qryEmpresasQTD_FINANCEIRO_EMPRESA: TFloatField;
    qryEmpresasQTD_ESTOQUE_EMPRESA: TFloatField;
    OraData: TOraDataSource;
    dbEmpresas: TDBGrid;
    qry_DeleteTriggers: TOraQuery;
    StringField2: TStringField;
    OraScriptDeleteTriggers: TOraScript;
    ds_DeleteTriggers: TOraDataSource;
    pnl_deletaEmpresa: TPanel;
    pnl_deletandoEmpresas: TPanel;
    btn_deletandoEmpresas: TSpeedButton;
    chk_saveScriptDeletando: TCheckBox;
    pnl_trocandoEmpresa: TPanel;
    pnl_trocandoEmpresas: TPanel;
    btn_trocandoEmpresas: TSpeedButton;
    medt_cpf_cnpj: TMaskEdit;
    lbl_trocaEmpresa: TLabel;
    chk_saveScritpTrocando: TCheckBox;
    pnl_deleteTriggers: TPanel;
    Panel2: TPanel;
    btn_deleteTriggers: TSpeedButton;
    Panel1: TPanel;
    chk_desativarObjetos: TCheckBox;
    procedure btn_deletandoEmpresasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_trocandoEmpresasClick(Sender: TObject);
    procedure btn_deleteTriggersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_empresaDados: Tform_empresaDados;

implementation

{$R *.dfm}

uses
  Principal,
  uDataModule,
  unit_ProgressBar,
  unit_ProgressHelper,
  classe.uScriptGeneratorDeleteEmpresas,
  classe.uScriptGeneratorTriggers,
  classe.uScriptGeneratorTrocaEmpresas;

procedure Tform_empresaDados.btn_deletandoEmpresasClick(Sender: TObject);
var
  ScriptGen: TScriptGeneratorDeleteEmpresas;
  returnUsuario: Boolean;
  saveScriptOracle: TStringList;
  Scripts: TStringList;
  Progress: TProgressHelper;
  i: Integer;
  vEmpresa_id, vRazaoSocial: string;
begin
  vEmpresa_id :=  qryEmpresas.FieldByName('EMPRESA_ID').AsString ;
  vRazaoSocial := qryEmpresas.FieldByName('RAZAO_SOCIAL').AsString;

  ScriptGen := TScriptGeneratorDeleteEmpresas.Create(DmModule.orsConexao);
  Scripts := TStringList.Create;
  Progress := TProgressHelper.Create;
  try
    // 1 - Gera os scripts dinamicamente
    ScriptGen.Gerar('''' + vEmpresa_id+ '''');

    // Copia os scripts para lista temporária
    Scripts.Text := ScriptGen.GetScripts;

    // 2 - Mostra progress bar durante a geração
    Progress.Start(Scripts.Count, 'Gerando scripts para exclusão...');
    for i := 0 to Scripts.Count - 1 do
    begin
      Progress.Step('Gerando: ' + Scripts[i]);
    end;
    Progress.Finish;

    // 3 - Confirmação do usuário
    if Scripts.Count = 0 then Exit;

    returnUsuario := fnc_criar_menssagem(
                        'EXCLUSÃO DE EMPRESA',
                        vEmpresa_id + ' - ' + vRazaoSocial,
                        'DESEJA REALMENTE EXCLUIR ESTA EMPRESA? ' + sLineBreak +
                        'ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                        'ERRO');

    if not returnUsuario then Exit;

    // 4 - Executa os scripts individualmente
    Progress.Start(Scripts.Count, 'Executando exclusão da empresa...');
    for i := 0 to Scripts.Count - 1 do
    begin
      OraScriptDeletandoEmpresa.SQL.Text := Scripts[i];
      OraScriptDeletandoEmpresa.Execute;

      Progress.Step('Executando: ' + Scripts[i]);
    end;
    Progress.Finish;

    // 5 - Mensagem final de sucesso
    fnc_criar_menssagem('EXCLUSÃO DE EMPRESA',
                        'A EXCLUSÃO DA EMPRESA FOI UM SUCESSO !!!',
                        'Você selecionou a empresa: ' + vEmpresa_id + ' - ' + vRazaoSocial +
                        '. ESTA AÇÃO É IRREVERSÍVEL!!!',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                        'OK');

    // 6 - Salvar script se marcado
    if chk_saveScriptDeletando.Checked then
    begin
      saveScriptOracle := TStringList.Create;
      try
        saveScriptOracle.Text := Scripts.Text;
        saveScriptOracle.SaveToFile('C:\sqlExport_DeleteEmpresa.txt', TEncoding.UTF8);
      finally
        saveScriptOracle.Free;
      end;
    end;

  finally
    Scripts.Free;
    ScriptGen.Free;
    Progress.Free;
  end;
end;



procedure Tform_empresaDados.btn_deleteTriggersClick(Sender: TObject);
var
  ScriptGen: TScriptGeneratorTriggers;
  returnUsuario: Boolean;
  saveScriptOracle: TStringList;
  Scripts: TStringList;
  Progress: TProgressHelper;
  i: Integer;
begin
  ScriptGen := TScriptGeneratorTriggers.Create(DmModule.orsConexao); // já vem com SQL configurado
  Scripts := TStringList.Create;
  Progress := TProgressHelper.Create;

  try
    // 1 - Gera os scripts dinamicamente
    // Passa para classe o nome do usuario logado
    ScriptGen.Gerar(Principal.frmPrincipal.eUsuario.Text);

    // Copia os scripts para o TStringList temporário
    Scripts.Text := ScriptGen.GetScripts;

    // 2 - Mostra progress bar durante a geração
    Progress.Start(Scripts.Count, 'Gerando scripts...');
    for i := 0 to Scripts.Count - 1 do
    begin
      Progress.Step('Gerando: ' + Scripts[i]);
    end;
    Progress.Finish;

    // 3 - Confirmação do usuário antes de executar
    if Scripts.Count = 0 then Exit;

    returnUsuario := fnc_criar_menssagem('ALTERAÇÃO DE OBJETOS DO BANCO DE DADOS',
                                         'DESEJA REALMENTE DESATIVAR OS OBJETOS?',
                                         'ESTE PROCEDIMENTO É REVERSÍVEL',
                                         ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                                         'ERRO');

    if not returnUsuario then Exit;

    // 4 - Limpa o OraScript antes de executar
    OraScriptDeleteTriggers.SQL.Clear;

    // 5 - Inicializa o ProgressBar para execução real
    Progress.Start(Scripts.Count, 'Executando scripts...');

    // 6 - Executa cada script individualmente
    for i := 0 to Scripts.Count - 1 do
    begin
      OraScriptDeleteTriggers.SQL.Text := Scripts[i];
      OraScriptDeleteTriggers.Execute;

      // Atualiza ProgressBar com a informação atual
      Progress.Step('Executando: ' + Scripts[i]);
    end;

    Progress.Finish;

    // 7 - Mensagem de sucesso
    fnc_criar_menssagem('ALTERAÇÃO DE OBJETOS DO BANCO DE DADOS',
                        'OS OBJETOS DO BANCO DE DADOS FORAM DESATIVADOS !!',
                        'TRIGGER''s E CONSTRAINTS FORAM DESATIVADAS',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                        'OK');

    // 8 - Salva script em arquivo opcional
    if chk_desativarObjetos.Checked then
    begin
      saveScriptOracle := TStringList.Create;
      try
        saveScriptOracle.Text := Scripts.Text;
        saveScriptOracle.SaveToFile('C:\sqlExport_DesativarTriggers.txt', TEncoding.UTF8);
      finally
        saveScriptOracle.Free;
      end;
    end;

  finally
    Scripts.Free;
    ScriptGen.Free;
    Progress.Free;
  end;
end;

procedure Tform_empresaDados.btn_trocandoEmpresasClick(Sender: TObject);
var
  ScriptGen: TScriptGeneratorTrocaEmpresa;
  returnUsuario: Boolean;
  saveScriptOracle: TStringList;
  Scripts: TStringList;
  Progress: TProgressHelper;
  i: Integer;
  vEmpresa_id, vRazaoSocial, newEmpresa_id, newCnpj: string;
begin
  newCnpj := fnc_sonumeros(medt_cpf_cnpj.Text);

  if (newCnpj <> '') and (Length(newCnpj) = 14) then
  begin
    vEmpresa_id   := qryEmpresas.FieldByName('EMPRESA_ID').AsString;
    vRazaoSocial  := qryEmpresas.FieldByName('RAZAO_SOCIAL').AsString;
    newEmpresa_id := medt_cpf_cnpj.Text;

    ScriptGen := TScriptGeneratorTrocaEmpresa.Create(DmModule.orsConexao);
    Scripts   := TStringList.Create;
    Progress  := TProgressHelper.Create;
    try
      // 1 - Gera os scripts dinamicamente
      ScriptGen.Gerar('''' + vEmpresa_id + '''', '''' + newEmpresa_id + '''');

      // Copia os scripts para lista temporária
      Scripts.Text := ScriptGen.GetScripts;

      // 2 - Mostra progress bar durante a geração
      Progress.Start(Scripts.Count, 'Gerando scripts de troca...');
      for i := 0 to Scripts.Count - 1 do
      begin
        Progress.Step('Gerando: ' + Scripts[i]);
      end;
      Progress.Finish;

      // 3 - Confirmação do usuário
      if Scripts.Count = 0 then Exit;

      returnUsuario := fnc_criar_menssagem(
                          'ALTERAÇÃO DE EMPRESA',
                          vEmpresa_id + ' - ' + vRazaoSocial,
                          'DESEJA REALMENTE ALTERAR O CNPJ DA EMPRESA?' + sLineBreak +
                          'ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                          ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoDelete.png',
                          'ERRO');

      if not returnUsuario then Exit;

      // 4 - Executa os scripts individualmente
      Progress.Start(Scripts.Count, 'Executando alteração da empresa...');
      for i := 0 to Scripts.Count - 1 do
      begin
        OraScriptTrocandoEmpresas.SQL.Text := Scripts[i];
        OraScriptTrocandoEmpresas.Execute;

        Progress.Step('Executando: ' + Scripts[i]);
      end;
      Progress.Finish;

      // 5 - Mensagem final de sucesso
      fnc_criar_menssagem('ALTERAÇÃO DE EMPRESA',
                          'A ALTERAÇÃO DA EMPRESA FOI UM SUCESSO !!!',
                          'Você alterou o CNPJ da empresa: ' + vEmpresa_id + ' - ' + vRazaoSocial +
                          ', para o novo CNPJ: ' + newEmpresa_id,
                          ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoConfirma.png',
                          'OK');

      // 6 - Salvar script se marcado
      if chk_saveScritpTrocando.Checked then
      begin
        saveScriptOracle := TStringList.Create;
        try
          saveScriptOracle.Text := Scripts.Text;
          saveScriptOracle.SaveToFile('C:\sqlExport_TrocaEmpresa.txt', TEncoding.UTF8);
        finally
          saveScriptOracle.Free;
        end;
      end;

    finally
      Scripts.Free;
      ScriptGen.Free;
      Progress.Free;
    end;
  end
  else
  begin
    fnc_criar_menssagem('TROCA EMPRESA',
                        'PARA EXECUTAR O PROCEDIMENTO, INFORME O NOVO CNPJ!',
                        'O NOVO CNPJ ESTÁ VAZIO OU INCOMPLETO.',
                        ExtractFilePath(Application.ExeName) + 'Arquivos\icones\HumanoAviso.png',
                        'OK');
    medt_cpf_cnpj.SetFocus;
  end;
end;



procedure Tform_empresaDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Quando destruir o formulario o DbGrid da tela principal vai ser atualizado  ( dbPrincipalEmpresas )
  Principal.frmPrincipal.qryEmpresas.Close;
  Principal.frmPrincipal.qryEmpresas.Open;
end;

procedure Tform_empresaDados.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssAlt in Shift) and (Key = VK_F4) then
    form_empresaDados.Close;

  if Key = VK_ESCAPE then
    form_empresaDados.Close;
end;

end.

