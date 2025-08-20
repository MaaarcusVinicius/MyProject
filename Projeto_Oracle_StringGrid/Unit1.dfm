object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo Oracle + StringGrid'
  ClientHeight = 450
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 580
    Height = 320
    TabOrder = 0
  end
  object btnCarregar: TButton
    Left = 8
    Top = 340
    Width = 120
    Height = 25
    Caption = 'Carregar Dados'
    TabOrder = 1
    OnClick = btnCarregarClick
  end
  object btnExportar: TButton
    Left = 140
    Top = 340
    Width = 120
    Height = 25
    Caption = 'Exportar CSV'
    TabOrder = 2
    OnClick = btnExportarClick
  end
  object edtNome: TEdit
    Left = 8
    Top = 380
    Width = 200
    Height = 21
    TabOrder = 3
    TextHint = 'Nome do Cliente'
  end
  object edtCidade: TEdit
    Left = 220
    Top = 380
    Width = 200
    Height = 21
    TabOrder = 4
    TextHint = 'Cidade'
  end
  object btnAdicionar: TButton
    Left = 440
    Top = 378
    Width = 120
    Height = 25
    Caption = 'Adicionar Cliente'
    TabOrder = 5
    OnClick = btnAdicionarClick
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'ADMIN'
    Server = '192.168.0.206:1521:ORCL'
    Connected = True
    LoginPrompt = False
    Left = 360
    Top = 416
    EncryptedPassword = 'B2FFBEFFB1FFBEFFB8FFBAFFADFF'
  end
  object OraQuery1: TOraQuery
    Session = OraSession1
    Left = 520
    Top = 344
  end
end
