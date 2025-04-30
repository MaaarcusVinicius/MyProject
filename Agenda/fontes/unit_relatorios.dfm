object form_relatorios: Tform_relatorios
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 435
  ClientWidth = 623
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 435
    Align = alClient
    BevelKind = bkFlat
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lbl_logoTipo: TLabel
      Left = 40
      Top = 7
      Width = 183
      Height = 20
      Caption = 'CENTRAL DE RELAT'#211'RIOS'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = 20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object img_logoSiacAgenda: TImage
      Left = 8
      Top = 4
      Width = 24
      Height = 24
      AutoSize = True
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
        00180806000000E0773DF8000000017352474200AECE1CE90000000467414D41
        0000B18F0BFC6105000000097048597300000B1100000B11017F645F91000003
        2D4944415478DAED966B48536118C7FF676797B3DC5C0E261459A1655453BBA8
        4594340B8A40D4A2EC4374B17B416909952481857D29882E50D08D2088B1DABC
        94599660549FBAD0A722CD4C4D9D85B5B333DFCD9D9D9ECD8A72DA05EA533DF0
        1E789FF7CFF3E37DDFE73DCFC3C5992DCED4146B9E20E8E07677E345532FC05B
        C0712A203C863345A64F0872A04B84FC2E8531D63A7A74C2438321667673F3CB
        6C59961BC2322E2B6BBEE2745E85D16840A5F30AD617D743135700E66D862476
        12881F1C198AA2C0681A8B11C604489D67FCDE9EEA345A785150B0F289D56A9D
        5656B67F31CDEB2280ECEC858AC361872008A8AEB263E3EE46F4ABA6226D6C03
        66A527A3BF5F0987FC1A9EE338A85421DCBBDF8C571F7200EF4D26BA9D29B4F4
        76DEDCCCA74989E3275EBC645F45F3CB11BDCDB640B1DBAF40AFD747009B4A1E
        C2C75438717012B66E2B86E4F57CBF010E88898945D9FE521C3AD907A3D0CEC4
        6EC7049EE7530453E60DB56E1CC77A6FD7F8D9FB35A4F60E01780016D0E044F9
        64AC59B7011E8F1875FC66F348949757E0E0710F01DAC280243AC87443C2CE4A
        75AC0DD2EB6D1D41BFFBAE4AA5891F12E0633C8E1D48C2D6ED3BF0F1A3271A10
        67426969190E9F0EC2A87BF30530C330664BB536761EC4D63DD799D4BE5AAB1D
        511305D85CD288A07A1A922D75B04E19856070E062BF3D235E25E3D1B377E8F4
        E521245EA73B700D02ECBDC6A4B6655AADBE7608C01D68462E87DFD7813E5FEF
        40BA46A5688832281E823E1EBEEEB3CCDB533318E022403E01EE0E0950C7E653
        A60428D20FDE01ED8AE334E8735F1C16A0D3E92F0F0FE0FAF063E3E81D0AC300
        F65531E94D2E890C7F1B80FF80FF807F0C30DD90B0A3466BB2416C29AA64526B
        DE9F0424523D98C309198E103F0E7CA0BEAE9FBD5FFC470154C8E716ACC8B7CF
        9C998623474FDD72BBBB164554512573573D0196FE06E00201AA93C8917EEEDC
        F9CAC2C275484C9C58DBD2D2B424A2CACAB2292E97838ABE11AE70D12FBA0DB5
        69D9AF03BACF53D1AF9A428E404E4EEEE38C8C0C4B45C5E112C6A4A31195D96C
        71A5A6A5E60ABA70DBD285E72F3FB72D90F153A38E430EBC159560CF0CBFDFDF
        449EB5E4CCA75F390DEA69C83E01BEBA6C4D244503FC0000000049454E44AE42
        6082}
    end
    object lbl_nomeProfissional: TLabel
      Left = 67
      Top = 96
      Width = 194
      Height = 21
      Caption = 'Escolha o Tipo de Relat'#243'rio: '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_dataInicio: TLabel
      Left = 106
      Top = 172
      Width = 83
      Height = 21
      Caption = 'Data Inicial: '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_dataFinal: TLabel
      Left = 355
      Top = 172
      Width = 80
      Height = 21
      Caption = 'Data Final:  '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object pnl_linhaTop: TPanel
      Left = -515
      Top = 30
      Width = 1150
      Height = 3
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 0
    end
    object pnl_botoes: TPanel
      Left = 337
      Top = 382
      Width = 272
      Height = 41
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object pnl_confirma: TPanel
        Left = 0
        Top = 0
        Width = 137
        Height = 41
        Align = alLeft
        BevelOuter = bvNone
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btn_confirma: TSpeedButton
          Left = 0
          Top = 0
          Width = 137
          Height = 41
          Align = alClient
          Caption = 'Visualizar'
          Flat = True
          OnClick = btn_confirmaClick
          ExplicitLeft = -5
        end
      end
      object pnl_nao: TPanel
        Left = 135
        Top = 0
        Width = 137
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        Color = clCrimson
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object btn_cancelar: TSpeedButton
          Left = 0
          Top = 0
          Width = 137
          Height = 41
          Align = alClient
          Caption = 'Cancelar'
          Flat = True
          Layout = blGlyphBottom
          OnClick = btn_cancelarClick
          ExplicitLeft = 5
        end
      end
    end
    object cmb_tipo_relatorio: TComboBox
      Tag = 5
      Left = 67
      Top = 120
      Width = 438
      Height = 29
      Hint = 'Selecione o tipo do relat'#243'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Items.Strings = (
        'Agendamento por Per'#237'odo'
        'Agendamentos por Clientes'
        'Agendamentos por Profissionais')
    end
    object dbe_data_inicio: TMaskEdit
      Tag = 5
      Left = 102
      Top = 199
      Width = 160
      Height = 31
      Hint = 'Data Inicial'
      Color = clWhite
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      OnDblClick = dbe_data_inicioDblClick
      OnExit = dbe_data_inicioExit
    end
    object dbe_data_final: TMaskEdit
      Tag = 5
      Left = 350
      Top = 199
      Width = 161
      Height = 31
      Hint = 'Data Final'
      Color = clWhite
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 4
      Text = '  /  /    '
      OnDblClick = dbe_data_finalDblClick
      OnExit = dbe_data_finalExit
    end
    object clndrpckr_dataInicial: TCalendarPicker
      Left = 67
      Top = 199
      Width = 29
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      OnChange = clndrpckr_dataInicialChange
      ParentFont = False
      SelectionColor = clBlue
      TabOrder = 5
      TextHint = 'select a date'
      TodayColor = clBlack
    end
    object clndrpckr_dataFinal: TCalendarPicker
      Left = 320
      Top = 198
      Width = 29
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      OnChange = clndrpckr_dataFinalChange
      ParentFont = False
      SelectionColor = clBlue
      TabOrder = 6
      TextHint = 'select a date'
      TodayColor = clBlack
    end
  end
  object Acbr_tabEnter: TACBrEnterTab
    EnterAsTab = True
    Left = 520
    Top = 248
  end
end
