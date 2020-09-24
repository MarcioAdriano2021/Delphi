object frmCadastroCliente: TfrmCadastroCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 510
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 41
    Align = alTop
    TabOrder = 0
    object nvCadastroCliente: TDBNavigator
      Left = 1
      Top = 1
      Width = 579
      Height = 39
      DataSource = dsCliente
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbEdit, nbPost, nbCancel]
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 581
    Height = 428
    Align = alClient
    TabOrder = 1
    object gbEndereco: TGroupBox
      Left = 1
      Top = 153
      Width = 579
      Height = 274
      Align = alClient
      Caption = 'Endere'#231'o'
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 10
        Top = 82
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label2: TLabel
        Left = 374
        Top = 82
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object Label3: TLabel
        Left = 443
        Top = 82
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label4: TLabel
        Left = 205
        Top = 144
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label5: TLabel
        Left = 10
        Top = 136
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label11: TLabel
        Left = 10
        Top = 204
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label12: TLabel
        Left = 61
        Top = 204
        Width = 19
        Height = 13
        Caption = 'Pa'#237's'
      end
      object Label13: TLabel
        Left = 10
        Top = 26
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object edLogradouro: TDBEdit
        Left = 10
        Top = 98
        Width = 350
        Height = 21
        DataField = 'logradouro'
        DataSource = dsCliente
        TabOrder = 1
      end
      object edNumero: TDBEdit
        Left = 372
        Top = 98
        Width = 60
        Height = 21
        DataField = 'numero'
        DataSource = dsCliente
        TabOrder = 2
      end
      object edComplemento: TDBEdit
        Left = 441
        Top = 98
        Width = 99
        Height = 21
        DataField = 'complemento'
        DataSource = dsCliente
        TabOrder = 3
      end
      object edBairro: TDBEdit
        Left = 10
        Top = 160
        Width = 175
        Height = 21
        DataField = 'bairro'
        DataSource = dsCliente
        TabOrder = 4
      end
      object edCidade: TDBEdit
        Left = 206
        Top = 160
        Width = 196
        Height = 21
        DataField = 'cidade'
        DataSource = dsCliente
        TabOrder = 5
      end
      object edEstado: TDBEdit
        Left = 10
        Top = 224
        Width = 33
        Height = 21
        DataField = 'estado'
        DataSource = dsCliente
        TabOrder = 6
      end
      object edPais: TDBEdit
        Left = 62
        Top = 222
        Width = 123
        Height = 21
        DataField = 'pais'
        DataSource = dsCliente
        TabOrder = 7
      end
      object edCEP: TDBEdit
        Left = 8
        Top = 42
        Width = 63
        Height = 21
        DataField = 'cep'
        DataSource = dsCliente
        MaxLength = 8
        TabOrder = 0
        OnChange = edCEPChange
      end
    end
    object gbDados: TGroupBox
      Left = 1
      Top = 1
      Width = 579
      Height = 152
      Align = alTop
      Caption = 'Dados Pessoais'
      Color = cl3DLight
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object Label6: TLabel
        Left = 10
        Top = 26
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label7: TLabel
        Left = 370
        Top = 26
        Width = 66
        Height = 13
        Caption = 'N. Identidade'
      end
      object Label8: TLabel
        Left = 461
        Top = 26
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object Label9: TLabel
        Left = 369
        Top = 88
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label10: TLabel
        Left = 10
        Top = 80
        Width = 28
        Height = 13
        Caption = 'E-Mail'
      end
      object edNome: TDBEdit
        Left = 10
        Top = 42
        Width = 350
        Height = 21
        DataField = 'nome'
        DataSource = dsCliente
        TabOrder = 0
      end
      object edIdentidade: TDBEdit
        Left = 370
        Top = 42
        Width = 72
        Height = 21
        DataField = 'identidade'
        DataSource = dsCliente
        MaxLength = 8
        TabOrder = 1
      end
      object edCPF: TDBEdit
        Left = 461
        Top = 42
        Width = 87
        Height = 21
        DataField = 'cpf'
        DataSource = dsCliente
        MaxLength = 11
        TabOrder = 2
      end
      object edEmail: TDBEdit
        Left = 10
        Top = 104
        Width = 350
        Height = 21
        DataField = 'email'
        DataSource = dsCliente
        TabOrder = 3
      end
      object edTelefone: TDBEdit
        Left = 369
        Top = 104
        Width = 108
        Height = 21
        DataField = 'telefone'
        DataSource = dsCliente
        TabOrder = 4
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 469
    Width = 581
    Height = 41
    Align = alBottom
    TabOrder = 2
  end
  object dsCliente: TDataSource
    DataSet = dmCadastroCliente.MemCliente
    Left = 185
    Top = 232
  end
end
