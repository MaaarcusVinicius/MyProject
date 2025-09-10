object DmModule: TDmModule
  Height = 328
  Width = 359
  object orsConexao: TOraSession
    Options.Direct = True
    Username = 'ADMIN'
    Server = '192.168.0.206'
    Connected = True
    LoginPrompt = False
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
