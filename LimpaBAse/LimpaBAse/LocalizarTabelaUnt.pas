unit LocalizarTabelaUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Grids, ValEdit, StdCtrls, ExtCtrls, Vcl.ComCtrls,
  IniFiles, System.UITypes;

type
  TLocalizarTabelaFrm = class(TForm)
    LocalizarEdt: TEdit;
    TipoPesqRdGrp: TRadioGroup;
    TabelasGrd: TStringGrid;
    CorSelShp: TShape;
    LegSelLbl: TLabel;
    CorSelCascShp: TShape;
    LegSelCascLbl: TLabel;
    ColorDialog: TColorDialog;
    procedure LocalizarEdtChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabelasGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CorSelShpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CorSelCascShpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure TabelasGrdDblClick(Sender: TObject);
    procedure TipoPesqRdGrpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations}
    ConfigIni: TMemIniFile;
    Tabelas: TStringList;
    function RetornaTabelasLocalizadas(Lista: TStringList; S: string;
                                       SomenteInicio: Boolean): TStringList;
    function PretoOuBranco(Cor: TColor): TColor;
  public
    { Public declarations }
    procedure AddTabela(Tabela: String);
    procedure MarcarDesmarcarTabela(Tabela: String; Valor: Boolean;
                                    Marcador: String; TabIndex: Integer);
  end;

var
  LocalizarTabelaFrm: TLocalizarTabelaFrm;

implementation

{$R *.dfm}
uses
  LimpaBaseUnt;
procedure TLocalizarTabelaFrm.AddTabela(Tabela: String);
{Adiciona tabela à Tabelas.}
begin
  if Tabelas = nil then
    begin
      Tabelas:= TStringList.Create;
    end;
  Tabelas.Add(Tabela);
end;

procedure TLocalizarTabelaFrm.LocalizarEdtChange(Sender: TObject);
{Localiza texto digitado em TabelasGrd.}
var
  TipoPesq: Boolean;
  TabLoc: TStringList;
begin
  TipoPesq:= TipoPesqRdGrp.ItemIndex = 1;
  TabLoc:= RetornaTabelasLocalizadas(Tabelas, LocalizarEdt.Text, TipoPesq);
  TabelasGrd.Cols[0].Clear;
  TabelasGrd.RowCount:= TabLoc.Count;
  TabelasGrd.Cols[0].AddStrings(TabLoc);
end;

procedure TLocalizarTabelaFrm.MarcarDesmarcarTabela(Tabela: String;
                          Valor: Boolean; Marcador: String; TabIndex: Integer);
{Marca/Desmarca Tabela.}
begin
  if Valor then
    begin
          Tabelas[TabIndex]:= Tabela + Marcador;
    end
  else
    begin
          Tabelas[TabIndex]:= Tabela;
    end;
end;

function TLocalizarTabelaFrm.PretoOuBranco(Cor: TColor): TColor;
{Retorna Preto ou Branco em contraste com a cor informada.}
var
R, G, B: Byte;
begin
  R := GetRValue(Cor);
  G := GetGValue(Cor);
  B := GetBValue(Cor);
  if (r+g+b <= 255) and ((r+g < 255) or (g+b < 255) or (b+r < 255)) then
    begin
      Result:= clWhite;
    end
  else
    begin
      Result:= clBlack;
    end;
end;

procedure TLocalizarTabelaFrm.CorSelCascShpMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{Chama ColorDialog para escolher a cor pinta CorSelCascShp e grava no arquivo
de configuração como preferência.}
begin
  ColorDialog.Color:= CorSelCascShp.Brush.Color;
  if ColorDialog.Execute then
    begin
      CorSelCascShp.Brush.Color:= ColorDialog.Color;
      ConfigIni.WriteInteger('Preferencias','CorTabelaSelecionadaCascata',
                              CorSelCascShp.Brush.Color);
      ConfigIni.UpdateFile;
      TabelasGrd.Repaint;
    end;
end;

procedure TLocalizarTabelaFrm.CorSelShpMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{Chama ColorDialog para escolher a cor pinta CorSelShp e grava no arquivo
de configuração como preferência.}
begin
  ColorDialog.Color:= CorSelShp.Brush.Color;
  if ColorDialog.Execute then
    begin
      CorSelShp.Brush.Color:= ColorDialog.Color;
      ConfigIni.WriteInteger('Preferencias','CorTabelaSelecionada',
                              CorSelShp.Brush.Color);
      ConfigIni.UpdateFile;
      TabelasGrd.Repaint;
    end;
end;

procedure TLocalizarTabelaFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
{Ao sair apaga texto de LocalizarEdt.}
begin
  LocalizarEdt.Text:='';
  LocalizarEdtChange(LocalizarEdt);
end;

procedure TLocalizarTabelaFrm.FormCreate(Sender: TObject);
begin
  try
    ConfigIni:= TMemIniFile.Create(Application.ExeName.Replace('.exe','.ini'));
    CorSelShp.Brush.Color:= ConfigIni.ReadInteger('Preferencias',
                                  'CorTabelaSelecionada',CorSelShp.Brush.Color);
    CorSelCascShp.Brush.Color:= ConfigIni.ReadInteger('Preferencias',
                        'CorTabelaSelecionadaCascata',CorSelCascShp.Brush.Color);
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TLocalizarTabelaFrm.FormShow(Sender: TObject);
{Foco em LocalizarEdt ao chamar Form.}
begin
  LocalizarEdt.SetFocus;
  LocalizarEdt.Text:= '';
  LocalizarEdtChange(LocalizarEdt);
end;

function TLocalizarTabelaFrm.RetornaTabelasLocalizadas(Lista : TStringList;
                              S: string; SomenteInicio : Boolean): TStringList;
var
  Temp : string;
  I : Integer;
begin
  S := UpperCase(S);
  Result:= TStringList.Create;
  for I := 0 to Lista.Count - 1 do
  begin
    Temp := UpperCase(Lista[I]);
    if SomenteInicio then
    begin
      if S = Copy(Temp, 1, Length(S)) then
        Result.Add(Lista[I]);
    end else
      if Pos(S, Temp) > 0 then
        Result.Add(Lista[I]);
  end;
  Result.Sort;
end;

procedure TLocalizarTabelaFrm.TabelasGrdDblClick(Sender: TObject);
{Encontra página referente à tabela em LimpaBaseFrm.}
var
  PageIndex: Integer;
begin
  PageIndex:= Tabelas.IndexOf(TabelasGrd.Cells[0,TabelasGrd.Row]);
  LimpaBaseFrm.TabelasPgCtrl.ScrollTabs(PageIndex);
  LimpaBaseFrm.TabelasPgCtrl.ActivePageIndex:= PageIndex;
  Close;
end;

procedure TLocalizarTabelaFrm.TabelasGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
{Trata cores de linha e fonte do componente TabelasGrd.}
begin
  if TabelasGrd.Cells[0, ARow].IndexOf('**') > -1 then
    begin
      TabelasGrd.Canvas.Brush.Color:= CorSelCascShp.Brush.Color;
      TabelasGrd.Canvas.Font.Color:= PretoOuBranco(CorSelCascShp.Brush.Color);
    end
  else if TabelasGrd.Cells[0, ARow].IndexOf('*') > -1 then
    begin
      TabelasGrd.Canvas.Brush.Color:= CorSelShp.Brush.Color;
      TabelasGrd.Canvas.Font.Color:= PretoOuBranco(CorSelShp.Brush.Color);
    end
  else
    begin
      TabelasGrd.Canvas.Brush.Color:= clWhite;
      TabelasGrd.Canvas.Font.Color:= clBlack;
    end;
  if TabelasGrd.Row = ARow then
    begin
      TabelasGrd.Canvas.Brush.Color:= clMenuHighlight;
      TabelasGrd.Canvas.Font.Color:= clWhite;
    end;
  TabelasGrd.canvas.fillRect(Rect);
  TabelasGrd.canvas.TextOut(Rect.Left + TabelasGrd.Margins.Left,Rect.Top
                             + TabelasGrd.Margins.Top, TabelasGrd.Cells[ACol,ARow]);
end;

procedure TLocalizarTabelaFrm.TipoPesqRdGrpClick(Sender: TObject);
{Ao selecionar tipo de pesquisa apaga LocalizarEdt.}
begin
  LocalizarEdt.SetFocus;
  LocalizarEdt.Text:='';
  LocalizarEdtChange(LocalizarEdt);
end;

end.
