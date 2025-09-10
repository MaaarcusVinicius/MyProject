object DmModule: TDmModule
  Height = 328
  Width = 359
  object orsConexao: TOraSession
    Left = 152
    Top = 96
  end
  object ortConexao: TOraTransaction
    DefaultSession = orsConexao
    Left = 152
    Top = 160
  end
end
