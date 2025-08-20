unit SequenciaisUnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Grids, Data.DB, System.RegularExpressions, IniFiles, MensagensUnt,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TSequenciaisFrm = class(TForm)
    OkAtuaImg: TImage;
    CancelarAtuaImg: TImage;
    SequenciaisGrd: TStringGrid;
    SequenciaisPgCtrl: TPageControl;
    AtualizacaoTbSt: TTabSheet;
    ConfiguracoesTbSt: TTabSheet;
    ConfigMmo: TMemo;
    OkConfigImg: TImage;
    SelecioneSeqLbl: TLabel;
    SequenciaisDtSrc: TDataSource;
    SequencialLkpCmbx: TDBLookupComboBox;
    RecarregarImg: TImage;
    RecarregarConfigImg: TImage;
    SelecaoSugestaoLbl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SequenciaisGrdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SequenciaisGrdSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure SequencialLkpCmbxClick(Sender: TObject);
    procedure SequenciaisGrdDblClick(Sender: TObject);
    procedure OkConfigImgClick(Sender: TObject);
    procedure RecarregarImgClick(Sender: TObject);
    procedure RecarregarConfigImgClick(Sender: TObject);
    procedure OkAtuaImgClick(Sender: TObject);
    procedure CancelarAtuaImgClick(Sender: TObject);
  private
    { Private declarations }
    ConfigIni: TMemIniFile;
    procedure RecarregarSequenciais;
  public
    { Public declarations }
  end;

var
  SequenciaisFrm: TSequenciaisFrm;

implementation
uses
  BancoDadosUnt;
{$R *.dfm}

procedure TSequenciaisFrm.CancelarAtuaImgClick(Sender: TObject);
{Executa Close.}
begin
  Close;
end;

procedure TSequenciaisFrm.FormCreate(Sender: TObject);
{Ao criar carrega arquivo de configuração, preenche os valores na grid.}
begin
  ConfigIni:= TMemIniFile.Create(Application.ExeName.Replace('.exe','.ini'));
  SequenciaisGrd.Col:= 5;
  SequenciaisGrd.ColCount:= 6;
  SequenciaisGrd.Cells[1,0]:= 'Sequencial';
  SequenciaisGrd.ColWidths[1]:= 120;
  SequenciaisGrd.Cells[2,0]:= 'Mínimo';
  SequenciaisGrd.ColWidths[2]:= 70;
  SequenciaisGrd.Cells[3,0]:= 'Máximo';
  SequenciaisGrd.ColWidths[3]:= 70;
  SequenciaisGrd.Cells[4,0]:= 'Atual';
  SequenciaisGrd.ColWidths[4]:= 80;
  SequenciaisGrd.Cells[5,0]:= 'Atualizar';
  SequenciaisGrd.ColWidths[5]:= 80;
  RecarregarSequenciais
end;

procedure TSequenciaisFrm.RecarregarSequenciais;
{Recarrega valores na grid.}
var
  I: Integer;
  Sql: String;
  Retorno: String;
begin
  for I := 1 to SequenciaisGrd.RowCount - 1 do
    begin
      SequenciaisGrd.Rows[I].Clear;
    end;
  if not BancoDadosDtMdl.SequenciaisQry.Active then
    begin
      BancoDadosDtMdl.SequenciaisQry.Open();
      BancoDadosDtMdl.SequenciaisQry.FetchAll;
    end
  else
    begin
      BancoDadosDtMdl.SequenciaisQry.Refresh;
      BancoDadosDtMdl.SequenciaisQry.FetchAll;
    end;
  SequenciaisGrd.RowCount:= BancoDadosDtMdl.SequenciaisQry.RecordCount + 1;
  I:= 1;
  BancoDadosDtMdl.SequenciaisQry.First;
  while not BancoDadosDtMdl.SequenciaisQry.Eof do
    begin
      SequenciaisGrd.Cells[1,I]:= BancoDadosDtMdl.SequenciaisQry.Fields[0].AsString;
      SequenciaisGrd.Cells[2,I]:= BancoDadosDtMdl.SequenciaisQry.Fields[1].AsString;
      SequenciaisGrd.Cells[3,I]:= BancoDadosDtMdl.SequenciaisQry.Fields[2].AsString;
      SequenciaisGrd.Cells[4,I]:= BancoDadosDtMdl.SequenciaisQry.Fields[3].AsString;
      Sql:= ConfigIni.ReadString('Sequenciais',SequenciaisGrd.Cells[1,I],'');
    if Sql <> '' then
    begin
      Retorno:= '';
      try
        BancoDadosDtMdl.SelecaoQry.Open(Sql);
        Retorno:= BancoDadosDtMdl.SelecaoQry.Fields[0].AsString;
      except
        on E : Exception do
          begin
            MensagensFrm.MsgBox(ERRO_CONSULTA_BD, E.Message + sLineBreak
            + 'Verifique no arquivo de configuração na seção Sequenciais ou'
            + ' na aba configuração: ' + SequenciaisGrd.Cells[1,I] + '.'
            + sLineBreak+'SQL: '+Sql);
          end;
      end;
      SequenciaisGrd.Cells[5,I]:= Retorno;
      SequenciaisGrd.OnSetEditText(SequenciaisGrd, 5, I,
                                    SequenciaisGrd.Cells[5,I]);
    end;
    I:=I+1;
    BancoDadosDtMdl.SequenciaisQry.Next;
  end;
end;
procedure TSequenciaisFrm.OkAtuaImgClick(Sender: TObject);
{Atualiza os sequenciais preenchidos na na coluna Atualizar da grid.}
var
  I: Integer;
  Sql: String;
  Ddl: String;
  Atualizou: Boolean;
  Erro: Boolean;
  Mensagem: String;
  Sequencial: String;
  Atual: String;
  Atualizar: String;
begin
  Atualizou:= False;
  Erro:= False;
  if MensagensFrm.MsgBox(ATENCAO_QUESTAO_DIVERSA, 'Deseja realmente atualizar '
                        + 'os sequenciais?') = ID_YES then
  begin
    for I := 1 to SequenciaisGrd.RowCount - 1 do
      begin
        Sequencial:= SequenciaisGrd.Cells[1,I];
        Atual:= SequenciaisGrd.Cells[4,I];
        Atualizar:= SequenciaisGrd.Cells[5,I];
        if (Atualizar <> '') and
            (Atual <> Atualizar) then
          begin
            Sql:= 'SELECT DBMS_METADATA.GET_DDL(''SEQUENCE'','''
                + Sequencial +''') FROM DUAL';
            try
              BancoDadosDtMdl.SelecaoQry.Open(Sql);
              Ddl:= BancoDadosDtMdl.SelecaoQry.Fields[0].AsString;
              Ddl:= Ddl.Replace('START WITH '+Atual,'START WITH '
                  + Atualizar);
              try
                Sql:= 'DROP SEQUENCE '+Sequencial;
                BancoDadosDtMdl.FDConnection.ExecSQL(Sql);
                try
                  BancoDadosDtMdl.FDConnection.ExecSQL(Ddl);
                  Atualizou:= True;
                except
                  on E : Exception do
                    begin
                  MensagensFrm.MsgBox(ERRO_CRIAR_SEQUENCIAL, 'Sequencial: '
                                      + Sequencial + sLineBreak
                                      + 'DDL: ' + ddl);
                      Erro:= True;
                    end;
                end;
              except
              on E : Exception do
                begin
                  MensagensFrm.MsgBox(ERRO_EXCLUIR_SEQUENCIAL, 'Sequencial: '
                                      + Sequencial + sLineBreak
                                      + 'SQL: ' + sql);
                  Erro:= True;
                end;
              end;
            except
              on E : Exception do
                begin
                  MensagensFrm.MsgBox(ERRO_CONSULTA_BD, 'Consultar DDL do'
                                      +' sequencial ' + Sequencial
                                      + sLineBreak + 'SQL: ' + sql);
                  Erro:= True;
                end;
            end;
            Sequencial:= '';
            Atual:= '';
            Atualizar:= '';
            Sql:= '';
            Ddl:= '';
          end;
      end;
    if Atualizou then
      begin
        Mensagem:= 'Sequenciais atualizados.';
      end
    else
      begin
        Mensagem:= 'Não foi necessário atualizar nenhum sequencial.'
      end;
    if Erro then
      begin
        Mensagem:= Mensagem + sLineBreak + 'Houve erros no processo, verifique'
                  + ' e se necessário execute o Atua.';
      end;
    MensagensFrm.MsgBox(INF_PROC_CONCLUIDO, Mensagem);
    RecarregarSequenciais;
  end;

end;

procedure TSequenciaisFrm.OkConfigImgClick(Sender: TObject);
{Salva configuração da sugestão do sequencial no arquivo de configuração.}
begin
  if SequencialLkpCmbx.KeyValue <> null then
    begin
      ConfigIni.WriteString('Sequenciais',SequencialLkpCmbx.Text,ConfigMmo.Text);
      ConfigIni.UpdateFile;
      MensagensFrm.MsgBox(INF_PROC_CONCLUIDO, 'Configuração de Sequencial.'
                          + sLineBreak + 'Sugestões serão recarregadas!');
      SequencialLkpCmbx.KeyValue:= null;
      SequencialLkpCmbx.OnClick(SequencialLkpCmbx);
      SequenciaisPgCtrl.ActivePageIndex:= 0;
      RecarregarSequenciais;
    end
  else
    begin
      MensagensFrm.MsgBox(ERRO_VALIDAR_CAMPO, 'Selecione primeiro o sequencial!');
    end;
end;

procedure TSequenciaisFrm.RecarregarConfigImgClick(Sender: TObject);
{Recarrega a configuração da sugestão.}
begin
  SequencialLkpCmbx.OnClick(SequencialLkpCmbx);
end;

procedure TSequenciaisFrm.RecarregarImgClick(Sender: TObject);
{Recarrega valores na grid de sequenciais.}
begin
  RecarregarSequenciais;
end;

procedure TSequenciaisFrm.SequenciaisGrdDblClick(Sender: TObject);
{Vai para aba de configuração e seleciona o sequencial.}
begin
  if SequenciaisGrd.Col = 5 then
  begin
    SequencialLkpCmbx.KeyValue:= SequenciaisGrd.Cells[1,SequenciaisGrd.Row];
    SequencialLkpCmbx.OnClick(SequencialLkpCmbx);
    SequenciaisPgCtrl.ActivePage:= ConfiguracoesTbSt;
  end;
end;

procedure TSequenciaisFrm.SequenciaisGrdSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
{Bloqueia a seleção de outra celula que não seja da coluna (5) Atualizar.}
begin
    CanSelect:= ACol = 5;
end;

procedure TSequenciaisFrm.SequenciaisGrdSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
{Ao digitar valor em Atualizar valida a informação.}
var
  Valor: Int64;
  regex: TRegEx;
begin
  regex.Create('\d');
  if regex.IsMatch(Value) then
  begin
    try
      Valor:= StrToInt64(Value);
      if Valor > StrToInt64(SequenciaisGrd.Cells[3,ARow]) then
        begin
          MensagensFrm.MsgBox(ERRO_VALIDAR_CAMPO,'Valor máximo ultrapassado!');
          SequenciaisGrd.Cells[ACol,ARow]:='';
        end
      else if Valor < StrToInt64(SequenciaisGrd.Cells[2,ARow]) then
        begin
          MensagensFrm.MsgBox(ERRO_VALIDAR_CAMPO,'Valor mínimo ultrapassado!');
          SequenciaisGrd.Cells[ACol,ARow]:='';
        end;
    except
      begin
        SequenciaisGrd.Cells[ACol,ARow]:='';
      end;
    end;
  end
  else
    begin
      SequenciaisGrd.Cells[ACol,ARow]:='';
    end;
end;

procedure TSequenciaisFrm.SequencialLkpCmbxClick(Sender: TObject);
{Carrega a configuração ao selecionar o sequencial.}
begin
  ConfigMmo.Text:= ConfigIni.ReadString('Sequenciais',SequencialLkpCmbx.Text,'');
end;

end.
