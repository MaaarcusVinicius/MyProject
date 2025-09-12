unit unit_principalDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript, OraScript, Data.DB, DBAccess,
  Ora, MemDS, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  Tform_principalDados = class(TForm)
    pnl_fundo: TPanel;
    dbEmpresas: TDBGrid;
    OraData: TOraDataSource;
    qryEmpresas: TOraQuery;
    qryEmpresasEMPRESA_ID: TStringField;
    qryEmpresasRAZAO_SOCIAL: TStringField;
    qryEmpresasFANTASIA: TStringField;
    qryEmpresasATIVO: TStringField;
    qryEmpresasQTD_PRODUTOS_EMPRESA: TFloatField;
    qryEmpresasQTD_CADASTROS: TFloatField;
    qryEmpresasQTD_FINANCEIRO_EMPRESA: TFloatField;
    qryEmpresasQTD_ESTOQUE_EMPRESA: TFloatField;
    ds_deletandoEmpresa: TOraDataSource;
    qry_deletandoEmpresas: TOraQuery;
    field_deletandoEmpresasSCRIPT: TStringField;
    OraScriptDeletandoEmpresa: TOraScript;
    procedure btn_frmEmpresasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_principalDados: Tform_principalDados;

implementation

uses
  uDataModule,_Biblioteca, VarGlobal, unit_mensagens;

{$R *.dfm}

procedure Tform_principalDados.btn_frmEmpresasClick(Sender: TObject);
begin
  qryEmpresas.Open;
end;

procedure Tform_principalDados.FormCreate(Sender: TObject);
begin
    qryEmpresas.Open;
end;

end.
