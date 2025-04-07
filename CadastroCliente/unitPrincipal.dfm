object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Cadastros de Clientes'
  ClientHeight = 626
  ClientWidth = 848
  Color = clInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = [fsBold]
  TextHeight = 13
  object Label1: TLabel
    Left = 160
    Top = -8
    Width = 293
    Height = 45
    Caption = 'Cadastro de Clientes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -32
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 112
    Width = 168
    Height = 15
    Caption = 'Nome Cliente / Fantasia'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 164
    Width = 87
    Height = 15
    Caption = 'Raz'#227'o Social'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 89
    Top = 336
    Width = 87
    Height = 15
    Caption = 'Observa'#231#245'es'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 117
    Top = 530
    Width = 132
    Height = 17
    DataField = 'DT_CADASTRO'
    DataSource = DM.dt_qry_CadClientes
  end
  object Label4: TLabel
    Left = 8
    Top = 529
    Width = 103
    Height = 15
    Caption = 'Data Cadastro:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 184
    Top = 46
    Width = 70
    Height = 15
    Caption = 'ID Cliente'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText3: TDBText
    Left = 184
    Top = 67
    Width = 89
    Height = 23
    DataField = 'ID'
    DataSource = DM.dt_qry_CadClientes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 322
    Top = 271
    Width = 188
    Height = 15
    Caption = 'Busca clientes Cadastrados'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Lucida Fax'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Painel1: TPanel
    Left = 321
    Top = 43
    Width = 519
    Height = 200
    TabOrder = 0
    object Label8: TLabel
      Left = 0
      Top = 31
      Width = 51
      Height = 13
      Caption = 'Endere'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 1
      Top = 1
      Width = 517
      Height = 21
      Align = alTop
      Alignment = taCenter
      Caption = 'Dados do endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      ExplicitWidth = 137
    end
    object Label9: TLabel
      Left = 28
      Top = 57
      Width = 23
      Height = 13
      Caption = 'CEP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 14
      Top = 115
      Width = 37
      Height = 13
      Caption = ' Bairro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 13
      Top = 86
      Width = 38
      Height = 13
      Caption = 'Estado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 200
      Top = 55
      Width = 132
      Height = 13
      Caption = 'Observa'#231#245'es de Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 155
      Width = 36
      Height = 13
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboBox2: TComboBox
      Left = 57
      Top = 86
      Width = 121
      Height = 21
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'AC - ACRE'
      Items.Strings = (
        'AC - ACRE'
        'AL - ALAGOAS'
        'AM - AMAZONAS'
        'AP - AMAPA'
        'BA - BAHIA'
        'CE - CEARA'
        'DF - DISTRITO FEDERAL'
        'ES - ESPIRITO SANTO'
        'GO - GOIAS'
        'MA - MARANHAO'
        'MG - MINAS GERAIS'
        'MS - MATO GROSSO DO SUL'
        'MT - MATO GROSSO'
        'PA - PARA'
        'PB - PARAIBA'
        'PE - PERNAMBUCO'
        'PI - PIAUI'
        'PR - PARANA'
        'RJ - RIO DE JANEIRO'
        'RN - RIO GRANDE DO NORTE'
        'RO - RONDONIA'
        'RR - RORAIMA'
        'RS - RIO GRANDE DO SUL'
        'SC - SANTA CATARINA'
        'SE - SERGIPE'
        'SP - SAO PAULO'
        'TO - TOCANTINS')
    end
    object DBEdit3: TDBEdit
      Left = 57
      Top = 24
      Width = 376
      Height = 25
      DataField = 'ENDERECO'
      DataSource = DM.dt_qry_CadClientes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object DBEdit4: TDBEdit
      Left = 57
      Top = 55
      Width = 121
      Height = 25
      DataField = 'CEP'
      DataSource = DM.dt_qry_CadClientes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object DBEdit5: TDBEdit
      Left = 57
      Top = 113
      Width = 120
      Height = 25
      DataField = 'BAIRRO'
      DataSource = DM.dt_qry_CadClientes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object DBMemo2: TDBMemo
      Left = 184
      Top = 74
      Width = 249
      Height = 99
      DataField = 'END_OBSERVACOES'
      DataSource = DM.dt_qry_CadClientes
      TabOrder = 4
    end
    object DBEdit6: TDBEdit
      Left = 57
      Top = 144
      Width = 121
      Height = 21
      DataField = 'CIDADE'
      DataSource = DM.dt_qry_CadClientes
      TabOrder = 5
    end
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 133
    Width = 297
    Height = 21
    DataField = 'NOME_CLIENTE'
    DataSource = DM.dt_qry_CadClientes
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 185
    Width = 297
    Height = 21
    DataField = 'RAZAO_SOCIAL'
    DataSource = DM.dt_qry_CadClientes
    TabOrder = 2
  end
  object DBCheckBox1: TDBCheckBox
    Left = 669
    Top = 23
    Width = 97
    Height = 17
    Caption = 'ATIVO'
    DataField = 'ATIVO'
    DataSource = DM.dt_qry_CadClientes
    TabOrder = 3
  end
  object DBMemo1: TDBMemo
    Left = 8
    Top = 357
    Width = 297
    Height = 148
    DataField = 'OBSERVACOES_CADASTRAIS'
    DataSource = DM.dt_qry_CadClientes
    TabOrder = 4
  end
  object DBRadioGroup1: TDBRadioGroup
    Left = 8
    Top = 225
    Width = 146
    Height = 88
    Caption = 'Estado Civil'
    DataField = 'ESTADO_CIVIL'
    DataSource = DM.dt_qry_CadClientes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    Items.Strings = (
      'Solteiro(a)'
      'Casado(a)'
      'Divorciado(a)')
    ParentFont = False
    TabOrder = 5
    Values.Strings = (
      'Solteiro'
      'Casado'
      'Divorciado')
  end
  object DBGrid1: TDBGrid
    Left = 321
    Top = 319
    Width = 519
    Height = 233
    DataSource = DM.dt_qry_CadClientes
    GradientStartColor = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -16
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Caption = 'Cod. Cliente'
        Width = 103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'Contatos Cadastrados'
        Title.Color = clBlue
        Width = 418
        Visible = True
      end>
  end
  object DBRadioGroup2: TDBRadioGroup
    Left = 8
    Top = 22
    Width = 153
    Height = 84
    Caption = 'Tipo Cadastro'
    DataField = 'TIPO_CADASTRO'
    DataSource = DM.dt_qry_CadClientes
    Items.Strings = (
      'Jur'#237'dica'
      'F'#237'sica'
      'Outros')
    TabOrder = 7
  end
  object txtBusca: TEdit
    Left = 321
    Top = 292
    Width = 519
    Height = 21
    TabOrder = 8
  end
  object DBNavigator1: TDBNavigator
    Left = 336
    Top = 576
    Width = 480
    Height = 25
    DataSource = DM.dt_qry_CadClientes
    TabOrder = 9
  end
end
