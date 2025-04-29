unit unit_dados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI, classe.conexao,  unit_profissionais,
  classe.profissionais, classe.usuarios;

type
  Tform_dados = class(TDataModule)
    FDConnection: TFDConnection;
    MySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FProfissional : TProfissionais;
  public
    { Public declarations }
    Conexao : Tconexao;
    Usuarios : TUsuarios;
    function GetProfissional(): TProfissionais;

  end;

var
  form_dados: Tform_dados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tform_dados.DataModuleCreate(Sender: TObject);
begin
  Conexao := Tconexao.Create ( FDConnection );
  Usuarios := TUsuarios.Create ( form_dados.FDConnection );
 // GetProfissional();

end;

procedure Tform_dados.DataModuleDestroy(Sender: TObject);
begin
   Conexao.Destroy;
   Usuarios.Destroy;
   if Assigned(FProfissional) then
   begin
     FProfissional.Destroy;
   end;
end;

function Tform_dados.GetProfissional(): TProfissionais;
begin
  if Assigned(FProfissional) then
  begin
    Result := FProfissional;
    Exit;
  end;

  FProfissional := TProfissionais.Create(Self.FDConnection);
  Result := FProfissional;
end;

end.
