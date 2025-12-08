unit Classe.DBA.Oracle;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.StrUtils,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,classe.BancoDados;

type
  TClasseConsultaBD = class
  private
    FVersaoOracle             : TClasseBancoDados;
    FStartOracle              : TClasseBancoDados;
    FCarregarSessoesAtivas    : TClasseBancoDados;
    FBancoTablespace          : TClasseBancoDados;
    FBancoTablespaceDiretorio : TClasseBancoDados;
    FBancoUsuarios            : TClasseBancoDados;
    FBancoUpdate              : TClasseBancoDados;
    FExecutarDropUser         : TClasseBancoDados;
    FExecutarKillSession      : TClasseBancoDados;
    FExecutarBindsOracle      : TClasseBancoDados;

    procedure ListViewCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);

  public
    constructor Create;
    destructor Destroy; override;

    procedure CarregarVersaoOracle(ALabel: TLabel);
    procedure CarregarStartOracle(ALabel: TLabel);
    procedure CarregarSessoesAtivas(ADBGrid: TDBGrid);
    procedure CarregarTablespace(ADBEdit: TDBGrid);
    procedure CarregarBancoTablespaceDiretorio(ADBEdit: TDBGrid);
    procedure CarregarUsuarios(ADBGrid: TDBGrid);
    procedure AtualizarEmpresaStatus(const AEmpresaID: Integer; const AStatus: string);
    procedure ExecutarDropUser(const AUser: string);
    procedure ExecutarKillSession(const ASid , ASerial : string);
    procedure ExecutarBindsOracle(AQuery: TDataSet; const ATitulo: string);
  end;

implementation

uses
  uDataModule, uViewMain;

{ TClasseConsultaBD }

constructor TClasseConsultaBD.Create;
var
  vLogPath: string;
begin
  // Caminho do arquivo de log
  vLogPath := 'C:\CleanBaseLogs\Banco.log';

  // Garante que o diretório exista
  if not DirectoryExists(ExtractFilePath(vLogPath)) then
    ForceDirectories(ExtractFilePath(vLogPath));

  // Cada objeto TClasseBancoDados é independente (permite múltiplas consultas simultâneas)
  FVersaoOracle             := TClasseBancoDados.Create(DmModule.orsConexao);
  FStartOracle              := TClasseBancoDados.Create(DmModule.orsConexao);
  FCarregarSessoesAtivas    := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoTablespace          := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoTablespaceDiretorio := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoUsuarios            := TClasseBancoDados.Create(DmModule.orsConexao);
  //FBancoUpdate              := TClasseBancoDados.Create(DmModule.orsConexao);
  FExecutarDropUser         := TClasseBancoDados.Create(DmModule.orsConexao);
  FExecutarKillSession      := TClasseBancoDados.Create(DmModule.orsConexao);
  FExecutarBindsOracle      := TClasseBancoDados.Create(DmModule.orsConexao);

 // Habilita o log em todos os objetos
  //  FVersaoOracle.EnableLog(vLogPath);
  //  FStartOracle.EnableLog(vLogPath);
  //  FCarregarSessoesAtivas.EnableLog(vLogPath);
  //  FBancoTablespace.EnableLog(vLogPath);
  //  FBancoTablespaceDiretorio.EnableLog(vLogPath);
  //  FBancoUsuarios.EnableLog(vLogPath);
  //  FBancoUpdate.EnableLog(vLogPath);
  //  FExecutarDropUser.EnableLog(vLogPath);
  //  FExecutarKillSession.EnableLog(vLogPath);
end;


destructor TClasseConsultaBD.Destroy;
begin
  FVersaoOracle.Free;
  FStartOracle.Free;
  FCarregarSessoesAtivas.Free;
  FBancoTablespace.Free;
  FBancoTablespaceDiretorio.Free;
  FBancoUsuarios.Free;
  FBancoUpdate.Free;
  FExecutarDropUser.Free;
  FExecutarKillSession.Free;
  inherited;
end;

procedure TClasseConsultaBD.ListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  // Estilo "zebra" nas linhas
  if Odd(Item.Index) then
    Sender.Canvas.Brush.Color := $00F0F0F0 // cinza claro
  else
    Sender.Canvas.Brush.Color := clWhite;
end;

procedure TClasseConsultaBD.ExecutarBindsOracle(AQuery: TDataSet; const ATitulo: string);
var
  ListViewForm: TForm;
  ListView: TListView;
  Item: TListItem;
  LQuery: TDataSet;

  function ListCompare(Item1, Item2: TListItem; ParamSort: Integer): Integer; stdcall;
  var
    S1, S2: string;
  begin
    if ParamSort = 0 then
    begin
      S1 := Item1.Caption;
      S2 := Item2.Caption;
    end
    else
    begin
      S1 := Item1.SubItems[ParamSort - 1];
      S2 := Item2.SubItems[ParamSort - 1];
    end;
    Result := CompareText(S1, S2);
  end;

begin
  // Define SQL padrão se o dataset não foi passado
 FExecutarBindsOracle.SetSQL(
                 ' select upper(parameter) as parameter, value         '+
                 '   from (SELECT ''open_cursors'' AS parameter, value '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''open_cursors''              '+
                 '         UNION ALL                                   '+
                 '         SELECT ''processes'', value                 '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''processes''                 '+
                 '         UNION ALL                                   '+
                 '         SELECT name, value                          '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''filesystemio_options''      '+
                 '         UNION ALL                                   '+
                 '         SELECT name, value                          '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''disk_asynch_io''            '+
                 '         UNION ALL                                   '+
                 '         SELECT ''sessions'', value                  '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''sessions''                  '+
                 '         UNION ALL                                   '+
                 '         SELECT ''db_block_size'', value             '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''db_block_size''             '+
                 '         UNION ALL                                   '+
                 '         SELECT ''shared_pool_size'', value          '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''shared_pool_size''          '+
                 '         UNION ALL                                   '+
                 '         SELECT ''cursor_sharing'', value            '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''cursor_sharing''            '+
                 '         UNION ALL                                   '+
                 '         SELECT ''optimizer_mode'', value            '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''optimizer_mode''            '+
                 '         UNION ALL                                   '+
                 '         SELECT ''workarea_size_policy'', value      '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''workarea_size_policy''      '+
                 '         UNION ALL                                   '+
                 '         SELECT ''db_cache_size'', value             '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''db_cache_size''             '+
                 '         UNION ALL                                   '+
                 '         SELECT ''undo_tablespace'', value           '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''undo_tablespace''           '+
                 '         UNION ALL                                   '+
                 '         SELECT ''undo_management'', value           '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''undo_management''           '+
                 '         UNION ALL                                   '+
                 '         SELECT ''nls_date_format'', value           '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''nls_date_format''           '+
                 '         UNION ALL                                   '+
                 '         SELECT ''compatible'', value                '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''compatible''                '+
                 '         UNION ALL                                   '+
                 '         SELECT ''control_files'', value             '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''control_files''             '+
                 '         UNION ALL                                   '+
                 '         SELECT ''db_files'', value                  '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''db_files''                  '+
                 '         UNION ALL                                   '+
                 '         SELECT ''db_name'', value                   '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''db_name''                   '+
                 '         UNION ALL                                   '+
                 '         SELECT ''instance_name'', value             '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''instance_name''             '+
                 '         UNION ALL                                   '+
                 '         SELECT ''service_names'', value             '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''service_names''             '+
                 '         UNION ALL                                   '+
                 '         SELECT ''log_buffer'', value                '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''log_buffer''                '+
                 '         UNION ALL                                   '+
                 '         SELECT ''archive_lag_target'', value        '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''archive_lag_target''        '+
                 '         UNION ALL                                   '+
                 '         SELECT ''audit_trail'', value               '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''audit_trail''               '+
                 '         UNION ALL                                   '+
                 '         SELECT ''remote_login_passwordfile'', value '+
                 '           FROM v$parameter                          '+
                 '          WHERE name = ''remote_login_passwordfile'' '+
                 '         UNION ALL                                   '+
                 '         select ''log_mode'', log_mode               '+
                 '           from gv$database                          '+
                 '         UNION ALL                                   '+
                 '         select ''pasta DpDump'', DIRECTORY_PATH as value      '+
                 '           from dba_directories                                '+
                 '          WHERE ((DIRECTORY_NAME = ''DATA_PUMP_DIR'') OR       '+
                 '                (DIRECTORY_NAME LIKE ''%PUMP%''))              '+
                 '         UNION ALL                                             '+
                 '         select t.PARAMETER, t.VALUE                           '+
                 '           from nls_database_parameters t                      '+
                 '         UNION ALL                                             '+
                 '         select DIRECTORY_NAME as PARAMETER, DIRECTORY_PATH    '+
                 '           from all_directories                                '+
                 '         UNION ALL                                             '+
                 '         select name as parameter,                             '+
                 '                value / 1024 / 1024 / 1024 || '' GB'' VALUE_MB '+
                 '           from v$parameter                                    '+
                 '          where name in (''memory_max_target'',                '+
                 '                         ''memory_target'',                    '+
                 '                         ''sga_max_size'',                     '+
                 '                         ''sga_target'',                       '+
                 '                         ''pga_aggregate_limit'',              '+
                 '                         ''pga_aggregate_target'')             '+
                 '          order by 1)                                          '+
                 '  order by PARAMETER                                           ');

  FExecutarBindsOracle.ExecutarConsulta;

  if Assigned(AQuery) then
    LQuery := AQuery
  else
    LQuery := FExecutarBindsOracle.GetQuery;

  if not Assigned(LQuery) then
    Exit;

  // Cria form temporário
  ListViewForm := TForm.Create(nil);
  try
    ListViewForm.Caption := IfThen(ATitulo <> '', ATitulo, 'Parâmetros Oracle');
    ListViewForm.BorderStyle := bsSizeToolWin;
    ListViewForm.Position := poScreenCenter;
    ListViewForm.Width := 700;
    ListViewForm.Height := 500;
    ListViewForm.Color := clWhite;
    ListViewForm.Font.Name := 'Segoe UI';
    ListViewForm.Font.Size := 10;

    // Cria ListView
    ListView := TListView.Create(ListViewForm);
    ListView.Parent := ListViewForm;
    ListView.Align := alClient;
    ListView.ViewStyle := vsReport;
    ListView.RowSelect := True;
    ListView.ReadOnly := True;
    ListView.GridLines := True;
    ListView.MultiSelect := False;

    // Define colunas
    ListView.Columns.Add.Caption := 'Parâmetro';
    ListView.Columns.Add.Caption := 'Valor';
    ListView.Columns[0].Width := 300;
    ListView.Columns[1].Width := 350;

    // Popula com os dados
    LQuery.First;
    while not LQuery.Eof do
    begin
      Item := ListView.Items.Add;
      Item.Caption := LQuery.FieldByName('PARAMETER').AsString;
      Item.SubItems.Add(LQuery.FieldByName('VALUE').AsString);
      LQuery.Next;
    end;

    // Aplica evento custom draw (zebra)
    ListView.OnCustomDrawItem := ListViewCustomDrawItem;

    // Ordena por parâmetro (coluna 0)
    if ListView.Items.Count > 1 then
      ListView.CustomSort(@ListCompare, 0);

    // Exibe o formulário modal
    ListViewForm.ShowModal;
  finally
    ListViewForm.Free;
  end;
end;



procedure TClasseConsultaBD.ExecutarDropUser(const AUser: string);
var
  vSQL: string;
begin
  vSQL := 'DROP USER ' + UpperCase(AUser) + ' CASCADE';
  FExecutarDropUser.SetSQL(vSQL);
  FExecutarDropUser.ExecutarComando;
end;


procedure TClasseConsultaBD.ExecutarKillSession(const ASid , ASerial : string);
      //ALTER SYSTEM KILL SESSION '<sid>,<serial#>' IMMEDIATE;
      //ALTER SYSTEM DISCONNECT SESSION '<sid>,<serial#>' IMMEDIATE;
var
  vSQLKill: string;
  vSQLDisconnect: string;
begin
  vSQLDisconnect := 'ALTER SYSTEM DISCONNECT SESSION ' + ''''+ ASid + ','+  ASerial + ''''+  ' IMMEDIATE';
  vSQLKill := 'ALTER SYSTEM KILL SESSION ' + ''''+ ASid + ','+  ASerial + ''''+  ' IMMEDIATE';
  FExecutarDropUser.SetSQL(vSQLDisconnect);
  FExecutarDropUser.SetSQL(vSQLKill);
  FExecutarDropUser.ExecutarComando;
end;

procedure TClasseConsultaBD.CarregarVersaoOracle(ALabel: TLabel);
begin
  FVersaoOracle.SetSQL(' SELECT VERSION.VERSAO || '' - SID = '' || SID.GLOBAL_NAME AS VERSAO '+
                        '   FROM (SELECT NVL(BANNER_FULL, BANNER) AS VERSAO FROM V$VERSION) VERSION, '+
                        '        (SELECT * FROM GLOBAL_NAME) SID ' );
  FVersaoOracle.ExecutarConsulta;

  // Garante que existe pelo menos um registro
  if not FVersaoOracle.GetQuery.IsEmpty then
    ALabel.Caption := FVersaoOracle.GetQuery.FieldByName('VERSAO').AsString
  else
    ALabel.Caption := 'Versão não encontrada';
end;

procedure TClasseConsultaBD.CarregarStartOracle(ALabel: TLabel);
begin
  FStartOracle.SetSQL( 'select ''StartOracle : '' || to_char(startup_time, ''dd/mm/yyyy hh24:mi:ss'') || '' -/- '' ||   '+
                       '       to_char(''Dias Online: '' || (to_date(sysdate, ''dd/mm/yyyy'') - '+
                       '       to_date(startup_time, ''dd/mm/yyyy''))) as StartOracle           '+
                       '  from v$instance                                                       ');

  FStartOracle.ExecutarConsulta;

  // Garante que existe pelo menos um registro
  if not FStartOracle.GetQuery.IsEmpty then
    ALabel.Caption := FStartOracle.GetQuery.FieldByName('StartOracle').AsString
  else
    ALabel.Caption := 'Informação Indisponível';
end;

procedure TClasseConsultaBD.CarregarSessoesAtivas(ADBGrid: TDBGrid);
begin

  FCarregarSessoesAtivas.SetSQL(' SELECT SID,                '+
                                '        SERIAL# AS SERIAL,  '+
                                '        USERNAME,           '+
                                '        STATUS,             '+
                                '        OSUSER,             '+
                                '        MACHINE,            '+
                                '        TERMINAL,           '+
                                '        PROGRAM,            '+
                                '        MODULE,             '+
                                '        LOGON_TIME          '+
                                '   FROM V$SESSION C         '+
                                '  WHERE USERNAME IS NOT NULL'+
                                '  ORDER BY SID,USERNAME     ');
  FCarregarSessoesAtivas.ExecutarConsulta;
  ADBGrid.DataSource := FCarregarSessoesAtivas.GetDataSource;

end;

procedure TClasseConsultaBD.CarregarBancoTablespaceDiretorio(ADBEdit: TDBGrid);
begin
  FBancoTablespaceDiretorio.SetSQL(
    ' SELECT TABLESPACE_NAME AS "TableSpace_Name",                 '+
    '        C.FILE_NAME AS "Diretório Físico",                    '+
    '        ROUND(BYTES / 1024 / 1024 / 1024, 2) AS "Tamanho GB", '+
    '        C.ONLINE_STATUS AS "OnlineStatus",                    '+
    '        C.AUTOEXTENSIBLE  AS "AutoExtensible"                 '+
    '   FROM DBA_DATA_FILES C                                      '+
    '  ORDER BY TABLESPACE_NAME                                    ');
  FBancoTablespaceDiretorio.ExecutarConsulta;
  ADBEdit.DataSource := FBancoTablespaceDiretorio.GetDataSource;
end;


procedure TClasseConsultaBD.CarregarTablespace(ADBEdit: TDBGrid);
begin
  FBancoTablespace.SetSQL(
    ' SELECT T.TABLESPACE,                                                                '+
    '        T.TOTALSPACE AS "Totalspace(MB)",                                            '+
    '        ROUND((T.TOTALSPACE - FS.FREESPACE), 2) AS "Used Space(MB)",                 '+
    '        FS.FREESPACE AS "Free Space(MB)",                                            '+
    '        ROUND(((T.TOTALSPACE - FS.FREESPACE) / T.TOTALSPACE) * 100, 2) AS "% Usado", '+
    '        ROUND((FS.FREESPACE / T.TOTALSPACE) * 100, 2) AS "% Livre"                   '+
    '   FROM (SELECT ROUND(SUM(D.BYTES) / (1024 * 1024)) AS TOTALSPACE,                   '+
    '                D.TABLESPACE_NAME TABLESPACE                                         '+
    '           FROM DBA_DATA_FILES D                                                     '+
    '          GROUP BY D.TABLESPACE_NAME) T,                                             '+
    '        (SELECT ROUND(SUM(F.BYTES) / (1024 * 1024)) AS FREESPACE,                    '+
    '                F.TABLESPACE_NAME TABLESPACE                                         '+
    '           FROM DBA_FREE_SPACE F                                                     '+
    '          GROUP BY F.TABLESPACE_NAME) FS                                             '+
    '  WHERE T.TABLESPACE = FS.TABLESPACE                                                 '+
    '  ORDER BY T.TABLESPACE '                                                             );

  FBancoTablespace.ExecutarConsulta;
  ADBEdit.DataSource := FBancoTablespace.GetDataSource;
  //ADBEdit.FDataField := 'PERCENT_USADO';
end;

procedure TClasseConsultaBD.CarregarUsuarios(ADBGrid: TDBGrid);
begin
  FBancoUsuarios.SetSQL(
' SELECT DBA_USER.USERNAME,                                                  '+
'        DBA_USER.DT_CRIACAO AS "DT CRIAÇÃO",                                '+
'        DBA_USER.ULTIMO_LOGIN,                                              '+
'        DBA_USER.DIAS_SEM_LOGIN,                                            '+
'        DBA_SEG.TAMANHO_GB,                                                 '+
'        DBA_USER.DROP_USER                                                 '+
'   FROM (SELECT ROUND(SUM(BYTES) / 1024 / 1024 / 1024, 2) AS TAMANHO_GB,    '+
'                OWNER                                                       '+
'           FROM DBA_SEGMENTS                                                '+
'          GROUP BY OWNER                                                    '+
'          ORDER BY ROUND(SUM(BYTES) / 1024 / 1024 / 1024, 2) DESC) DBA_SEG, '+
'        (SELECT C.USERNAME,                                                 '+
'                TRUNC(C.CREATED) DT_CRIACAO,                                '+
'                TRUNC(C.LAST_LOGIN) ULTIMO_LOGIN,                           '+
'                TRUNC(SYSDATE) - TRUNC(C.LAST_LOGIN) DIAS_SEM_LOGIN,        '+
'                ''DROP USER '' || USERNAME || '' CASCADE; '' AS DROP_USER  '+
'           FROM DBA_USERS C                                                 '+
'          WHERE 1 = 1                                                       '+
'            and DEFAULT_TABLESPACE NOT IN (''SYSTEM'', ''SYSAUX'')          '+
'            AND USER_ID BETWEEN 100 AND 700                                 '+
'          ORDER BY USERNAME, TRUNC(C.LAST_LOGIN)) DBA_USER                  '+
'  WHERE DBA_SEG.OWNER (+) = DBA_USER.USERNAME                               ' );
  FBancoUsuarios.ExecutarConsulta;
  ADBGrid.DataSource := FBancoUsuarios.GetDataSource;
end;

procedure TClasseConsultaBD.AtualizarEmpresaStatus(const AEmpresaID: Integer; const AStatus: string);
begin
  FBancoUpdate.SetSQL('UPDATE EMPRESAS SET STATUS = :PSTATUS WHERE EMPRESA_ID = :PID');
  FBancoUpdate.AddParam('PSTATUS', AStatus);
  FBancoUpdate.AddParam('PID', AEmpresaID);
  FBancoUpdate.ExecutarComando;
  ShowMessage('Status da empresa atualizado com sucesso!');
end;

end.

