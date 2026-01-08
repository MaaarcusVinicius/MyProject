object ViewOracleEXP: TViewOracleEXP
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  BorderWidth = 1
  Caption = ' DBA Oracle - Exportar Banco de Dados'
  ClientHeight = 542
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
    Height = 536
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
      Height = 536
      Align = alClient
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object pnl_container: TPanel
        Left = 1
        Top = 1
        Width = 559
        Height = 206
        Align = alClient
        Color = clTomato
        ParentBackground = False
        TabOrder = 0
        object lbl_userExport: TLabel
          Left = 8
          Top = 16
          Width = 96
          Height = 15
          Caption = 'Usu'#225'rio Exportado'
        end
        object lbl_diretorioArquivo: TLabel
          Left = 8
          Top = 60
          Width = 108
          Height = 15
          Caption = 'Diret'#243'rio do Arquivo'
        end
        object lbl_statusExp: TLabel
          Left = 483
          Top = 185
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
          Left = 227
          Top = 16
          Width = 43
          Height = 15
          Caption = 'Servidor'
        end
        object lbl_status_pastaExp: TLabel
          Left = 12
          Top = 100
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
        object edt_diretorioArquivoExp: TEdit
          Left = 8
          Top = 75
          Width = 545
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 0
        end
        object pnl_containerBotoes: TPanel
          Left = 336
          Top = 120
          Width = 217
          Height = 67
          Color = clTeal
          ParentBackground = False
          TabOrder = 2
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
            object btn_exportar: TSpeedButton
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
              OnClick = btn_exportarClick
              ExplicitLeft = 8
              ExplicitTop = 0
              ExplicitWidth = 110
              ExplicitHeight = 90
            end
          end
          object pnl_containerSalvarArquivo: TPanel
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
            object btn_salvarArquivo: TSpeedButton
              Left = 0
              Top = 0
              Width = 97
              Height = 55
              Cursor = crHandPoint
              Align = alClient
              BiDiMode = bdLeftToRight
              Caption = 'Salvar Arquivo'
              ImageIndex = 45
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
              OnClick = btn_salvarArquivoClick
              ExplicitLeft = 8
              ExplicitTop = 3
              ExplicitWidth = 91
              ExplicitHeight = 59
            end
          end
        end
        object chk_UtilizarExpDP: TCheckBox
          Left = 456
          Top = 34
          Width = 94
          Height = 17
          Caption = 'Utilizar EXPDP'
          TabOrder = 1
          OnClick = chk_UtilizarExpDPClick
        end
        object cbx_tnsAlias: TComboBox
          Left = 226
          Top = 31
          Width = 224
          Height = 23
          TabOrder = 3
          Text = 'TnsAliasOracle'
        end
        object cbb_userExport: TComboBox
          Left = 8
          Top = 31
          Width = 169
          Height = 23
          TabOrder = 4
          Text = 'cbb_userExport'
        end
      end
      object pnl_containerTabelas: TPanel
        Left = 1
        Top = 207
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
          Color = clTomato
          ParentBackground = False
          TabOrder = 0
          object btn_addTabelasExp: TSpeedButton
            Left = 510
            Top = 1
            Width = 46
            Height = 38
            Align = alRight
            ImageIndex = 31
            Images = ViewMain.ImageAllSystem
            Enabled = False
            OnClick = btn_addTabelasExpClick
            ExplicitLeft = 459
            ExplicitTop = 6
          end
          object chk_tabelasPersonalizadaExp: TCheckBox
            Left = 1
            Top = 1
            Width = 121
            Height = 38
            Align = alLeft
            Caption = 'Personalizar Tabelas'
            Color = clBlack
            ParentColor = False
            TabOrder = 0
            OnClick = chk_tabelasPersonalizadaExpClick
          end
          object edt_inserirTabelasExp: TEdit
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
            OnKeyDown = edt_inserirTabelasExpKeyDown
            ExplicitHeight = 29
          end
          object cbb_addExcludeExp: TComboBox
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
          object dbgrd_containerTabelasPersonalizadasExp: TDBGrid
            Left = 1
            Top = 1
            Width = 508
            Height = 280
            Align = alClient
            DataSource = ds_dbgridExp
            Enabled = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnKeyDown = dbgrd_containerTabelasPersonalizadasExpKeyDown
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
          Color = clTomato
          ParentBackground = False
          TabOrder = 2
          object btn_excluirItemExp: TSpeedButton
            Left = 0
            Top = 132
            Width = 46
            Height = 38
            ImageIndex = 33
            Images = ViewMain.ImageAllSystem
            Enabled = False
            OnClick = btn_excluirItemExpClick
          end
          object btn_addTabelasListaExp: TSpeedButton
            Left = 0
            Top = 88
            Width = 46
            Height = 38
            ImageIndex = 30
            Images = ViewMain.ImageAllSystem
            Enabled = False
            OnClick = btn_addTabelasListaExpClick
          end
        end
      end
    end
  end
  object ds_dbgridExp: TDataSource
    Left = 317
    Top = 483
  end
  object dataSet_dbgridExp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 189
    Top = 475
  end
end
