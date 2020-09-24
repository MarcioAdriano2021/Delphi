unit model.XML.Cliente;

interface

uses
  XML.xmldom, XML.XMLIntf, XML.XMLDoc, model.Cliente, System.sysUtils,
  System.Rtti, model.Endereco, System.Classes;

Type
  IXMLCliente = interface
    ['{F9BA264F-4E6A-4CC0-99FC-3293DEBA0442}']
    procedure generateXML;
  end;

  TXmlCliente = class(TInterfacedObject, IXMLCliente)
  private
    FCliente: TCliente;
    function RemoveChar(AFieldName: String): String;
    procedure getObjectValue(aObject: TObject; out pStringList: TStringList);
  public
    constructor create(pCliente: TCliente);
    procedure generateXML;
  end;

implementation

uses
  Dialogs;

{ TXmlCliente }

constructor TXmlCliente.Create(pCliente: TCliente);
begin
  FCliente := pCliente;
end;

procedure TXmlCliente.generateXML;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
  LXMLDocument: TXMLDocument;
  LStrList:TStringList;
  LStr:string;
begin
  LStrList:=TStringList.Create;
  LCtx := TRttiContext.create;
  LType := LCtx.GetType(FCliente.ClassInfo);
  LXMLDocument := TXMLDocument.create(nil);
  try
    LXMLDocument.XML.Add('<CLIENTE>');
    for LField in LType.GetFields do
    begin
      if LField.GetValue(FCliente).IsObject then
      begin
       LXMLDocument.XML.Add('<' + RemoveChar(LField.Name) + '>');
       getObjectValue(LField.GetValue(FCliente).AsObject,LStrList);
       for LStr in LStrList do
       begin
        LXmlDocument.XML.Add(LStr);
       end;
       LXMLDocument.XML.Add('</' +RemoveChar(LField.Name) + '>');
      end
      else
        LXMLDocument.XML.Add('<' + RemoveChar(LField.Name) + '>' +
          LField.GetValue(FCliente).ToString + '</' + RemoveChar(LField.Name) + '>');
    end;
    LXMLDocument.XML.Add('</CLIENTE>');
    LXMLDocument.Active := true;
    LXMLDocument.SaveToFile('Cliente.xml');
  finally
    LStrList.DisposeOf;
    LCtx.Free;
    LXMLDocument.DisposeOf;
  end;
end;

procedure TXmlCliente.getObjectValue(aObject: TObject;
  out pStringList: TStringList);
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
begin
  LCtx := TRttiContext.create;
  LType := LCtx.GetType(aObject.ClassInfo);
  try
    for LField in LType.GetFields do
    begin
      pStringList.Add('<' + RemoveChar(LField.Name) + '>' +
        LField.GetValue(aObject).ToString + '</' + RemoveChar(LField.Name) + '>');
    end;
  finally
    LCtx.Free;
  end;
end;

function TXmlCliente.RemoveChar(AFieldName: String): String;
begin
  Result := StringReplace(AFieldName,'F','',[]);
end;

end.
