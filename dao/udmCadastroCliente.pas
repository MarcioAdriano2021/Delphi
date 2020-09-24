unit udmCadastroCliente;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Types, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmCadastroCliente = class(TDataModule)
    MemCliente: TFDMemTable;
    MemClientenome: TStringField;
    MemClienteemail: TStringField;
    MemClientecep: TIntegerField;
    MemClientelogradouro: TStringField;
    MemClientenumero: TIntegerField;
    MemClientecomplemento: TStringField;
    MemClientebairro: TStringField;
    MemClientecidade: TStringField;
    MemClienteestado: TStringField;
    MemClientepais: TStringField;
    MemClientecpf: TLargeintField;
    MemClientetelefone: TLargeintField;
    MemClienteidentidade: TLargeintField;
    RESTRequestViaCep: TRESTRequest;
    RESTResponseViaCep: TRESTResponse;
    RESTClientViaCep: TRESTClient;
    MemViaCep: TFDMemTable;
    RESTResponseDataSetAdapterViaCep: TRESTResponseDataSetAdapter;
    procedure DataModuleCreate(Sender: TObject);
    procedure MemClienteAfterPost(DataSet: TDataSet);
    procedure MemClienteBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    function ValidaCPF(CPF: String): boolean;
    procedure EnviarEmail(pDestinatario: String);
  public
    { Public declarations }
  end;

var
  dmCadastroCliente: TdmCadastroCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  model.Cliente,
  Controller.Cadastro,
  IdSMTP;

function TdmCadastroCliente.ValidaCPF(CPF: String): boolean;
var  dig10, dig11: String;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              result := false;
              exit;
            end;

  // try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
    { *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      // StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

    { *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then result := true
    else result := false;
  except
    result := false
  end;
end;

procedure TdmCadastroCliente.EnviarEmail(pDestinatario: String);
var
  LControllerCadastro: iControllerCadastro;
begin
  LControllerCadastro := TControllerCadastro.Create;
  LControllerCadastro.Email
   .setHost(
      satDefault,
      465,
      'smtp.gmail.com',
      'user@gmailcom',
      'passgmail')
   .setMessage(
      'marcioadrianoferreira2015@gmail.com',
      'Márcio Adriano Ferreira',
      pDestinatario,
      'Dados do cliente cadastrado em Anexo')
   .send(
      'Segue anexo os dados do cliente cadastrado.',
      'cliente.xml');
end;

procedure TdmCadastroCliente.DataModuleCreate(Sender: TObject);
begin
  MemCliente.Open;
end;

procedure TdmCadastroCliente.MemClienteAfterPost(DataSet: TDataSet);
var
  LCliente: TCliente;
  LControllerCadastro: iControllerCadastro;
begin
  {Grava o arquivo XML para enviar anexado ao email}
  LCliente := TCliente.Create;
  LControllerCadastro := TControllerCadastro.Create;
  try
    LCliente.Nome := DataSet.FieldByname('nome').asString;
    LCliente.Identidade := DataSet.FieldByname('identidade').asInteger;
    LCliente.CPF := DataSet.FieldByname('cpf').asString;
    LCliente.Telefone := DataSet.FieldByname('telefone').asString;
    LCliente.Email := DataSet.FieldByname('email').asString;
    LCliente.Endereco.Cep := DataSet.FieldByname('cpf').asString;
    LCliente.Endereco.Logradouro := DataSet.FieldByname('logradouro').asString;
    LCliente.Endereco.Numero := DataSet.FieldByname('numero').asinteger;
    LCliente.Endereco.Complemento := DataSet.FieldByname('complemento').asString;
    LCliente.Endereco.Bairro := DataSet.FieldByname('bairro').asString;
    LCliente.Endereco.Cidade := DataSet.FieldByname('cidade').asString;
    LCliente.Endereco.Estado := DataSet.FieldByname('estado').asString;
    LCliente.Endereco.Pais := DataSet.FieldByname('pais').asString;
    // Gravar XML
    LControllerCadastro.CriarXML(LCliente);
    // Enviar Email
    EnviarEmail(DataSet.FieldByname('email').asString);
  finally
    LCliente.Free;
  end;
end;

procedure TdmCadastroCliente.MemClienteBeforePost(DataSet: TDataSet);
begin
  if not ValidaCPF(DataSet.FieldByName('cpf').asString) then
    raise Exception.Create('CPF inválido. Cadastro não efetuado.');

  if DataSet.FieldByname('nome').asString = '' then
    raise Exception.Create('Nome não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('email').asString = '' then
    raise Exception.Create('E-mail não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('cep').asInteger = 0 then
    raise Exception.Create('CEP não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('logradouro').asString = '' then
    raise Exception.Create('Logradouro não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('numero').asinteger = 0 then
    raise Exception.Create('Número não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('bairro').asString = '' then
    raise Exception.Create('Bairro não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('cidade').asString = '' then
    raise Exception.Create('Cidade não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('estado').asString = '' then
   raise Exception.Create('Estado não informado. Cadastro não efetuado.');

  if DataSet.FieldByname('pais').asString = '' then
   raise Exception.Create('Pais não informado. Cadastro não efetuado.');
end;

end.
