unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, JvComponentBase, JvCreateProcess, AboutUnit;

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
    PathLabel: TLabel;
    PathFilenameEdit: TJvFilenameEdit;

    { TODO 1 -oclopezramos -cimprove : Change youtubedlProcess visibility to private }
    youtubedlProcess: TJvCreateProcess;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GoButtonClick(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
  private
    outputPath: String;

    procedure StartDownloadProcess();
    procedure ReadConfigFile(Parameter: string; Output: string);
    procedure WriteConfigFile(Parameter: string; Input: string);
  public

  end;

var
  MainForm: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  ReadConfigFile('outputPath', outputPath);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteConfigFile('outputPath', PathFilenameEdit.FileName);
end;

procedure TFormMain.GoButtonClick(Sender: TObject);
begin
  StartDownloadProcess();
end;

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

procedure TFormMain.StartDownloadProcess();
begin
  youtubedlProcess.ApplicationName :=  GetCurrentDir + '\dep\youtube-dl.exe';
  youtubedlProcess.CommandLine := ' ' + UrlEdit.Text;
  youtubedlProcess.Run;
end;

procedure TFormMain.ReadConfigFile(Parameter: string; Output: string);
var
  inputFile: TextFile;
  input: string;
  temp: string;
  found: Boolean;
begin
  found := false;
  AssignFile(inputFile, GetCurrentDir + '\config');
  Reset(inputFile);
  while not Eof(inputFile) and not found do
  begin
    input := '';
    temp := '';
    ReadLn(inputFile, input);
    temp := Copy(input, 1, Pos(' ', input) - 1);
    if temp = Parameter then
      begin
        input := Copy(input, Pos(' ', input) + 1, Length(input) - Length(temp) + 1);
        Output := input;
        found := true;
      end;
  end;
end;

procedure TFormMain.WriteConfigFile(Parameter: string; Input: string);
begin

end;

end.
