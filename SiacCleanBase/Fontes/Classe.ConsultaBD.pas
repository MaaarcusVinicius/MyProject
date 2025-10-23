unit Classe.ConsultaBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, MemDS, Vcl.Imaging.jpeg, DAScript, OraScript,
  Vcl.Imaging.pngimage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask,classe.BancoDados;

type
  TClasseConsultaBD = class
  private
    FVersaoOracle:             TClasseBancoDados;
    FCarregarSessoesAtivas :   TClasseBancoDados;
    FBancoTablespace:          TClasseBancoDados;
    FBancoTablespaceDiretorio: TClasseBancoDados;
    FBancoUsuarios:            TClasseBancoDados;
    FBancoUpdate:              TClasseBancoDados;
    FExecutarDropUser:         TClasseBancoDados;
    FExecutarKillSession:      TClasseBancoDados;
  public
    constructor Create;
    destructor Destroy; override;

    procedure CarregarVersaoOracle(ALabel: TLabel);
    procedure CarregarSessoesAtivas(ADBGrid: TDBGrid);
    procedure CarregarTablespace(ADBEdit: TDBGrid);
    procedure CarregarBancoTablespaceDiretorio(ADBEdit: TDBGrid);
    procedure CarregarUsuarios(ADBGrid: TDBGrid);
    procedure AtualizarEmpresaStatus(const AEmpresaID: Integer; const AStatus: string);
    procedure ExecutarDropUser(const AUser: string);
    procedure ExecutarKillSession(const ASid , ASerial : string);
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
  FCarregarSessoesAtivas    := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoTablespace          := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoTablespaceDiretorio := TClasseBancoDados.Create(DmModule.orsConexao);
  FBancoUsuarios            := TClasseBancoDados.Create(DmModule.orsConexao);
  //FBancoUpdate              := TClasseBancoDados.Create(DmModule.orsConexao);
  FExecutarDropUser         := TClasseBancoDados.Create(DmModule.orsConexao);
  FExecutarKillSession      := TClasseBancoDados.Create(DmModule.orsConexao);

  // Habilita o log em todos os objetos
  //  FVersaoOracle.EnableLog(vLogPath);
  //  FCarregarSessoesAtivas.EnableLog(vLogPath);
  //  FBancoTablespace.EnableLog(vLogPath);
  //  FBancoTablespaceDiretorio.EnableLog(vLogPath);
  //  FBancoUsuarios.EnableLog(vLogPath);
  //  FBancoUpdate.EnableLog(vLogPath);
    FExecutarDropUser.EnableLog(vLogPath);
    FExecutarKillSession.EnableLog(vLogPath);
end;


destructor TClasseConsultaBD.Destroy;
begin
  FVersaoOracle.Free;
  FCarregarSessoesAtivas.Free;
  FBancoTablespace.Free;
  FBancoTablespaceDiretorio.Free;
  FBancoUsuarios.Free;
  FBancoUpdate.Free;
  FExecutarDropUser.Free;
  FExecutarKillSession.Free;
  inherited;
end;

procedure TClasseConsultaBD.ExecutarDropUser(const AUser: string);
var
  vSQL: string;
begin
  vSQL := 'DROP USER ' + UpperCase(AUser) + ' CASCADE';
  FExecutarDropUser.SetSQL(vSQL);
  FExecutarDropUser.ExecutarComando;

  ShowMessage('Usuário deletado com sucesso!');
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

  ShowMessage('Sessão finalziada com Sucesso!');
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
                                '   FROM V$SESSION c         '+
                                '  WHERE USERNAME IS NOT NULL'+
                                '  ORDER BY USERNAME         ');
  FCarregarSessoesAtivas.ExecutarConsulta;
  ADBGrid.DataSource := FCarregarSessoesAtivas.GetDataSource;

end;

procedure TClasseConsultaBD.CarregarBancoTablespaceDiretorio(ADBEdit: TDBGrid);
begin
  FBancoTablespaceDiretorio.SetSQL(
    ' SELECT TABLESPACE_NAME AS "TableSpace_Name",                   '+
    '        C.FILE_NAME AS "Diretório Físico",                    '+
    '        ROUND(BYTES / 1024 / 1024 / 1024, 2) AS "Tamanho GB", '+
    '        C.ONLINE_STATUS AS "OnlineStatus",                    '+
    '        C.AUTOEXTENSIBLE  AS "AutoExtensible"                 '+
    '   FROM DBA_DATA_FILES C                                      ');
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

