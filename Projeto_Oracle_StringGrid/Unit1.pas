unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  DBAccess, Ora, MemDS, OraSmart, OraCall, OraClasses, System.IniFiles, Data.DB;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    btnCarregar: TButton;
    btnExportar: TButton;
    btnAdicionar: TButton;
    edtNome: TEdit;
    edtCidade: TEdit;
    OraSession1: TOraSession;
    OraQuery1: TOraQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
  private
    procedure ConfigurarStringGrid;
    procedure CarregarConfiguracao;
    procedure ExportarParaCSV(const FileName: string);
    procedure AdicionarCliente(const Nome, Cidade: string);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ConfigurarStringGrid;
begin
  StringGrid1.FixedRows := 1;
  StringGrid1.DefaultColWidth := 120;
  StringGrid1.Options := StringGrid1.Options + [goRowSelect, goColSizing];
end;

procedure TForm1.CarregarConfiguracao;
var
  ini: TIniFile;
  iniPath: string;
begin
  iniPath := ExtractFilePath(Application.ExeName) + 'config.ini';
  if not FileExists(iniPath) then
    raise Exception.Create('Arquivo config.ini não encontrado!');
  ini := TIniFile.Create(iniPath);
  try
    OraSession1.Username := ini.ReadString('Oracle', 'User', '');
    OraSession1.Password := ini.ReadString('Oracle', 'Password', '');
    OraSession1.Server := ini.ReadString('Oracle', 'Server', '');
    OraSession1.LoginPrompt := False;
  finally
    ini.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ConfigurarStringGrid;
  CarregarConfiguracao;
end;

procedure TForm1.btnCarregarClick(Sender: TObject);
var
  i, row: Integer;
begin
  OraQuery1.Session := OraSession1;
  OraQuery1.SQL.Text := 'SELECT ID, NOME, CIDADE FROM CLIENTES1';
  OraQuery1.Open;

  StringGrid1.RowCount := OraQuery1.RecordCount + 1;
  StringGrid1.ColCount := OraQuery1.FieldCount;

  for i := 0 to OraQuery1.FieldCount - 1 do
    StringGrid1.Cells[i, 0] := OraQuery1.Fields[i].FieldName;

  row := 1;
  while not OraQuery1.Eof do
  begin
    for i := 0 to OraQuery1.FieldCount - 1 do
      StringGrid1.Cells[i, row] := OraQuery1.Fields[i].AsString;
    Inc(row);
    OraQuery1.Next;
  end;
end;

procedure TForm1.ExportarParaCSV(const FileName: string);
var
  f: TextFile;
  i, j: Integer;
  linha: string;
begin
  AssignFile(f, FileName);
  Rewrite(f);
  try
    for j := 0 to StringGrid1.RowCount - 1 do
    begin
      linha := '';
      for i := 0 to StringGrid1.ColCount - 1 do
      begin
        linha := linha + StringGrid1.Cells[i, j];
        if i < StringGrid1.ColCount - 1 then
          linha := linha + ';';
      end;
      Writeln(f, linha);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.btnExportarClick(Sender: TObject);
begin
  ExportarParaCSV(ExtractFilePath(Application.ExeName) + 'clientes_exportados.csv');
  ShowMessage('Dados exportados para clientes_exportados.csv');
end;

procedure TForm1.AdicionarCliente(const Nome, Cidade: string);
begin
  OraQuery1.SQL.Text := 'INSERT INTO CLIENTES1 (NOME, CIDADE) VALUES (:NOME, :CIDADE)';
  OraQuery1.ParamByName('NOME').AsString := Nome;
  OraQuery1.ParamByName('CIDADE').AsString := Cidade;
  OraQuery1.Execute;
end;

procedure TForm1.btnAdicionarClick(Sender: TObject);
begin
  if (Trim(edtNome.Text) = '') or (Trim(edtCidade.Text) = '') then
  begin
    ShowMessage('Preencha Nome e Cidade');
    Exit;
  end;
  AdicionarCliente(edtNome.Text, edtCidade.Text);
  ShowMessage('Cliente adicionado com sucesso!');
  btnCarregarClick(Sender); // Atualiza a grid
end;

end.
