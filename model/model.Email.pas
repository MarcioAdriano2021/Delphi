unit model.Email;

interface

uses
  IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase, System.SysUtils, Dialogs;

Type

  IEmail = interface
    ['{0BF82C8F-B6A9-4FEB-94A8-8A60970B0083}']
    function setHost(pAuth: TIdSMTPAuthenticationType; pPort: integer;
      pHost, pUserName, pPassword: string): IEmail;
    function setMessage(pFromEmail, pFromName, pRecipientes,
      pSubject: string): IEmail;
    function send(pBody, pFile: string): IEmail;
  end;

  TEMail = class(TInterfacedObject, IEmail)
  private
    FIdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    FIdSMTP: TIdSMTP;
    FIdMessage: TIdMessage;
    FIdText: TIdText;
    FAnexo: string;
  public
    constructor Create;
    destructor Destroy; override;
    function setHost(pAuth: TIdSMTPAuthenticationType; pPort: integer;
      pHost, pUserName, pPassword: string): IEmail;
    function setMessage(pFromEmail, pFromName, pRecipientes,
      pSubject: string): IEmail;
    function send(pBody, pFile: string): IEmail;
  end;

implementation

{ TEMail }

constructor TEMail.Create;
begin
  FIdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  FIdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
  FIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;
  FIdSMTP.IOHandler := FIdSSLIOHandlerSocket;
  FIdSMTP.UseTLS := utUseImplicitTLS;
end;

destructor TEMail.Destroy;
begin
  FreeAndNil(FIdSSLIOHandlerSocket);
  FIdSMTP.DisposeOf;
  FIdMessage.DisposeOf;
  inherited;
end;

function TEMail.send(pBody, pFile: string): IEmail;
begin
  Result := Self;
  FIdText := TIdText.Create(FIdMessage.MessageParts);
  Try
    FIdText.Body.Add(pBody);
    FIdText.ContentType := 'text/plain; charset=iso-8859-1';
    FAnexo := pFile;
    if FileExists(FAnexo) then
    begin
      TIdAttachmentFile.Create(FIdMessage.MessageParts, FAnexo);
    end;

    try
      FIdSMTP.Connect;
      FIdSMTP.Authenticate;
    except
      on E: Exception do
      begin
        Showmessage('Erro na conexão ou autenticação: ' + E.Message);
        Exit;
      end;
    end;

    try
      FIdSMTP.send(FIdMessage);
      Showmessage('Mensagem enviada com sucesso!');
    except
      On E: Exception do
      begin
        Showmessage('Erro ao enviar a mensagem: ' + E.Message);
      end;
    end;
  finally
    FIdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
  end;

end;

function TEMail.setHost(pAuth: TIdSMTPAuthenticationType; pPort: integer;
  pHost, pUserName, pPassword: string): IEmail;
begin
  Result := Self;
  FIdSMTP.AuthType := pAuth;
  FIdSSLIOHandlerSocket.Port:=pPort;
  FIdSMTP.Port := pPort;
  FIdSMTP.Host := pHost;
  FIdSMTP.Username := pUserName;
  FIdSMTP.Password := pPassword;
end;

function TEMail.setMessage(pFromEmail, pFromName, pRecipientes,
  pSubject: string): IEmail;
begin
  Result:=Self;
  FIdMessage.From.Address := pFromEmail;
  FIdMessage.From.Name := pFromName;
  FIdMessage.ReplyTo.EMailAddresses := FIdMessage.From.Address;
  FIdMessage.Recipients.Add.Text := pRecipientes;
  FIdMessage.Subject := pSubject;
  FIdMessage.Encoding := meMIME;
end;

end.
