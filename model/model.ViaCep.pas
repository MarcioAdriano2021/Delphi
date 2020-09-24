unit model.ViaCep;

interface

uses
  System.Classes,
  System.SysUtils,
  model.Endereco,
  udmCadastroCliente;

Type

  IViaCep = interface
    ['{186E2B9A-1A86-4D94-8A3C-E933219ED960}']
    function getEndereco(pCEP: integer): IViaCep;
  end;

  TViaCep = class(TInterfacedObject, IViaCep)
  private
    FOnReceiveEndereco: TEventEndereco;
  public
    constructor Create(ReceiveEndereco: TEventEndereco);
    function getEndereco(pCEP: integer): IViaCep;
  end;

implementation

{ TViaCep }


constructor TViaCep.Create(ReceiveEndereco: TEventEndereco);
begin
  FOnReceiveEndereco := ReceiveEndereco;
end;

function TViaCep.getEndereco(pCEP: integer): IViaCep;
  function ZeroEsquerda(vZero: string; vQtd: integer): String;
  var
   i, vTam: integer;
   vAux: String;
  begin
    vAux := vZero;
    vTam := length( vZero );
    vZero := '';
    for i := 1 to vQtd - vTam do
      vZero := '0' + vZero;
    vAux := vZero + vAux;
    result := vAux;
  end;
var
  Endereco: TEndereco;
begin
  Result := Self;
  {== Observação de Segurança ==
   Windows 7 setar as RESTClientViaCep.SecureProtocols
     SSL2 = false
     SSL3 = false
     TLS1 = true
     TLS11 = true
     TLS12 = true
   Windows 10 setar as RESTClientViaCep.SecureProtocols
     SSL2 = false
     SSL3 = false
     TLS1 = false
     TLS11 = false
     TLS12 = false}
  dmCadastroCliente.RESTClientViaCep.BaseURL := Format('https://viacep.com.br/ws/%s/json/',[ZeroEsquerda(pCep.ToString,8)]);
  dmCadastroCliente.RESTRequestViaCep.Execute;
  Endereco := TEndereco.Create;
  with Endereco do
  begin
    if dmCadastroCliente.MemViaCep.Fields[0].FieldName = 'cep' then
    begin
      Cep := dmCadastroCliente.MemViaCep.FieldByName('cep').AsString;
      Logradouro := dmCadastroCliente.MemViaCep.FieldByName('logradouro').AsString;
      Bairro := dmCadastroCliente.MemViaCep.FieldByName('bairro').AsString;
      Cidade := dmCadastroCliente.MemViaCep.FieldByName('localidade').AsString;
      Estado := dmCadastroCliente.MemViaCep.FieldByName('uf').AsString;
    end;
  end;
  FOnReceiveEndereco(Endereco);
end;

end.
