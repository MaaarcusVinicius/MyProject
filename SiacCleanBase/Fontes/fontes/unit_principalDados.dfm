object form_principalDados: Tform_principalDados
  Left = 0
  Top = 0
  BiDiMode = bdRightToLeftReadingOnly
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  ClientHeight = 785
  ClientWidth = 1218
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentBiDiMode = False
  OnCreate = FormCreate
  TextHeight = 15
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 1218
    Height = 785
    Align = alClient
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1096
    object dbEmpresas: TDBGrid
      Left = 1
      Top = 1
      Width = 1216
      Height = 144
      Margins.Left = 4
      Margins.Top = 10
      Margins.Right = 5
      Margins.Bottom = 8
      Align = alTop
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      Color = clWhite
      DataSource = OraData
      DrawingStyle = gdsGradient
      FixedColor = clWhite
      GradientEndColor = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold, fsStrikeOut]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clDarkblue
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'EMPRESA_ID'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ATIVO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAZAO_SOCIAL'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FANTASIA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTD_CADASTROS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTD_FINANCEIRO_EMPRESA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTD_PRODUTOS_EMPRESA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTD_ESTOQUE_EMPRESA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          Width = 64
          Visible = True
        end>
    end
  end
  object OraData: TOraDataSource
    DataSet = qryEmpresas
    Left = 640
    Top = 296
  end
  object qryEmpresas: TOraQuery
    Session = DmModule.orsConexao
    SQL.Strings = (
      'SELECT EMPRESA_ID, RAZAO_SOCIAL, FANTASIA, E.ATIVO, '
      '      (SELECT COUNT(*) FROM CADASTROS C) QTD_CADASTROS,'
      
        '      (SELECT COUNT (*) FROM FINANCEIRO F WHERE 1=1 AND F.EMPRES' +
        'A_ID = E.EMPRESA_ID) QTD_FINANCEIRO_EMPRESA,'
      
        '      (SELECT COUNT (*) FROM PRODUTOS PR, PRODUTOS_EMPRESAS PE W' +
        'HERE PR.PRODUTO_ID = PE.PRODUTO_ID AND PE.EMPRESA_ID = E.EMPRESA' +
        '_ID) QTD_PRODUTOS_EMPRESA,'
      
        '      (SELECT NVL(TRUNC(SUM(ESTOQUE_ATUAL),4),0) FROM ESTOQUES E' +
        'T WHERE 1=1 AND ET.EMPRESA_ID = E.EMPRESA_ID AND ET.ESTOQUE_ATUA' +
        'L >0) QTD_ESTOQUE_EMPRESA      '
      'FROM EMPRESAS E')
    Left = 712
    Top = 296
    object qryEmpresasEMPRESA_ID: TStringField
      FieldName = 'EMPRESA_ID'
      Required = True
      Size = 18
    end
    object qryEmpresasRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 40
    end
    object qryEmpresasFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object qryEmpresasATIVO: TStringField
      FieldName = 'ATIVO'
      FixedChar = True
      Size = 1
    end
    object qryEmpresasQTD_PRODUTOS_EMPRESA: TFloatField
      FieldName = 'QTD_PRODUTOS_EMPRESA'
    end
    object qryEmpresasQTD_CADASTROS: TFloatField
      FieldName = 'QTD_CADASTROS'
    end
    object qryEmpresasQTD_FINANCEIRO_EMPRESA: TFloatField
      FieldName = 'QTD_FINANCEIRO_EMPRESA'
    end
    object qryEmpresasQTD_ESTOQUE_EMPRESA: TFloatField
      FieldName = 'QTD_ESTOQUE_EMPRESA'
    end
  end
  object ds_deletandoEmpresa: TOraDataSource
    DataSet = qry_deletandoEmpresas
    Left = 960
    Top = 400
  end
  object qry_deletandoEmpresas: TOraQuery
    Session = DmModule.orsConexao
    SQL.Strings = (
      '/*TODAS AS TABELAS */'
      
        'SELECT '#39'DELETE FROM '#39' || C.TABLE_NAME || '#39' WHERE '#39' || C.COLUMN_N' +
        'AME ||'#39' = '#39' || :pEMPRESA_ID || '#39';'#39' AS SCRIPT'
      '  FROM COLS C, USER_TABLES T'
      ' WHERE C.TABLE_NAME = T.TABLE_NAME'
      '   AND C.COLUMN_NAME IN ('#39'EMPRESA_ID'#39', '#39'SIAC_EMPRESA_ID'#39')'
      '   AND C.TABLE_NAME NOT IN ('#39'CADASTROS'#39', '#39'EMPRESAS'#39')'
      '   AND C.TABLE_NAME NOT LIKE '#39'%PARAMETRO%'#39' '
      ''
      'UNION ALL'
      
        '/* TABELAS DE PAR'#194'METROS FICAM NA POSI'#199#195'O FINAL DO SCRIPT, ASSUM' +
        'IR'#193' A ANTEPEN'#218'LTIMA POSI'#199#195'O */'
      
        'SELECT '#39'DELETE FROM '#39' || C.TABLE_NAME || '#39' WHERE '#39' || C.COLUMN_N' +
        'AME || '#39' = '#39' || :pEMPRESA_ID || '#39';'#39' AS SCRIPT'
      '  FROM COLS C, USER_TABLES T'
      ' WHERE C.TABLE_NAME = T.TABLE_NAME'
      '   AND C.COLUMN_NAME IN ('#39'EMPRESA_ID'#39', '#39'SIAC_EMPRESA_ID'#39')'
      '   AND C.TABLE_NAME LIKE '#39'%PARAMETRO%'#39
      ''
      'UNION ALL'
      '/* JOGA A TABELA PRINCIPAL '#39'EMPRESAS'#39' PARA O FIM DA LISTA */'
      
        'SELECT '#39'DELETE FROM '#39' || C.TABLE_NAME || '#39' WHERE '#39' || C.COLUMN_N' +
        'AME || '#39' = '#39' || :pEMPRESA_ID || '#39';'#39' AS SCRIPT'
      '  FROM COLS C, USER_TABLES T'
      ' WHERE C.TABLE_NAME = T.TABLE_NAME'
      '   AND (C.COLUMN_NAME IN ('#39'EMPRESA_ID'#39', '#39'SIAC_EMPRESA_ID'#39'))'
      '   AND C.TABLE_NAME = '#39'EMPRESAS'#39)
    Left = 824
    Top = 440
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
    Left = 904
    Top = 448
  end
end
