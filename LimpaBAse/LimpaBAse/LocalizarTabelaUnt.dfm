object LocalizarTabelaFrm: TLocalizarTabelaFrm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Localizar Tabela'
  ClientHeight = 377
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CorSelShp: TShape
    Left = 8
    Top = 357
    Width = 17
    Height = 13
    Brush.Color = clRed
    OnMouseDown = CorSelShpMouseDown
  end
  object LegSelLbl: TLabel
    Left = 31
    Top = 357
    Width = 133
    Height = 13
    Caption = '*Selecionada para exclus'#227'o'
  end
  object CorSelCascShp: TShape
    Left = 200
    Top = 356
    Width = 16
    Height = 13
    Brush.Color = clYellow
    OnMouseDown = CorSelCascShpMouseDown
  end
  object LegSelCascLbl: TLabel
    Left = 222
    Top = 356
    Width = 196
    Height = 13
    Caption = '**Selecionada em cascata para exclus'#227'o'
  end
  object LocalizarEdt: TEdit
    Left = 8
    Top = 53
    Width = 409
    Height = 21
    TabOrder = 0
    OnChange = LocalizarEdtChange
  end
  object TipoPesqRdGrp: TRadioGroup
    Left = 8
    Top = 8
    Width = 409
    Height = 39
    Caption = 'Tipo de Pesquisa'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Cont'#233'm:'
      'Inicia com:')
    TabOrder = 1
    OnClick = TipoPesqRdGrpClick
  end
  object TabelasGrd: TStringGrid
    Left = 8
    Top = 80
    Width = 410
    Height = 271
    ColCount = 1
    DefaultColWidth = 400
    DefaultDrawing = False
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 2
    OnDblClick = TabelasGrdDblClick
    OnDrawCell = TabelasGrdDrawCell
  end
  object ColorDialog: TColorDialog
    Left = 376
    Top = 8
  end
end
