object DM: TDM
  Height = 480
  Width = 640
  object conexao: TOraSession
    Options.Direct = True
    Username = 'admin'
    Server = '192.168.1.194'
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 400
    EncryptedPassword = 'B2FFBEFFB1FFBEFFB8FFBAFFADFF'
  end
  object Tqry_CadClientes: TOraQuery
    Session = conexao
    SQL.Strings = (
      'SELECT ID,'
      '       ATIVO,'
      '       TIPO_CADASTRO,'
      '       NOME_CLIENTE,'
      '       RAZAO_SOCIAL,'
      '       ESTADO_CIVIL,'
      '       OBSERVACOES_CADASTRAIS,'
      '       ENDERECO,'
      '       CEP,'
      '       BAIRRO,'
      '       CIDADE,'
      '       END_OBSERVACOES,'
      '       DT_CADASTRO'
      '  FROM CADASTROS_CLIENTES')
    Active = True
    Left = 124
    Top = 400
    object Tqry_CadClientesATIVO: TStringField
      FieldName = 'ATIVO'
      FixedChar = True
      Size = 1
    end
    object Tqry_CadClientesTIPO_CADASTRO: TStringField
      FieldName = 'TIPO_CADASTRO'
      Size = 10
    end
    object Tqry_CadClientesNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Size = 100
    end
    object Tqry_CadClientesRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
    object Tqry_CadClientesESTADO_CIVIL: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 100
    end
    object Tqry_CadClientesOBSERVACOES_CADASTRAIS: TStringField
      FieldName = 'OBSERVACOES_CADASTRAIS'
      Size = 400
    end
    object Tqry_CadClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 50
    end
    object Tqry_CadClientesCEP: TIntegerField
      FieldName = 'CEP'
    end
    object Tqry_CadClientesBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object Tqry_CadClientesCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 30
    end
    object Tqry_CadClientesEND_OBSERVACOES: TStringField
      FieldName = 'END_OBSERVACOES'
      Size = 200
    end
    object Tqry_CadClientesDT_CADASTRO: TDateTimeField
      FieldName = 'DT_CADASTRO'
    end
    object Tqry_CadClientesID: TFloatField
      FieldName = 'ID'
      Required = True
    end
  end
  object dt_qry_CadClientes: TDataSource
    DataSet = Tqry_CadClientes
    Left = 240
    Top = 400
  end
  object FDTable1: TFDTable
    MasterSource = dt_qry_CadClientes
    MasterFields = 
      'ATIVO;BAIRRO;CEP;CIDADE;DT_CADASTRO;END_OBSERVACOES;ENDERECO;EST' +
      'ADO_CIVIL;ID;NOME_CLIENTE;OBSERVACOES_CADASTRAIS;RAZAO_SOCIAL;TI' +
      'PO_CADASTRO'
    Left = 352
    Top = 400
  end
end
