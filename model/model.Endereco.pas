unit model.Endereco;

interface

Type
  TEndereco = class;

  TEventEndereco = procedure(pEndereco: TEndereco) of object;

  TEndereco = class
  private
    FCep: String;
    FLogradouro: String;
    FNumero: integer;
    FComplemento: String;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FPais: String;
    procedure SetCep(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetNumero(const Value: integer);
    procedure SetComplemento(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetPais(const Value: String);
  public
    property Cep: String read FCep write SetCep;
    property Logradouro: String read FLogradouro write SetLogradouro;
    property Numero: integer read FNumero write SetNumero;
    property Complemento: String read FComplemento write SetComplemento;
    property Bairro: String read FBairro write SetBairro;
    property Cidade: String read FCidade write SetCidade;
    property Estado: String read FEstado write SetEstado;
    property Pais: String read FPais write SetPais;
  end;

implementation

{ TEndereco }

procedure TEndereco.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TEndereco.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: integer);
begin
  FNumero := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TEndereco.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TEndereco.SetPais(const Value: String);
begin
  FPais := Value;
end;

end.
