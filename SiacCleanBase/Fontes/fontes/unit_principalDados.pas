unit unit_principalDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DAScript, OraScript, Data.DB, DBAccess,
  Ora, MemDS;

type
  Tform_principalDados = class(TForm)
    OraQuery1: TOraQuery;
    OraDataSource1: TOraDataSource;
    OraScript1: TOraScript;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_principalDados: Tform_principalDados;

implementation

{$R *.dfm}

end.
