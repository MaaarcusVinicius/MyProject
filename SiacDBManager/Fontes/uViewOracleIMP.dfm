object ViewOracleIMP: TViewOracleIMP
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  BorderWidth = 1
  Caption = ' DBA Oracle - Importar Banco de Dados'
  ClientHeight = 597
  ClientWidth = 571
  Color = clTeal
  CustomTitleBar.Height = 31
  CustomTitleBar.SystemHeight = False
  CustomTitleBar.ShowCaption = False
  CustomTitleBar.ShowIcon = False
  CustomTitleBar.SystemColors = False
  CustomTitleBar.SystemButtons = False
  CustomTitleBar.BackgroundColor = clWhite
  CustomTitleBar.ForegroundColor = 65793
  CustomTitleBar.InactiveBackgroundColor = clWhite
  CustomTitleBar.InactiveForegroundColor = 10066329
  CustomTitleBar.ButtonForegroundColor = 65793
  CustomTitleBar.ButtonBackgroundColor = clWhite
  CustomTitleBar.ButtonHoverForegroundColor = 65793
  CustomTitleBar.ButtonHoverBackgroundColor = 16053492
  CustomTitleBar.ButtonPressedForegroundColor = 65793
  CustomTitleBar.ButtonPressedBackgroundColor = 15395562
  CustomTitleBar.ButtonInactiveForegroundColor = 10066329
  CustomTitleBar.ButtonInactiveBackgroundColor = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clTeal
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  StyleElements = [seFont, seClient]
  StyleName = 'Windows'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 20
  object pnl_containerFundo: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 565
    Height = 591
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object pnl_containerOpcoes: TPanel
      Left = 0
      Top = 0
      Width = 565
      Height = 591
      Align = alClient
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object pnl_container: TPanel
        Left = 1
        Top = 1
        Width = 559
        Height = 261
        Align = alClient
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object lbl_userExport: TLabel
          Left = 8
          Top = 68
          Width = 96
          Height = 15
          Caption = 'Usu'#225'rio Exportado'
        end
        object lbl_diretorioArquivo: TLabel
          Left = 8
          Top = 112
          Width = 108
          Height = 15
          Caption = 'Diret'#243'rio do Arquivo'
        end
        object lbl_usuarioDestino: TLabel
          Left = 132
          Top = 68
          Width = 83
          Height = 15
          Caption = 'Usu'#225'rio Destino'
        end
        object lbl_status: TLabel
          Left = 483
          Top = 241
          Width = 67
          Height = 15
          Alignment = taRightJustify
          Caption = 'Informativo'
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object lbl_oracleServer: TLabel
          Left = 275
          Top = 68
          Width = 43
          Height = 15
          Caption = 'Servidor'
        end
        object lbl_status_pasta: TLabel
          Left = 12
          Top = 156
          Width = 67
          Height = 15
          Caption = 'Informativo'
          Color = clDefault
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object edt_userExport: TEdit
          Left = 8
          Top = 85
          Width = 121
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 0
          Text = 'ADMIN'
        end
        object edt_diretorioArquivo: TEdit
          Left = 8
          Top = 127
          Width = 545
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object pnl_containerBotoes: TPanel
          Left = 336
          Top = 176
          Width = 217
          Height = 67
          Color = clTeal
          ParentBackground = False
          TabOrder = 4
          object pnl_containerBtnProcessar: TPanel
            AlignWithMargins = True
            Left = 111
            Top = 4
            Width = 101
            Height = 59
            Align = alLeft
            BevelKind = bkFlat
            BevelOuter = bvNone
            Color = clWhite
            ParentBackground = False
            TabOrder = 0
            object btn_importar: TSpeedButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 91
              Height = 49
              Cursor = crHandPoint
              Align = alClient
              BiDiMode = bdLeftToRight
              Caption = 'Executar'
              ImageIndex = 19
              Images = ViewMain.ImageAllSystem
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              Layout = blGlyphTop
              ParentFont = False
              ParentBiDiMode = False
              OnClick = btn_importarClick
              ExplicitLeft = 8
              ExplicitTop = 0
              ExplicitWidth = 110
              ExplicitHeight = 90
            end
          end
          object pnl_containerBuscarArquivo: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 101
            Height = 59
            Align = alLeft
            BevelKind = bkFlat
            BevelOuter = bvNone
            Color = clWhite
            ParentBackground = False
            TabOrder = 1
            object btn_carregarArquivo: TSpeedButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 91
              Height = 49
              Cursor = crHandPoint
              Align = alClient
              BiDiMode = bdLeftToRight
              Caption = 'Procurar Arquivo'
              ImageIndex = 49
              Images = ViewMain.ImageAllSystem
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              Layout = blGlyphTop
              ParentFont = False
              ParentBiDiMode = False
              OnClick = btn_carregarArquivoClick
              ExplicitLeft = 8
              ExplicitHeight = 59
            end
          end
        end
        object edt_userDestino: TEdit
          Left = 132
          Top = 85
          Width = 121
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object chk_UtilizarImpDP: TCheckBox
          Left = 456
          Top = 88
          Width = 94
          Height = 17
          Caption = 'Utilizar IMPDP'
          TabOrder = 3
          OnClick = chk_UtilizarImpDPClick
        end
        object cbx_tnsAlias: TComboBox
          Left = 275
          Top = 85
          Width = 175
          Height = 23
          TabOrder = 5
          Text = 'TnsAliasOracle'
        end
        object pnl_containerTop: TPanel
          Left = 1
          Top = 1
          Width = 557
          Height = 41
          Align = alTop
          Color = clTeal
          ParentBackground = False
          TabOrder = 6
          object lbl_oracleImport: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 549
            Height = 33
            Align = alClient
            Alignment = taCenter
            Caption = 'Importa'#231#227'o Banco de da Dados'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -20
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 296
            ExplicitHeight = 28
          end
        end
      end
      object pnl_containerTabelas: TPanel
        Left = 1
        Top = 262
        Width = 559
        Height = 324
        Align = alBottom
        Color = clPapayawhip
        ParentBackground = False
        TabOrder = 1
        object pnl_containerAddTabelas: TPanel
          Left = 1
          Top = 1
          Width = 557
          Height = 40
          Align = alTop
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object btn_addTabelas: TSpeedButton
            Left = 510
            Top = 1
            Width = 46
            Height = 38
            Align = alRight
            ImageIndex = 31
            Images = ViewMain.ImageAllSystem
            Enabled = False
            OnClick = btn_addTabelasClick
            ExplicitLeft = 459
            ExplicitTop = 6
          end
          object chk_tabelasPersonalizada: TCheckBox
            Left = 1
            Top = 1
            Width = 121
            Height = 38
            Align = alLeft
            Caption = 'Personalizar Tabelas'
            Color = clBlack
            ParentColor = False
            TabOrder = 0
            OnClick = chk_tabelasPersonalizadaClick
          end
          object edt_inserirTabelas: TEdit
            Left = 225
            Top = 1
            Width = 285
            Height = 38
            Align = alClient
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TextHint = 'Add Table Name'
            OnKeyDown = edt_inserirTabelasKeyDown
            ExplicitHeight = 29
          end
          object cbb_addExclude: TComboBox
            Left = 122
            Top = 1
            Width = 103
            Height = 38
            Align = alLeft
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -21
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = 'Tables'
            Items.Strings = (
              'Tables')
          end
        end
        object pnl_containerDbgrid: TPanel
          Left = 1
          Top = 41
          Width = 510
          Height = 282
          Align = alClient
          TabOrder = 1
          object dbgrd_containerTabelasPersonalizadas: TDBGrid
            Left = 1
            Top = 1
            Width = 508
            Height = 280
            Align = alClient
            DataSource = ds_dbgridImp
            Enabled = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnKeyDown = dbgrd_containerTabelasPersonalizadasKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'NOME_TABELA'
                Title.Caption = 'Tabela'
                Width = 487
                Visible = True
              end>
          end
        end
        object pnl_containerBotoesLista: TPanel
          Left = 511
          Top = 41
          Width = 47
          Height = 282
          Align = alRight
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 2
          object btn_excluirItem: TSpeedButton
            Left = 0
            Top = 132
            Width = 46
            Height = 38
            ImageIndex = 33
            Images = ViewMain.ImageAllSystem
            Enabled = False
            OnClick = btn_excluirItemClick
          end
          object btn_addTabelasLista: TSpeedButton
            Left = 0
            Top = 88
            Width = 46
            Height = 38
            ImageIndex = 30
            Images = ViewMain.ImageAllSystem
            Enabled = False
            OnClick = btn_addTabelasListaClick
          end
        end
      end
    end
  end
  object ds_dbgridImp: TDataSource
    Left = 317
    Top = 483
  end
  object dataSet_dbgridImp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 189
    Top = 475
  end
end
