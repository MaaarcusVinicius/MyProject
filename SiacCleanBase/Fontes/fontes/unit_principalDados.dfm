object form_principalDados: Tform_principalDados
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 756
  ClientWidth = 1023
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object dbGrid_QryEmpresas: TDBGrid
    Left = 40
    Top = 272
    Width = 727
    Height = 313
    Align = alCustom
    DataSource = ds_deletandoEmpresa
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'SCRIPT'
        Visible = True
      end>
  end
  object ds_deletandoEmpresa: TOraDataSource
    DataSet = qry_deletandoEmpresas
    Left = 688
    Top = 24
  end
  object qry_deletandoEmpresas: TOraQuery
    Session = DmModule.orsConexao
    SQL.Strings = (
      
        'SELECT '#39'DELETE FROM '#39' || C.TABLE_NAME || '#39' WHERE '#39' || C.COLUMN_N' +
        'AME ||'#39' = '#39' || :pEMPRESA_ID || '#39';'#39' AS SCRIPT'
      '  FROM COLS C, USER_TABLES T'
      ' WHERE C.TABLE_NAME = T.TABLE_NAME'
      '   AND (C.COLUMN_NAME IN ('#39'EMPRESA_ID'#39', '#39'SIAC_EMPRESA_ID'#39'))'
      '   AND C.TABLE_NAME NOT IN ('#39'CADASTROS'#39', '#39'EMPRESAS'#39')'
      ''
      'UNION ALL'
      ''
      
        'SELECT '#39'DELETE FROM '#39' || C.TABLE_NAME || '#39' WHERE '#39' || C.COLUMN_N' +
        'AME || '#39' = '#39' || :pEMPRESA_ID || '#39';'#39' AS SCRIPT'
      '  FROM COLS C, USER_TABLES T'
      ' WHERE C.TABLE_NAME = T.TABLE_NAME'
      '   AND (C.COLUMN_NAME IN ('#39'EMPRESA_ID'#39', '#39'SIAC_EMPRESA_ID'#39'))'
      '   AND C.TABLE_NAME = '#39'EMPRESAS'#39)
    Left = 744
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pEMPRESA_ID'
        Value = nil
      end>
    object field_deletandoEmpresasSCRIPT: TStringField
      FieldName = 'SCRIPT'
      Size = 310
    end
  end
  object OraScriptDeletandoEmpresa: TOraScript
    SQL.Strings = (
      '')
    Left = 608
    Top = 96
  end
end
