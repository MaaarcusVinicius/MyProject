object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Conexao Base Banco'
  ClientHeight = 436
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Shape2: TShape
    Left = 0
    Top = 0
    Width = 579
    Height = 50
    Align = alTop
    Brush.Color = 10850942
    Shape = stRoundRect
    ExplicitLeft = 8
    ExplicitTop = -5
    ExplicitWidth = 710
  end
  object LbAlias: TLabel
    Left = 14
    Top = 5
    Width = 43
    Height = 13
    Caption = 'Usu'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LbSenha: TLabel
    Left = 120
    Top = 5
    Width = 35
    Height = 13
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label17: TLabel
    Left = 226
    Top = 5
    Width = 48
    Height = 13
    Caption = 'Servidor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Shape1: TShape
    Left = 0
    Top = 386
    Width = 579
    Height = 50
    Align = alBottom
    Brush.Color = 10850942
    Shape = stRoundRect
    ExplicitLeft = -8
    ExplicitTop = 428
    ExplicitWidth = 857
  end
  object lbldate: TLabel
    Left = 160
    Top = 176
    Width = 36
    Height = 15
    Caption = 'lbldate'
    Color = clBackground
    ParentColor = False
  end
  object BtDesconectar: TBitBtn
    Left = 448
    Top = 17
    Width = 107
    Height = 25
    Caption = '&Desconectar'
    Enabled = False
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
    OnClick = BtDesconectarClick
  end
  object BtConectar: TBitBtn
    Left = 335
    Top = 17
    Width = 107
    Height = 25
    Caption = '&Conectar'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BtConectarClick
  end
  object eServidor: TEdit
    Left = 226
    Top = 20
    Width = 100
    Height = 22
    Hint = 'Servidor do Banco de Dados'
    AutoSize = False
    CharCase = ecUpperCase
    TabOrder = 2
    Text = 'SVR-ORACLE'
  end
  object eSenha: TEdit
    Left = 120
    Top = 20
    Width = 100
    Height = 22
    Hint = 'Senha do Usu'#225'rio'
    AutoSize = False
    CharCase = ecUpperCase
    PasswordChar = '*'
    TabOrder = 3
    Text = 'MANAGER'
  end
  object eUsuario: TEdit
    Left = 14
    Top = 20
    Width = 100
    Height = 22
    Hint = 'Usu'#225'rio do Banco de Dados'
    AutoSize = False
    CharCase = ecUpperCase
    TabOrder = 4
    Text = 'ADMIN'
  end
  object dbEmpresas: TDBGrid
    Left = 0
    Top = 266
    Width = 579
    Height = 120
    Align = alBottom
    DataSource = OraData
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object qryEmpresas: TOraQuery
    Session = DmModule.orsConexao
    SQL.Strings = (
      'SELECT EMPRESA_ID, RAZAO_SOCIAL, FANTASIA'
      'FROM EMPRESAS')
    Left = 96
    Top = 88
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
  end
  object OraData: TOraDataSource
    DataSet = qryEmpresas
    Left = 168
    Top = 88
  end
end
