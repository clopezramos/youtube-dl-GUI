unit CustomTextEditUnit;

interface

uses
  ClipBrd, Windows, Messages, SysUtils, Classes, Controls, StdCtrls;

type
  TStringEvent = procedure(Sender: TObject; var s: String) of object;
  TCustomEdit = class(TEdit)
  private
    FOnBeforePaste: TStringEvent;
    FOnAfterPaste: TNotifyEvent;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
  protected
  public
  published
    property OnBeforePaste: TStringEvent read FOnBeforePaste write FOnBeforePaste;
    property OnAfterPaste: TNotifyEvent read FOnAfterPaste write FOnAfterPaste;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('.....', [TCustomEdit]);
end;

{ TCustomEdit }

procedure TCustomEdit.WMPaste(var Message: TMessage);
var
  strClpText: String;
begin
  // Check if the OnBeforePaste event is assigned and check if the clipboard contains plain text.
  if Assigned(FOnBeforePaste) and Clipboard.HasFormat(CF_TEXT) then
  begin
    // Save the clipboard text into a local variable
    strClpText := ClipBoard.AsText;
    // Fire the OnBeforePaste event
    FOnBeforePaste(self, strClpText);

    // Clear the clipboard and replace it with the new text
    Clipboard.Clear;
    Clipboard.AsText := strClpText;
  end;

  // Perform the actual paste
  inherited;

  // if the OnAfterPaste event is assigned, fire it.
  if Assigned(FOnAfterPaste) then
    FOnAfterPaste(self);
end;

end.
