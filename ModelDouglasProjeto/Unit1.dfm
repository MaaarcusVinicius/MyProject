object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 635
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 593
    Height = 401
    DataSource = OraDataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PRODUTO_ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_PRODUTO'
        Width = 338
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CUSTO_VENDA'
        Visible = True
      end>
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 415
    Width = 121
    Height = 23
    DataField = 'PRODUTO_ID'
    DataSource = OraDataSource1
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 135
    Top = 415
    Width = 362
    Height = 23
    DataField = 'NOME_PRODUTO'
    DataSource = OraDataSource1
    TabOrder = 2
  end
  object Button1: TButton
    Left = 503
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object DBNavigator1: TDBNavigator
    Left = -8
    Top = 444
    Width = 710
    Height = 34
    TabOrder = 4
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'ADMIN'
    Server = '192.168.0.206'
    Connected = True
    Left = 304
    Top = 224
    EncryptedPassword = 'B2FFBEFFB1FFBEFFB8FFBAFFADFF'
  end
  object OraQuery1: TOraQuery
    Session = OraSession1
    SQL.Strings = (
      'SELECT  PRODUTO_ID, NOME_PRODUTO, CUSTO_VENDA FROM PRODUTOS'
      'WHERE PRODUTO_ID < 100')
    Left = 400
    Top = 200
    object OraQuery1PRODUTO_ID: TFloatField
      FieldName = 'PRODUTO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object OraQuery1NOME_PRODUTO: TStringField
      FieldName = 'NOME_PRODUTO'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object OraQuery1CUSTO_VENDA: TFloatField
      FieldName = 'CUSTO_VENDA'
      ProviderFlags = [pfInUpdate]
    end
  end
  object OraDataSource1: TOraDataSource
    DataSet = OraQuery1
    Left = 400
    Top = 288
  end
end
