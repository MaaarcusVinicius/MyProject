object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 357
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lbl_1: TLabel
    Left = 24
    Top = 30
    Width = 59
    Height = 20
    Caption = 'Codigo *'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_2: TLabel
    Left = 24
    Top = 149
    Width = 65
    Height = 20
    Caption = 'Descri'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_3: TLabel
    Left = 24
    Top = 91
    Width = 51
    Height = 20
    Caption = 'Nome *'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_4: TLabel
    Left = 24
    Top = 203
    Width = 42
    Height = 20
    Caption = 'Data *'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbl_5: TLabel
    Left = 232
    Top = 203
    Width = 42
    Height = 20
    Caption = 'Sexo *'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtCodigo: TEdit
    Tag = 5
    Left = 24
    Top = 56
    Width = 353
    Height = 23
    Hint = 'Informe o C'#243'digo'
    TabOrder = 0
  end
  object edtNome: TEdit
    Tag = 5
    Left = 24
    Top = 112
    Width = 353
    Height = 23
    Hint = 'Informe o Nome'
    TabOrder = 1
  end
  object edtDescricao: TEdit
    Left = 24
    Top = 170
    Width = 353
    Height = 23
    TabOrder = 2
  end
  object medtData: TMaskEdit
    Tag = 5
    Left = 24
    Top = 224
    Width = 113
    Height = 23
    Hint = 'Informe a data'
    TabOrder = 3
    Text = ''
  end
  object cmbCategoria: TComboBox
    Tag = 5
    Left = 232
    Top = 224
    Width = 145
    Height = 23
    Hint = 'Selecione o Sexo'
    TabOrder = 4
    Items.Strings = (
      '1 - Masculino'
      '2 - Feminino')
  end
  object btn_Cancela: TButton
    Left = 200
    Top = 296
    Width = 113
    Height = 25
    Caption = 'Cancela'
    TabOrder = 5
    OnClick = btn_CancelaClick
  end
  object btn_confirma: TButton
    Left = 72
    Top = 296
    Width = 113
    Height = 25
    Caption = 'Confirma'
    TabOrder = 6
    OnClick = btn_confirmaClick
  end
end
