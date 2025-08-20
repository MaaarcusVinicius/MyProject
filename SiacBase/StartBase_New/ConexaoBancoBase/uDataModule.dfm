object DmModule: TDmModule
  Height = 328
  Width = 359
  object orsConexao: TOraSession
    Options.Direct = True
    Username = 'ADMIN'
    Server = 'SVR-ORACLE'
    Left = 152
    Top = 96
    EncryptedPassword = 'B2FFBEFFB1FFBEFFB8FFBAFFADFF'
  end
  object ortConexao: TOraTransaction
    DefaultSession = orsConexao
    Left = 152
    Top = 160
  end
end
