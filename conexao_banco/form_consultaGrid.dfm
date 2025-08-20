object ConsultaGrid: TConsultaGrid
  Left = 0
  Top = 0
  Caption = 'ConsultaGrid'
  ClientHeight = 478
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object dbgrd_oracle: TDBGrid
    Left = 32
    Top = 120
    Width = 577
    Height = 273
    DataSource = OraDataSource
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
  object OraDataSource: TOraDataSource
    Left = 232
    Top = 32
  end
end
