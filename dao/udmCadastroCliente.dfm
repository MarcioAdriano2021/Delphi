object dmCadastroCliente: TdmCadastroCliente
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 384
  Width = 412
  object MemCliente: TFDMemTable
    BeforePost = MemClienteBeforePost
    AfterPost = MemClienteAfterPost
    IndexFieldNames = 'cpf'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateMode, uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'cpf'
    Left = 40
    Top = 240
    object MemClientecpf: TLargeintField
      FieldName = 'cpf'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MemClientenome: TStringField
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object MemClienteidentidade: TLargeintField
      FieldName = 'identidade'
      Required = True
    end
    object MemClienteemail: TStringField
      FieldName = 'email'
      Required = True
      Size = 60
    end
    object MemClientetelefone: TLargeintField
      FieldName = 'telefone'
    end
    object MemClientecep: TIntegerField
      FieldName = 'cep'
      Required = True
      DisplayFormat = '00000000'
    end
    object MemClientelogradouro: TStringField
      FieldName = 'logradouro'
      Required = True
      Size = 60
    end
    object MemClientenumero: TIntegerField
      FieldName = 'numero'
      Required = True
    end
    object MemClientecomplemento: TStringField
      FieldName = 'complemento'
    end
    object MemClientebairro: TStringField
      FieldName = 'bairro'
      Size = 40
    end
    object MemClientecidade: TStringField
      FieldName = 'cidade'
      Required = True
      Size = 40
    end
    object MemClienteestado: TStringField
      FieldName = 'estado'
      Required = True
      Size = 2
    end
    object MemClientepais: TStringField
      FieldName = 'pais'
      Required = True
      Size = 40
    end
  end
  object RESTRequestViaCep: TRESTRequest
    Client = RESTClientViaCep
    Params = <>
    Response = RESTResponseViaCep
    SynchronizedEvents = False
    Left = 48
    Top = 24
  end
  object RESTResponseViaCep: TRESTResponse
    ContentType = 'application/json'
    Left = 48
    Top = 80
  end
  object RESTClientViaCep: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://viacep.com.br/ws/30240360/json'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 48
    Top = 144
  end
  object MemViaCep: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 216
    Top = 24
  end
  object RESTResponseDataSetAdapterViaCep: TRESTResponseDataSetAdapter
    Dataset = MemViaCep
    FieldDefs = <>
    Response = RESTResponseViaCep
    Left = 216
    Top = 80
  end
end
