object form_dados: Tform_dados
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object MySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\MySQL\MySQL Server 5.7\lib\libmysql.dll'
    Left = 168
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 528
    Top = 392
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=agenda'
      'User_Name=root'
      'Password=root'
      'Server=LocalHost'
      'DriverID=MySQL')
    Left = 64
    Top = 72
  end
end
