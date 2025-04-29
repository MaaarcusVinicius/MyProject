object form_menssagens: Tform_menssagens
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 220
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object pnl_fundo: TPanel
    Left = 0
    Top = 0
    Width = 667
    Height = 220
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object shp_fundo: TShape
      Left = 0
      Top = 0
      Width = 667
      Height = 220
      Align = alClient
      ExplicitLeft = 128
      ExplicitTop = 80
      ExplicitWidth = 65
      ExplicitHeight = 65
    end
    object lbl_titulo_janela: TLabel
      Left = 8
      Top = 8
      Width = 74
      Height = 21
      Caption = 'ATEN'#199#195'O'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object img_icone: TImage
      Left = 8
      Top = 62
      Width = 144
      Height = 147
      AutoSize = True
      Center = True
    end
    object lbl_titulo_menssagem: TLabel
      Left = 176
      Top = 62
      Width = 45
      Height = 21
      Caption = 'T'#237'tulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_msg: TLabel
      Left = 176
      Top = 92
      Width = 473
      Height = 70
      AutoSize = False
      Caption = 'Texto Mensagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = 20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object pnl_linhaCabecario: TPanel
      Left = 0
      Top = 35
      Width = 675
      Height = 1
      BevelOuter = bvNone
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnl_botoes: TPanel
      Left = 387
      Top = 168
      Width = 270
      Height = 41
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object pnl_nao: TPanel
        Left = 0
        Top = 0
        Width = 137
        Height = 41
        Align = alLeft
        BevelOuter = bvNone
        Color = clCrimson
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btn_nao: TSpeedButton
          Left = 0
          Top = 0
          Width = 137
          Height = 41
          Align = alClient
          Caption = 'N'#195'O ( ESC )'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btn_naoClick
          ExplicitLeft = 24
          ExplicitTop = 8
          ExplicitWidth = 23
          ExplicitHeight = 22
        end
      end
      object pnl_sim: TPanel
        Left = 138
        Top = 0
        Width = 132
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object btn_sim: TSpeedButton
          Left = 0
          Top = 0
          Width = 132
          Height = 41
          Align = alClient
          Caption = 'SIM ( ENTER )'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = 20
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btn_simClick
          ExplicitLeft = 5
        end
      end
    end
  end
end
