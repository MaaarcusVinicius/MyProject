object form_agendamento_consulta: Tform_agendamento_consulta
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 2
  ClientHeight = 476
  ClientWidth = 700
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object pnl_superior: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 81
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      700
      81)
    object btn__fechar: TSpeedButton
      Left = 664
      Top = 0
      Width = 33
      Height = 22
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'X'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btn__fecharClick
      ExplicitLeft = 604
    end
    object lbl_selecioneProfissional: TLabel
      Left = 26
      Top = 11
      Width = 231
      Height = 21
      Caption = 'Agendamento para o Profissional'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object pnl_linha: TPanel
      Left = 1
      Top = 77
      Width = 698
      Height = 3
      Align = alBottom
      Color = clGray
      ParentBackground = False
      TabOrder = 0
    end
    object dblkcbb_selecionePorfissional: TDBLookupComboBox
      Tag = 5
      Left = 16
      Top = 38
      Width = 441
      Height = 31
      Hint = 'Selecione um Profissional !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      KeyField = 'id_profissional'
      ListField = 'ds_profissional'
      ListSource = form_agendamento.dataSource_profissionais
      ParentFont = False
      TabOrder = 1
      OnClick = dblkcbb_selecionePorfissionalClick
    end
  end
  object pnl_central: TPanel
    Left = 0
    Top = 81
    Width = 700
    Height = 395
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object lbl_horarioHora: TLabel
      Left = 16
      Top = 117
      Width = 135
      Height = 21
      Caption = 'Selecione a Hor'#225'rio'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_observacoes: TLabel
      Left = 16
      Top = 202
      Width = 89
      Height = 21
      Caption = 'Observa'#231#245'es'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbl_listaHorarioMarcado: TLabel
      Left = 336
      Top = 26
      Width = 275
      Height = 21
      Caption = 'Hor'#225'rios Agendados para o Profissional'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object clndrpckr_calendario: TCalendarPicker
      Left = 16
      Top = 56
      Width = 261
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
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      OnChange = clndrpckr_calendarioChange
      ParentFont = False
      TabOrder = 0
      TextHint = 'Selecione uma Data'
    end
    object cbb_hora: TComboBox
      Left = 16
      Top = 144
      Width = 153
      Height = 29
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Items.Strings = (
        '08'
        '09'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '')
    end
    object cbb_horarioMinutos: TComboBox
      Left = 184
      Top = 144
      Width = 93
      Height = 29
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Items.Strings = (
        '00'
        '15'
        '30'
        '45')
    end
    object edt_observacoes: TEdit
      Left = 16
      Top = 229
      Width = 261
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object dbgrd_profissionais: TDBGrid
      Left = 298
      Top = 53
      Width = 391
      Height = 313
      Color = clSilver
      DataSource = ds_consulta
      FixedColor = clCream
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clHighlight
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          ButtonStyle = cbsEllipsis
          Color = clIvory
          Expanded = False
          FieldName = 'hr_hora'
          Title.Alignment = taCenter
          Title.Caption = 'Hor'#225'rio'
          Title.Color = clHighlight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 102
          Visible = True
        end
        item
          Color = clIvory
          Expanded = False
          FieldName = 'ds_cliente'
          Title.Alignment = taCenter
          Title.Caption = 'Cliente'
          Title.Color = clHighlight
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 283
          Visible = True
        end>
    end
    object pnl_confirma: TPanel
      Left = 74
      Top = 328
      Width = 137
      Height = 41
      BevelOuter = bvNone
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      object btn_confirma: TSpeedButton
        Left = 0
        Top = 0
        Width = 137
        Height = 41
        Align = alClient
        Caption = 'Confirmar'
        Flat = True
        OnClick = btn_confirmaClick
        ExplicitLeft = 26
        ExplicitTop = -5
      end
    end
  end
  object ds_consulta: TDataSource
    Left = 528
    Top = 385
  end
end
