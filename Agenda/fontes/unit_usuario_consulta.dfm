object form_usuario_consulta: Tform_usuario_consulta
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 675
  ClientWidth = 668
  Color = clBtnFace
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
    Width = 668
    Height = 675
    Align = alClient
    BevelOuter = bvNone
    ParentShowHint = False
    ShowCaption = False
    ShowHint = True
    TabOrder = 0
    object lbl_obsProfissional: TLabel
      Left = 19
      Top = 141
      Width = 208
      Height = 21
      Caption = 'Lista de Usu'#225'rios Cadastrados'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_logoTipo: TLabel
      Left = 40
      Top = 7
      Width = 156
      Height = 20
      Caption = 'CONSULTA USU'#193'RIOS'
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
    object lbl_aviso: TLabel
      Left = 24
      Top = 576
      Width = 291
      Height = 15
      Caption = '* Selecione o usu'#225'rio e pressione DELETE para exclu'#237'-lo.'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_aviso2: TLabel
      Left = 24
      Top = 597
      Width = 305
      Height = 15
      Caption = '* Click duas vezes sobre o usu'#225'rio para EDITAR o cadastro.'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_pesParte1: TLabel
      Left = 19
      Top = 66
      Width = 276
      Height = 21
      Caption = 'Digite o nome do usu'#225'rio para pesquisa'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object edt_consulta: TEdit
      Tag = 5
      Left = 19
      Top = 88
      Width = 496
      Height = 23
      TabOrder = 0
      OnKeyDown = edt_consultaKeyDown
    end
    object pnl_linhaTop: TPanel
      Left = -515
      Top = 30
      Width = 1181
      Height = 3
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 1
    end
    object dbgrd_consultaUsuario: TDBGrid
      Left = 19
      Top = 168
      Width = 638
      Height = 401
      DataSource = ds_consulta
      FixedColor = clMenuHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDodgerblue
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clHighlight
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = dbgrd_consultaUsuarioDblClick
      OnKeyDown = dbgrd_consultaUsuarioKeyDown
      Columns = <
        item
          Alignment = taCenter
          ButtonStyle = cbsEllipsis
          Color = clIvory
          Expanded = False
          FieldName = 'id_usuarios'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'd.'
          Title.Color = clHighlight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -12
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 67
          Visible = True
        end
        item
          Color = clIvory
          Expanded = False
          FieldName = 'ds_usuario'
          Title.Alignment = taCenter
          Title.Caption = 'Nome Usu'#225'rio'
          Title.Color = clHighlight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -12
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 405
          Visible = True
        end
        item
          Color = clIvory
          Expanded = False
          FieldName = 'ds_login'
          Title.Alignment = taCenter
          Title.Caption = 'Login Sistema'
          Title.Color = clHighlight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 159
          Visible = True
        end>
    end
    object pnl_linhaEsquerda: TPanel
      Left = -1
      Top = -5
      Width = 3
      Height = 678
      Color = clGray
      ParentBackground = False
      TabOrder = 3
    end
    object pnl_linhaDireita: TPanel
      Left = 663
      Top = -4
      Width = 3
      Height = 676
      Color = clGray
      ParentBackground = False
      TabOrder = 4
    end
    object pnl_linhaCima: TPanel
      Left = -4
      Top = -1
      Width = 670
      Height = 3
      Color = clGray
      ParentBackground = False
      TabOrder = 5
    end
    object pnl_linhaBaixo: TPanel
      Left = -15
      Top = 671
      Width = 681
      Height = 3
      Color = clGray
      ParentBackground = False
      TabOrder = 6
    end
    object pnl_novoUsuário: TPanel
      Left = 521
      Top = 85
      Width = 136
      Height = 27
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMenu
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
      object pnl_11: TPanel
        Left = 0
        Top = 0
        Width = 137
        Height = 27
        Align = alLeft
        BevelOuter = bvNone
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btn_1: TSpeedButton
          Left = 0
          Top = 0
          Width = 137
          Height = 27
          Align = alClient
          Caption = 'Novo Usu'#225'rio'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btn_1Click
          ExplicitLeft = -1
          ExplicitTop = -8
        end
      end
    end
    object pnl_cancelar: TPanel
      Left = 256
      Top = 626
      Width = 137
      Height = 41
      BevelOuter = bvNone
      Color = clCrimson
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 8
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
        ExplicitTop = -8
      end
    end
  end
  object ds_consulta: TDataSource
    Left = 576
    Top = 608
  end
end
