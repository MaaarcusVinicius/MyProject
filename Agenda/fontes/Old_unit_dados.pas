unit unit_dados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI, classe.conexao;

type
  Tform_dados = class(TDataModule)
    FDConnection: TFDConnection;
    MySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    Conexao : Tconexao;

  end;

var
  form_dados: Tform_dados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tform_dados.DataModuleCreate(Sender: TObject);
begin
  Conexao := Tconexao.Create ( FDConnection );

end;

procedure Tform_dados.DataModuleDestroy(Sender: TObject);
begin
   Conexao.Destroy;

end;


end.
