unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm2 = class(TForm)
    dbgrd_oracle: TDBGrid;
    ds_oracle: TOraDataSource;
    orqry_oracle: TOraQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
