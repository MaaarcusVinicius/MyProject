object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 560
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object dbgrd_oracle: TDBGrid
    Left = 8
    Top = 184
    Width = 608
    Height = 233
    DataSource = ds_oracle
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
  end
  object ds_oracle: TOraDataSource
    Left = 96
    Top = 48
  end
  object orqry_oracle: TOraQuery
    SQL.Strings = (
      'SELECT EMPRESA_ID, RAZAO_SOCIAL FROM EMPRESAS')
    MasterSource = ds_oracle
    Left = 192
    Top = 48
  end
end
