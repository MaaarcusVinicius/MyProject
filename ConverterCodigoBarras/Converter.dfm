object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lblResultado: TLabel
    Left = 32
    Top = 265
    Width = 19
    Height = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbllinhadigital: TLabel
    Left = 32
    Top = 24
    Width = 74
    Height = 15
    Caption = 'Liginha Barras'
  end
  object Label1: TLabel
    Left = 32
    Top = 126
    Width = 88
    Height = 15
    Caption = 'Liginha Digitavel'
  end
  object edtLinha: TEdit
    Left = 32
    Top = 45
    Width = 537
    Height = 23
    TabOrder = 0
  end
  object btnGerar: TButton
    Left = 32
    Top = 74
    Width = 121
    Height = 25
    Caption = 'Gerar Linha Digitavel'
    TabOrder = 1
    OnClick = btnGerarClick
  end
  object btnLinhadigitavel: TButton
    Left = 32
    Top = 176
    Width = 121
    Height = 25
    Caption = 'Gerar LInha Barras'
    TabOrder = 2
    OnClick = btnLinhadigitavelClick
  end
  object edtLInhaDigitavel: TEdit
    Left = 32
    Top = 147
    Width = 537
    Height = 23
    TabOrder = 3
  end
end
