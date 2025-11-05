object BancoDadosDtMdl: TBancoDadosDtMdl
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 366
  Width = 424
  object TabelasXML: TXMLDocument
    XML.Strings = (
      '<TABELAS>'
      '</TABELAS>')
    Left = 32
    Top = 72
    DOMVendorDesc = 'MSXML'
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=mASTER'
      'User_Name=admin'
      'Password=manager'
      'DriverID=Ora')
    ResourceOptions.AssignedValues = [rvParamCreate, rvAutoConnect, rvAutoReconnect, rvKeepConnection]
    ResourceOptions.AutoConnect = False
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object EmpresasQry: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT EMPRESA_ID, EMPRESA_ID || '#39' | '#39' || RAZAO_SOCIAL AS EMPRES' +
        'A FROM EMPRESAS')
    Left = 360
    Top = 72
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 8
  end
  object RelacoesQry: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      
        'select C1.table_name AS TABELA, C2.table_name AS TABELA_REL from' +
        ' USER_CONS_COLUMNS C1, USER_CONSTRAINTS C, user_cons_columns C2'
      ' where C1.constraint_name = C.r_constraint_name'
      '   AND C.constraint_type = '#39'R'#39
      '   and C2.constraint_name = C.constraint_name'
      '   group by C1.table_name, C2.table_name')
    Left = 208
    Top = 8
  end
  object DDLFKQry: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'select C.table_name,'
      '       C.constraint_name,'
      '       '#39'Alter Table '#39' || c.table_name || '#39' Drop Constraint '#39' ||'
      '       c.constraint_name as drop_fk,'
      '       '#39'Alter Table '#39' || c.table_name || '#39' Add Constraint '#39' ||'
      '       c.constraint_name || '#39' Foreign Key('#39' ||'
      
        '       RETORNA_COLUNAS_FK(C.constraint_name) || '#39') References '#39' ' +
        '||'
      '       c1.table_name as ddl_fk,'
      '       DECODE(c.delete_rule,'
      '              '#39'NO ACTION'#39','
      '              '#39#39','
      '              '#39' ON DELETE '#39' || c.delete_rule) as acao_deletar'
      '  from user_constraints c, user_constraints c1'
      ' where c.constraint_type = '#39'R'#39
      '   and c.r_constraint_name = c1.constraint_name'
      '   and c.delete_rule <> '#39'CASCADE'#39)
    Left = 288
    Top = 8
  end
  object SelecaoQry: TFDQuery
    Connection = FDConnection
    Left = 208
    Top = 72
  end
  object ConectadosQry: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select TERMINAL, PROGRAM from v$session where username = UPPER(:' +
        'USUARIO) and program <> :PROGRAMA'
      'order by logon_time, sid')
    Left = 288
    Top = 72
    ParamData = <
      item
        Name = 'USUARIO'
        DataType = ftString
        ParamType = ptInput
        Value = 'ADMIN'
      end
      item
        Name = 'PROGRAMA'
        DataType = ftString
        ParamType = ptInput
        Value = 'LimpaBase.exe'
      end>
  end
  object PrimaryKeyQry: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT WM_CONCAT(COLUMN_NAME) AS PRIMARY_KEY, TABLE_NAME'
      '  FROM (select CC.COLUMN_NAME, CC.table_name'
      '          from user_constraints c, user_cons_columns cc'
      '         where c.constraint_name = cc.constraint_name'
      '           and c.constraint_type = '#39'P'#39
      '         order by cc.table_name, cc.position)'
      ' GROUP BY TABLE_NAME')
    Left = 360
    Top = 8
  end
  object UtilizadasQry: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    FetchOptions.AssignedValues = [evRowsetSize, evRecordCountMode, evAutoFetchAll]
    SQL.Strings = (
      'SELECT UT.TABLE_NAME,'
      '       COUNT_ROWS(UT.TABLE_NAME) AS COUNT,'
      '       (SELECT UTC.COLUMN_NAME'
      '          FROM USER_TAB_COLS UTC'
      '         WHERE UTC.COLUMN_NAME = '#39'EMPRESA_ID'#39
      '           AND UTC.TABLE_NAME = UT.TABLE_NAME) AS CAMPO_EMPRESA'
      '  FROM USER_TABLES UT'
      ' ORDER BY UT.TABLE_NAME')
    Left = 32
    Top = 136
  end
  object SequenciaisQry: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, LAST_NUMBER FROM USE' +
        'R_SEQUENCES')
    Left = 120
    Top = 136
  end
  object FKTabelaQry: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT C.CONSTRAINT_NAME FROM USER_CONSTRAINTS C WHERE C.CONSTRA' +
        'INT_TYPE = '#39'R'#39' AND C.TABLE_NAME = :TABELA')
    Left = 120
    Top = 72
    ParamData = <
      item
        Name = 'TABELA'
        DataType = ftString
        ParamType = ptInput
        Value = 'CAPA_MOVIMENTO'
      end>
  end
end
