unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
  MainPanel: TPanel;
  MainMenu: TMainMenu;
  FileMenu: TMenuItem;
  Exit: TMenuItem;
  Separator1: TMenuItem;
  Help: TMenuItem;
  About: TMenuItem;
  procedure AboutClick(Sender: TObject);
  procedure ExitClick(Sender: TObject);

  private

  public

  end;

var
  MainForm: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AboutClick(Sender: TObject);
begin
  ShowMessage('youtube-dl GUI ver 1.0' + #13#10 + 'Created by clopezramos');
end;

procedure TForm1.ExitClick(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := messagedlg('Are you sure you want to exit?',mtError, mbOKCancel, 0);

  if buttonSelected = mrOK then MainForm.DoHide();
end;

end.
