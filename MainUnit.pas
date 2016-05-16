unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, AboutUnit,
  JvComponentBase, JvCreateProcess;

type
  TFormMain = class(TForm)
    MainPanel: TPanel;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    ExitMenuItem: TMenuItem;
    Separator1MenuItem: TMenuItem;
    HelpMenuItem: TMenuItem;
    AboutMenuItem: TMenuItem;
    UrlEdit: TEdit;
    UrlLabel: TLabel;
    GoButton: TButton;
    youtubedlProcess: TJvCreateProcess;

    procedure AboutMenuItemClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);

  private

  public

  end;

var
  MainForm: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.AboutMenuItemClick(Sender: TObject);

begin
  AboutUnit.AboutForm.ShowModal;
end;

procedure TFormMain.ExitMenuItemClick(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := messagedlg('Are you sure you want to exit?', mtConfirmation, mbYesNo, 0);

  if buttonSelected = mrYes then Application.MainForm.Close;
end;

procedure TFormMain.GoButtonClick(Sender: TObject);
begin
  youtubedlProcess.ApplicationName :=  GetCurrentDir + '\dep\youtube-dl.exe';
  youtubedlProcess.CommandLine := ' ' + UrlEdit.Text;
  youtubedlProcess.Run;
end;

end.
