unit unit_empresasDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript, OraScript, Data.DB, DBAccess,
  Ora, MemDS, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, unit_funcoes,
  Vcl.StdCtrls, Vcl.Mask;

type
  Tform_empresaDados = class(TForm)
    pnl_fundo: TPanel;
    dbGrid_QryaAuxEmpresas: TDBGrid;
    qry_trocandoEmpresas: TOraQuery;
    StringField1: TStringField;
    OraScriptTrocandoEmpresas: TOraScript;
    ds_trocandoEmpresas: TOraDataSource;
    qry_deletandoEmpresas: TOraQuery;
    field_deletandoEmpresasSCRIPT: TStringField;
    OraScriptDeletandoEmpresa: TOraScript;
    ds_deletandoEmpresa: TOraDataSource;
    pnl_deletandoEmpresas: TPanel;
    btn_deletandoEmpresas: TSpeedButton;
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
    pnl_trocandoEmpresas: TPanel;
    btn_trocandoEmpresas: TSpeedButton;
    medt_cpf_cnpj: TMaskEdit;
    lbl_trocaEmpresa: TLabel;
    procedure btn_deletandoEmpresasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_trocandoEmpresasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_empresaDados: Tform_empresaDados;
implementation

{$R *.dfm}

uses Principal;

procedure Tform_empresaDados.btn_deletandoEmpresasClick(Sender: TObject);
var
  vEmpresa_id: String;
  vRazaoSocial: string;
  saveScriptOracle: TStringList;

begin
  vEmpresa_id := qryEmpresas.FieldByName('EMPRESA_ID').AsString;
  vRazaoSocial := qryEmpresas.FieldByName('RAZAO_SOCIAL').AsString;
  saveScriptOracle:= TStringList.Create;
  // <-- IMPORTANTE: setar o parâmetro ANTES de abrir a query geradora
  qry_deletandoEmpresas.Close;
  qry_deletandoEmpresas.ParamByName('pEMPRESA_ID').AsString := '''' + vEmpresa_id + '''';
  qry_deletandoEmpresas.Open;

  OraScriptDeletandoEmpresa.SQL.Clear;
  qry_deletandoEmpresas.First;
  while not qry_deletandoEmpresas.Eof do
  begin
    OraScriptDeletandoEmpresa.SQL.Add(qry_deletandoEmpresas.FieldByName('SCRIPT').AsString);
    qry_deletandoEmpresas.Next;
  end;

  // debug rápido: ver o que foi gerado
 //ShowMessage('Scripts gerados:' + sLineBreak + OraScriptDeletandoEmpresa.SQL.Text);


     if not( OraScriptDeletandoEmpresa.SQL.IsEmpty ) then

      begin
        fnc_criar_menssagem('EXCLUSÃO DE EMPRESA',
                            'DESEJA REALMENTE EXCLUIR ESTA EMPRESA?' ,
                            'Você selecionou a empresa: ' + vEmpresa_id +' - ' + vRazaoSocial +
                            '. ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                            ExtractFilePath(Application.ExeName ) + 'Arquivos\icones\HumanoDelete.png',
                           'ERRO')  ;
         // tratar, quando o usuario dar não , ele da o exit no processo
      end else
      exit;

  // Comando que executa o Script para deletar a empresa     @@@ TEMPORARIO SUSPESO @@@
  try
    OraScriptDeletandoEmpresa.Execute;
  finally
     begin
       fnc_criar_menssagem('EXCLUSÃO DE EMPRESA',
                           'A EXCLUSÃO DA EMPRESA FOI UM SUCESSO !!' ,
                           'Você selecionou a empresa: ' + vEmpresa_id +' - ' + vRazaoSocial +
                           '. AÇÃO É IRREVERSÍVEL!!!',
                           ExtractFilePath(Application.ExeName ) + 'Arquivos\icones\HumanoConfirma.png',
                           'OK')  ;

     end;
  end;

  // CRIA O SCRIPT PARA SALVAR OS COMANDOS EXECUTADOS DO DELETE
  try
    saveScriptOracle.Text := OraScriptDeletandoEmpresa.SQL.Text;
    saveScriptOracle.SaveToFile('C:\sqlExport.txt', TEncoding.UTF8); // ou TEncoding.ANSI se preferir
  finally
    saveScriptOracle.Free;
  end;

end;


procedure Tform_empresaDados.btn_trocandoEmpresasClick(Sender: TObject);
var
  vEmpresa_id: String;
  vRazaoSocial: string;
  newEmpresa_id: String;
  newCnpj : String;
  returnUsuario : Boolean;

begin

  newCnpj :=  fnc_sonumeros(medt_cpf_cnpj.Text);

 if (newCnpj <> '') and (Length(newCnpj) = 14) then
     begin

      vEmpresa_id := qryEmpresas.FieldByName('EMPRESA_ID').AsString;
      vRazaoSocial := qryEmpresas.FieldByName('RAZAO_SOCIAL').AsString;
      newEmpresa_id := medt_cpf_cnpj.Text;

      // <-- IMPORTANTE: setar o parâmetro ANTES de abrir a query geradora
      qry_trocandoEmpresas.Close;
      qry_trocandoEmpresas.ParamByName('pEMPRESA_ID').AsString := '''' + vEmpresa_id + '''';
      qry_trocandoEmpresas.ParamByName('vEMPRESA_ID').AsString := '''' + newEmpresa_id + '''';
      qry_trocandoEmpresas.Open;

      OraScriptDeletandoEmpresa.SQL.Clear;
      qry_trocandoEmpresas.First;
      while not qry_trocandoEmpresas.Eof do
      begin
        OraScriptTrocandoEmpresas.SQL.Add(qry_trocandoEmpresas.FieldByName('SCRIPT').AsString);
        qry_trocandoEmpresas.Next;
      end;

      // debug rápido: ver o que foi gerado
     // ShowMessage('Scripts gerados:' + sLineBreak + OraScriptTrocandoEmpresas.SQL.Text);


      if not( OraScriptTrocandoEmpresas.SQL.IsEmpty ) then

      begin
      returnUsuario := fnc_criar_menssagem('ALTERAÇÃO DE EMPRESA aureo',
                            'DESEJA REALMENTE TROCARO CNPJ DESTA EMPRESA?' ,
                            'Você selecionou a empresa: ' + vEmpresa_id +' - ' + vRazaoSocial +
                            '. ESTA AÇÃO NÃO PODERÁ SER REVERTIDA.',
                            ExtractFilePath(Application.ExeName ) + 'Arquivos\icones\HumanoDelete.png',
                           'ERRO')  ;



         // tratar, quando o usuario dar não , ele da o exit no processo
      end ;

  // Comando que executa o Script para Alterar a empresa
      if returnUsuario then
        try
          OraScriptTrocandoEmpresas.Execute;
        finally
           begin
             fnc_criar_menssagem('ALTERAÇÃO DE EMPRESA',
                                 'A ALTERAÇÃO DA EMPRESA FOI UM SUCESSO !!' ,
                                 'Você alterou o CNPJ da empresa: ' + vEmpresa_id +' - ' + vRazaoSocial +
                                 ', para o novo CNPJ: ' + newEmpresa_id,
                                 ExtractFilePath(Application.ExeName ) + 'Arquivos\icones\HumanoConfirma.png',
                                 'OK')  ;
           end;
        end
        else Abort;

     end
 else
     begin
       fnc_criar_menssagem('TROCA EMPRESA',
                           'PARA EXECUTAR O PROCEDIMENTO, INFORME O NOVO CNPJ!',
                           'O NOVO CNPJ PODE ESTAR VAZIO OU INCOMPLETO.',
                           ExtractFilePath(Application.ExeName ) + 'Arquivos\icones\HumanoAviso.png',
                           'OK')  ;
       medt_cpf_cnpj.setfocus;

     end;


end;

procedure Tform_empresaDados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // Quando destruir o formulario o DbGrid da tela principal vai ser atualizado  ( dbPrincipalEmpresas )
  Principal.frmPrincipal.qryEmpresas.Close;
  Principal.frmPrincipal.qryEmpresas.Open;
end;

procedure Tform_empresaDados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) AND ( Key = VK_F4) then
    form_empresaDados.Close;

  if Key = VK_ESCAPE then
    form_empresaDados.Close;
end;

end.
