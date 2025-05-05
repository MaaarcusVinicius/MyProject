object form_relatorio_agendamento_cliente: Tform_relatorio_agendamento_cliente
  Left = 0
  Top = 0
  ClientHeight = 684
  ClientWidth = 798
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object rlr_agendamentos_cliente: TRLReport
    Left = -4
    Top = 0
    Width = 794
    Height = 1123
    Borders.Color = clBlue
    DataSource = ds_padrao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = '++'
    Font.Style = []
    object rlr_band_1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 57
      BandType = btTitle
      object Tlbl_periodo: TRLLabel
        Left = 0
        Top = 23
        Width = 718
        Height = 17
        Align = faTop
        Alignment = taCenter
        Caption = 'PER'#205'ODO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Tlbl_titulo: TRLLabel
        Left = 0
        Top = 0
        Width = 718
        Height = 23
        Align = faTop
        Alignment = taCenter
        Caption = 'RELAT'#211'RIO DE AGENDAMENTOS POR CLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlsystmnf1_page: TRLSystemInfo
        Left = 634
        Top = 0
        Width = 87
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object rlsystmnf2_date: TRLSystemInfo
        Left = 3
        Top = 2
        Width = 39
        Height = 16
        Text = ''
      end
      object lbl_cliente: TRLLabel
        Left = 0
        Top = 40
        Width = 718
        Height = 17
        Align = faTop
        Alignment = taCenter
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlr_band_2: TRLBand
      Left = 38
      Top = 95
      Width = 718
      Height = 18
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Borders.Color = clBlue
      object Tlbl_1: TRLLabel
        Left = 11
        Top = -1
        Width = 33
        Height = 17
        Caption = 'Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Tlbl_2: TRLLabel
        Left = 99
        Top = -1
        Width = 34
        Height = 17
        Caption = 'Hora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Tlbl_3: TRLLabel
        Left = 153
        Top = -1
        Width = 77
        Height = 17
        Caption = 'Profissional'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Tlbl_5: TRLLabel
        Left = 567
        Top = -1
        Width = 148
        Height = 17
        Alignment = taCenter
        Caption = 'Agendado por'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlr_band_3: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 26
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Borders.Color = clBlue
      object rldbtxt1: TRLDBText
        Left = 10
        Top = 1
        Width = 61
        Height = 16
        DataField = 'DT_DATA'
        DataSource = ds_padrao
        Text = ''
      end
      object rldbtxt2: TRLDBText
        Left = 99
        Top = 1
        Width = 66
        Height = 16
        DataField = 'HR_HORA'
        DataSource = ds_padrao
        Text = ''
      end
      object rldbtxt3: TRLDBText
        Left = 153
        Top = 2
        Width = 124
        Height = 16
        DataField = 'DS_PROFISSIONAL'
        DataSource = ds_padrao
        Text = ''
      end
      object rldbtxt5: TRLDBText
        Left = 597
        Top = 1
        Width = 88
        Height = 16
        Alignment = taCenter
        DataField = 'DS_USUARIO'
        DataSource = ds_padrao
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = '++'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
    end
    object rlr_band_4: TRLBand
      Left = 38
      Top = 139
      Width = 718
      Height = 16
      BandType = btFooter
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Borders.Color = clBlue
      Borders.FixedBottom = True
      object Tlbl_tota_Agendamentos: TRLLabel
        Left = 0
        Top = -2
        Width = 251
        Height = 17
        Caption = 'TOTAL AGENDAMENTOS NO PERIODO: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Tlbl_total: TRLLabel
        Left = 257
        Top = -2
        Width = 11
        Height = 17
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object ds_padrao: TDataSource
    Left = 134
    Top = 288
  end
end
