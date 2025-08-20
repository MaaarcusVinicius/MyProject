object Principal: TPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 577
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Label1: TLabel
    Left = 308
    Top = 162
    Width = 79
    Height = 23
    Caption = 'Oracle 19'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object vUser: TEdit
    Left = 344
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'ADMIN'
  end
  object vSenha: TEdit
    Left = 344
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'MANAGER'
  end
  object vServidor: TEdit
    Left = 344
    Top = 94
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '192.168.0.206'
  end
  object btnConectar: TButton
    Left = 390
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 3
    OnClick = btnConectarClick
  end
  object vDirect: TCheckBox
    Left = 344
    Top = 121
    Width = 97
    Height = 17
    Caption = 'direct'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object dbgrd_oracle: TDBGrid
    Left = 7
    Top = 320
    Width = 608
    Height = 233
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'EMPRESA_ID'
        Title.Caption = 'empresa_id'
        Width = 193
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RAZAO_SOCIAL'
        Title.Caption = 'razao_social'
        Width = 392
        Visible = True
      end>
  end
end
