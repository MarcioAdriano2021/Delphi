unit ufrmCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, Controller.Cadastro;

type
  TfrmCadastroCliente = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    gbEndereco: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edLogradouro: TDBEdit;
    edNumero: TDBEdit;
    edComplemento: TDBEdit;
    edBairro: TDBEdit;
    edCidade: TDBEdit;
    gbDados: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edNome: TDBEdit;
    edIdentidade: TDBEdit;
    edCPF: TDBEdit;
    edEmail: TDBEdit;
    edTelefone: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    edEstado: TDBEdit;
    edPais: TDBEdit;
    Label13: TLabel;
    edCEP: TDBEdit;
    dsCliente: TDataSource;
    nvCadastroCliente: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure edCEPChange(Sender: TObject);
  private
    { Private declarations }
    procedure BuscarCep;
    procedure RecebeEndereco(pEndereco: TEndereco);
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

uses
  udmCadastroCliente;

procedure TfrmCadastroCliente.BuscarCep;
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      ControllerCadastro: iControllerCadastro;
    begin
      ControllerCadastro := TControllerCadastro.Create;
      ControllerCadastro.ConsultarCep(StrToInt(edCep.Text), RecebeEndereco);
    end).Start;
end;

procedure TfrmCadastroCliente.RecebeEndereco(pEndereco: TEndereco);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      dsCliente.DataSet.FieldByName('logradouro').AsString := pEndereco.Logradouro;
      dsCliente.DataSet.FieldByName('bairro').AsString := pEndereco.Bairro;
      dsCliente.DataSet.FieldByName('cidade').AsString := pEndereco.Cidade;
      dsCliente.DataSet.FieldByName('estado').AsString := pEndereco.Estado;
      dsCliente.DataSet.FieldByName('pais').AsString := 'Brasil';
      edNumero.SetFocus;
      pEndereco.DisposeOf;
    end);
end;

procedure TfrmCadastroCliente.edCEPChange(Sender: TObject);
begin
  if Length((Sender as TDBEdit).Text) = 8 then
    if dsCliente.DataSet.State in [dsEdit,dsInsert] then
      BuscarCep;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  dmCadastroCliente := TdmCadastroCliente.Create(self);
end;

end.
