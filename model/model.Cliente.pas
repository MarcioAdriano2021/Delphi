unit model.Cliente;

interface

uses
  model.Endereco;

Type
  TCliente = class
  private
    FCPF: String;
    FNome: String;
    FIdentidade: integer;
    FEmail: String;
    FTelefone: String;
    FEndereco: TEndereco;
    procedure SetCPF(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetIdentidade(const Value: integer);
    procedure SetEmail(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetEndereco(const Value: TEndereco);
  public
    Constructor create;
    destructor Destroy; override;
    property CPF: String read FCPF write SetCPF;
    property Nome: String read FNome write SetNome;
    property Identidade: integer read FIdentidade write SetIdentidade;
    property Email: String read FEmail write SetEmail;
    property Telefone: String read FTelefone write SetTelefone;
    property Endereco: TEndereco read FEndereco write SetEndereco;
  end;

implementation

{ TCliente }

constructor TCliente.create;
begin
  FEndereco := TEndereco.create;
end;

destructor TCliente.destroy;
begin
  FEndereco.DisposeOf;
  inherited;
end;

procedure TCliente.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetIdentidade(const Value: integer);
begin
  FIdentidade := Value;
end;

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure TCliente.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

end.
