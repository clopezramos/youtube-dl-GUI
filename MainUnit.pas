unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, AboutUnit;

type
  TFormMain = class(TForm)
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
  MainForm: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.AboutClick(Sender: TObject);

begin
  AboutUnit.AboutForm.ShowModal;
end;

procedure TFormMain.ExitClick(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := messagedlg('Are you sure you want to exit?', mtConfirmation, mbYesNo, 0);

  if buttonSelected = mrYes then Application.MainForm.Close;
end;

end.
