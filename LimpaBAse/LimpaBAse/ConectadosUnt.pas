unit ConectadosUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, pngimage, ExtCtrls, Vcl.StdCtrls;

type
  TConectadosFrm = class(TForm)
    CancelarImg: TImage;
    OkImg: TImage;
    ConectadosDtSrc: TDataSource;
    ConectadosGrd: TDBGrid;
    Panel: TPanel;
    procedure CancelarImgClick(Sender: TObject);
    procedure OkImgClick(Sender: TObject);
  private
    Confirmado: Boolean;
    { Private declarations }
  public
    { Public declarations }
    function GetConfirmado: Boolean;
    procedure SetConfirmado(B: Boolean);
  end;

var
  ConectadosFrm: TConectadosFrm;

implementation

{$R *.dfm}

uses
  BancoDadosUnt;
procedure TConectadosFrm.CancelarImgClick(Sender: TObject);
{Executa Close.}
begin
  Close;
end;

function TConectadosFrm.GetConfirmado: Boolean;
{Retorna Confirmado.}
begin
  Result:= Confirmado;
end;

procedure TConectadosFrm.OkImgClick(Sender: TObject);
{Atribui True à Confirmado e executa CLose.}
begin
  SetConfirmado(True);
  Close;
end;

procedure TConectadosFrm.SetConfirmado(B: Boolean);
{Atribui valor à Confirmado.}
begin
  Confirmado:= B;
end;

end.
