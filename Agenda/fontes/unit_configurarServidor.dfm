object form_configurarServidor: Tform_configurarServidor
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 's'
  ClientHeight = 509
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object shp_fundo: TShape
    Left = 0
    Top = 0
    Width = 874
    Height = 509
    Align = alClient
    ExplicitHeight = 521
  end
  object pnl_fundo: TPanel
    Left = 8
    Top = 8
    Width = 858
    Height = 493
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object pnl_configServidor: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 68
      Width = 852
      Height = 230
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lbl_configServidor: TLabel
        Left = 16
        Top = 0
        Width = 187
        Height = 20
        Caption = 'Configurando seu Servidor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_configCaminhoServidor: TLabel
        Left = 16
        Top = 43
        Width = 249
        Height = 19
        Caption = 'Caminho do Banco de dados / Servidor *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configBaseServidor: TLabel
        Left = 16
        Top = 119
        Width = 168
        Height = 19
        Caption = 'Nome da Base de DADOS *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configLoginServidor: TLabel
        Left = 287
        Top = 119
        Width = 52
        Height = 19
        Caption = 'LOGIN *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configPortaServidor: TLabel
        Left = 568
        Top = 43
        Width = 42
        Height = 19
        Caption = 'Porta *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configSenhaServidor: TLabel
        Left = 568
        Top = 119
        Width = 53
        Height = 19
        Caption = 'SENHA *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object pnl_linhaCofigServidor: TPanel
        Left = 8
        Top = 21
        Width = 835
        Height = 1
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 0
      end
      object edt_configCaminhoServidor: TEdit
        Tag = 5
        Left = 16
        Top = 68
        Width = 529
        Height = 23
        Hint = 'Caminho do banco de dados'
        TabOrder = 1
        Text = 'LOCALHOST'
      end
      object edt_configBaseServidor: TEdit
        Tag = 5
        Left = 16
        Top = 144
        Width = 265
        Height = 23
        Hint = 'Usu'#225'rio Banco de Dados'
        TabOrder = 2
        Text = 'AGENDA'
      end
      object edt_configLoginServidor: TEdit
        Tag = 5
        Left = 287
        Top = 144
        Width = 258
        Height = 23
        Hint = 'Login'
        TabOrder = 3
        Text = 'root'
      end
      object edt_configPortaServidor: TEdit
        Tag = 5
        Left = 568
        Top = 64
        Width = 265
        Height = 23
        TabOrder = 4
        Text = '3306'
      end
      object edt_configSenhaServidor: TEdit
        Tag = 5
        Left = 568
        Top = 144
        Width = 265
        Height = 23
        Hint = 'Senha'
        PasswordChar = '*'
        TabOrder = 5
        Text = 'root'
      end
      object pnl_botoes: TPanel
        Left = 574
        Top = 183
        Width = 275
        Height = 41
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 6
        object pnl_confirma: TPanel
          Left = 0
          Top = 0
          Width = 137
          Height = 41
          Align = alLeft
          BevelOuter = bvNone
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object btn_confirma: TSpeedButton
            Left = 0
            Top = 0
            Width = 137
            Height = 41
            Align = alClient
            Caption = 'Confirmar'
            Flat = True
            OnClick = btn_confirmaClick
            ExplicitLeft = -5
            ExplicitTop = 3
          end
        end
        object pnl_nao: TPanel
          Left = 138
          Top = 0
          Width = 137
          Height = 41
          Align = alRight
          BevelOuter = bvNone
          Color = clCrimson
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          object btn_cancelar: TSpeedButton
            Left = 0
            Top = 0
            Width = 137
            Height = 41
            Align = alClient
            Caption = 'Cancelar'
            Flat = True
            OnClick = btn_cancelarClick
            ExplicitLeft = 5
            ExplicitTop = 3
          end
        end
      end
    end
    object pnl_configCabecario: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 852
      Height = 62
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object img_config: TImage
        Left = 0
        Top = 0
        Width = 68
        Height = 67
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
          003008060000005702F987000000097048597300000B1300000B1301009A9C18
          00000A284944415478DAC55A6B6C14D7153E77661F5EAF1FEB35C64E10384845
          A5D0269448E98F0082101A681B52515192363F2AEA125BEA23D4D43CFFA40430
          75D26724E2B649D550554D297D44940201153010F3302D546D200D8F52307EAE
          ED7DCECCCECCED77C663CB90F5631D2F1DE9F81EEFCEDC7BBE7BCE3DE7BB7756
          D018AFC99327D3134F2CA5050B17D2238F7C8A42A162F2A82A298A4242080512
          945256F0AD9010A460C8E3121283F440DA716F273E4AD8B694B66D9365D994D2
          346A3A7E8C8E1D3D4A070F1EA08E8E8E31D92546BB61EAB469B4766D2D2D7E7C
          3115161692C7E32158CB063E0AE3E741E64266AA8A5201C3BCFDD64AC17F868C
          21F9AF0054D661B70EC35B21FFB26CBB05289AF06C33FE4FA44D9362B1381D39
          7C985E79E5C774F5CA95F10358F9C55554B77E0315171793179663869FF27A3D
          5FF1FB7C8B548F9A9F4E9B229D4E4BD3B4C8B42C21D93439C468FAA00E085211
          0AE179813E25FA13DCB5699A7DBA9E3E605AE66BB8E9889936652C1EA7EFBFFC
          12FD6AF71BD9037872F972FAEE8BDB299097C7373DE9F7FB5F2E080666A43483
          92A91419467AACD1377A1860009FCF47C1FC005A2F3C90688127BE09DCA75229
          8DB66F7B917EFBE66FB203F0E69EBD3473E64C9EB2174AC3255B8C745AF44563
          026E96773D2F3FA47EC767AAAACA92E222D6CDDE68AC86A47CAD1DEB61C9630B
          B303F0CE99B3081BEFE3A1E2E2839871058BECEEC1720260402F2C080AAC2D3D
          1A8BCF89442297962E599C1D80D3006049AACFCBCB5B1F4F24478B829C5C85C1
          7CC2ECAFE9EAECFCD9B35F7A3A3B0067CE9EC35CC886444AAFC5CACC345B39F5
          00EB58D8F2BDCBEFD6205134AE7DFE5BD901686969E1AF1B905D6A118B0369F1
          9E01C05A13EFBF7749467A223526006CDDBA353B00E7CF9FE7A601D9671DDFD6
          D1DD4D0984929494F3CB320DEA686B43316BA7542A550D4F34EEDCB9337B00C8
          400D486FB5814040602D48DD30446767B7EC04185D3726D4031E8FCA295B5869
          43F6F6F61016AE80C86432596359D6C4008008FC8FE2E325A454BADDD686417A
          641C0547D3743158C6C60000951B054C95288A22180CC8607E3EF15A63A32113
          0A601D00108C770421E5141DBE12890461803BDA045A5DD79D42678116607002
          5D8071B6C39B983FF104701F03ED409F8CDF357E50D06FF5847B800774010808
          CF120F2410AF12C2000444227B10E257C000C9C629CEAC7BA46BB8402BB9457F
          D20530E11ED8868E37FE3F01A0BF2A3CFF7A7D7D7D7600CE9D3BC7CCF3610C72
          0A007C63092136DE05E0880BC009231780C366B308A15ECCE22712F1F8CD1D3B
          766407E0976FECA659B367330BDD88B2BE1D20EEA907FAFAA2C2EBF37D19DCE8
          D7ADADADB471C3FAEC001C3AF2579EF14958746791DE1E2840592F2D0DDF030F
          F480ED6A545E514E46DA3CA76BDA3C1453FD334F2CC90EC0D1E32798E3D7E507
          02F5E0424EFAE33C5D515E26CBB13B0B04F226D403AAEA2166BC294D97BCFBE1
          FD4F30982F63B1D84A7864EF33AB566607E0E4A97730B8D5A0E946ADED7021CE
          F1C269B9FB00B83B72B7B329E1D46E9A6961C0680D5BC39100B0D15E2F66DFE7
          0575F64A4555B011E25DDA803D03B5C4D9A7CAF6F6DB3558038D35D5CF6507E0
          0CD828BE6DE8E98DAEE36DDEE89718EC8C69135BC4B9BFDF9C7EECBC13E32D59
          A651D3DE76B2D5A8A32B763E798D29148B46E9DAD5F7AB6DCB6EDCB265737600
          98CC711DC022AAEDECEE1189642A67642E7D7FB3B4CA2F0ECC413FE4F607C4D5
          BF94C994960299331BB3CE42430B19671F2C2CD9D6D129B0E19643B7B8435D3E
          1E5D922DA20FD6CB78FAFA1DDF077D5345EBEF1E93C91E516399F6C45009CE16
          5868D4D515A18ECE2EEAE9ED65DA3B7A748D74A9609EB36AC926EB2EC3548AEE
          5B45896E4FB565CADC50096408D1D9D5257B7A7A291E4F084DD7A4C3812C1BC4
          CE7616AE93521C92E74C2CB68942AA8A8A74AA22FBA0AF00897F54ACCEE8A1D8
          9F9F91C96E4F4DCE004C441AF5F86D71B1FCAB19D7487CFFC40018331B1D4F21
          0300BA505695D186C481A729194108A5C70FE01B18E847B9F580147F9B5495D1
          03A983ABA41655979B9AD89735993B74E810954D9E5CE8F37A4F00C083B904D0
          52FAB5CC9BFA934F1DF695269729050933E5FF8FFBB1244B629DD90699B6363C
          803D7BFF40959595BC967E120E157D3D7F4826CA368452FE6B64AA7DBC820975
          8517303175E056F14ABA1A6CCC684350FFD84E4B4D9E55F22C3C3BB4FC20F94A
          2B82BA7E6C5800C79A4EF2804B4117F66B9851784296974D12E17049561E8884
          DF16FEE9DDFD29C83DDCBD6BB6457BECA2346DFD0E0FA06A8BFB8A1E1EA1000A
          EA4A5CFEC5B0004EF473A17A4555EB901A0707CB03F12A2D2DA1925008DB43C5
          317424006D331A45D4BE8600B28631647C159C8B76D057660D0BA0F9F4691429
          D9108D27D70D770FF31A90392714B823CBB6C884D14EE8B8E17379CA0B9446F8
          E4E202BB1A7947C66934A519FD075BE33C99BB10DE204C253AAE93B931E8633A
          D8AAC5C6428007495D37B20670B9E40722E1BD9E2B00FF1D7325E6F419055D68
          6FEF90115007F70868D44134B54DDC2A7A4B9A4A3CE33DFC3647F3DCCEFC3224
          592C6D61DE147EAD9B54EB6E137BC151368DAB12F3085D5DDD74BBADDD2174C9
          4492776F94CDC5F988CF885007A8B97043C67BF29A97936EF75553E5B546A5F2
          7AE67EC6EA81910A19D7012676D87A3A59C8300CE7D5937BA825A4ED503B7EB7
          266034BF561A2C64AA4F8A83E2F98C642E78E67352EF536A2CDB6C7CF5F51F8E
          1B404EB91000D07EFBDB196D286CF92C19BDCA87A2D33B30D0FA5C7221051ED8
          67AECBB80642E79749A34F5D635BF2E7597321068001176190B70140CD25803F
          E9DFC908207C61A9661AF61C2BEEB99C3580DDBB77D39C397398BB6C84E1DBD8
          F85C841000D0EF53990FAD0A5A673DE74914FDB4E75D41BB76ED1A1D40515111
          AD58B18266CC9841D3A74FA78282024742A1D0A7CBCACA5E0A06831F1F38889A
          380F90D813DF90D10345FAB48FDC9F987B252C2B9D49BA75EB16353535D1F1E3
          C7330358BD7A352D5AB4C8F99C13065A2F06F5C20BE072DE60381C5E0686FA6C
          4545C55C18E29FA883ADB7E2DF937D56C71D0054F2F63D94FCFCECA03529EA21
          BF81E7F96CC766FA525757477CDCF801006BD6ACA1050B16A850A7411E72DB32
          48B12B1C3B8518B8A4B4B4F43E782C8CB0CA47A72A8C149AA689318690E4F7C1
          78CEE29F17741BADB17F8B1393D242637B6C24DAF4D4F4279B43D694BF53FFEF
          2B6E412E41FE09496DDAB4896EDCB89119C0FCF9F3D9C847D1F91730E847A197
          422F801E40EB47ABE033F68E87DDE4BEC164958DE354CFDFF71F98382F36E4A0
          38875A30D015FE4CF677E14CBA05DD84CE15310D3D053DC500A0DF847E04FA1F
          A1778D06803F2BC68D53F010CF7E09F462E805684368D94341F71ED505E0FC62
          053ABF620FB83AB99FD3109D8DD5A0F6F1EC0F80927C84479484DEEB0248B87A
          027A047A043AC74C07831C16C0BC79F3A8AAAACA71B37B29434475675EB8ADD7
          FD7CE87ACA73C36CA41F91F08F2C52035E702F46C8316EB8BAEDFE6F0F116716
          DADADA68F3E6CD4E88F2F53F834139E8085113680000000049454E44AE426082}
      end
      object lbl_configServidorCabecario: TLabel
        Left = 71
        Top = 0
        Width = 230
        Height = 25
        Caption = 'Configura'#231#227'o de Servidor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSkyBlue
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_configInstrucao: TLabel
        Left = 71
        Top = 31
        Width = 361
        Height = 17
        Caption = 'Preencha de acordo com a configura'#231#227'o do banco de dados.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object pnl_configServidroSair: TPanel
        Left = 712
        Top = 16
        Width = 137
        Height = 32
        BevelOuter = bvNone
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btn_configServidorSair: TSpeedButton
          Left = 0
          Top = 0
          Width = 137
          Height = 32
          Align = alClient
          Caption = 'Sair'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btn_configServidorSairClick
          ExplicitLeft = 16
          ExplicitWidth = 157
          ExplicitHeight = 28
        end
      end
    end
    object pnl_configConsulta: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 301
      Width = 852
      Height = 188
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Enabled = False
      ParentBackground = False
      TabOrder = 2
      TabStop = True
      object lbl_configConsulta: TLabel
        Left = 16
        Top = 7
        Width = 135
        Height = 20
        Caption = 'Configura'#231#227'o Atual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_configBaseServidorAtual: TLabel
        Left = 16
        Top = 131
        Width = 168
        Height = 19
        Caption = 'Nome da Base de DADOS *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configCaminhoServidorAtual: TLabel
        Left = 16
        Top = 51
        Width = 249
        Height = 19
        Caption = 'Caminho do Banco de dados / Servidor *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configLoginServidorAtual: TLabel
        Left = 287
        Top = 131
        Width = 52
        Height = 19
        Caption = 'LOGIN *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configSenhaServidorAtual: TLabel
        Left = 568
        Top = 131
        Width = 53
        Height = 19
        Caption = 'SENHA *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbl_configPortaServidorAtual: TLabel
        Left = 568
        Top = 51
        Width = 42
        Height = 19
        Caption = 'Porta *'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object pnl_linhaCofigServidorConsulta: TPanel
        Left = 8
        Top = 33
        Width = 835
        Height = 1
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 0
      end
      object edt_configBaseServidorAtual: TEdit
        Left = 16
        Top = 152
        Width = 265
        Height = 23
        TabStop = False
        Color = clWhite
        ReadOnly = True
        TabOrder = 1
      end
      object edt_configCaminhoServidorAtual: TEdit
        Left = 16
        Top = 72
        Width = 529
        Height = 23
        TabStop = False
        Color = clWhite
        ReadOnly = True
        TabOrder = 2
      end
      object edt_configLoginServidorAtual: TEdit
        Left = 287
        Top = 152
        Width = 258
        Height = 23
        TabStop = False
        Color = clWhite
        ReadOnly = True
        TabOrder = 3
      end
      object edt_configSenhaServidorAtual: TEdit
        Left = 568
        Top = 152
        Width = 265
        Height = 23
        TabStop = False
        Color = clWhite
        ReadOnly = True
        TabOrder = 4
      end
      object edt_configPortaServidorAtual: TEdit
        Left = 568
        Top = 72
        Width = 265
        Height = 23
        TabStop = False
        Color = clWhite
        ReadOnly = True
        TabOrder = 5
      end
    end
  end
end
