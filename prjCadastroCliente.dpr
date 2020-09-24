program prjCadastroCliente;

uses
  Vcl.Forms,
  ufrmCadastroCliente in 'view\ufrmCadastroCliente.pas' {frmCadastroCliente},
  udmCadastroCliente in 'Dao\udmCadastroCliente.pas' {dmCadastroCliente: TDataModule},
  model.Cliente in 'model\model.Cliente.pas',
  model.Endereco in 'model\model.Endereco.pas',
  Controller.Cadastro in 'controller\Controller.Cadastro.pas',
  model.XML.Cliente in 'model\model.XML.Cliente.pas',
  model.ViaCep in 'model\model.ViaCep.pas',
  model.Email in 'model\model.Email.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  Application.CreateForm(TdmCadastroCliente, dmCadastroCliente);
  Application.Run;
end.
