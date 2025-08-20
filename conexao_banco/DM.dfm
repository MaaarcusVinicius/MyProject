object DataModule3: TDataModule3
  Height = 480
  Width = 640
  object ds_oracle: TOraDataSource
    DataSet = qry_oracle
    Left = 72
    Top = 168
  end
  object qry_oracle: TOraQuery
    Session = OraSession
    SQL.Strings = (
      'SELECT EMPRESA_ID, RAZAO_SOCIAL FROM EMPRESAS')
    Left = 72
    Top = 96
    object qry_oracleEMPRESA_ID: TStringField
      FieldName = 'EMPRESA_ID'
      Required = True
      Size = 18
    end
    object qry_oracleRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 40
    end
  end
  object OraSession: TOraSession
    Options.Direct = True
    Username = 'ADMIN'
    Server = '192.168.0.206'
    Connected = True
    Left = 72
    Top = 16
    EncryptedPassword = 'B2FFBEFFB1FFBEFFB8FFBAFFADFF'
  end
end
