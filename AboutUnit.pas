unit AboutUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi;

type
  TFormAbout = class(TForm)
    OkButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelVersion: TLabel;
    LabelAuthor: TLabel;
    Label4: TLabel;
    procedure OkButtonClick(Sender: TObject);
    procedure LabelVersionClick(Sender: TObject);
    procedure LabelAuthorClick(Sender: TObject);

  private
  public

  end;

var
  AboutForm: TFormAbout;

implementation

{$R *.dfm}

procedure TFormAbout.LabelAuthorClick(Sender: TObject);
begin
  ShellExecute(0, 'Open', PChar(LabelAuthor.Hint), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormAbout.LabelVersionClick(Sender: TObject);
begin
  ShellExecute(0, 'Open', PChar(LabelVersion.Hint), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormAbout.OkButtonClick(Sender: TObject);
begin
  AboutForm.Close;
end;

end.
