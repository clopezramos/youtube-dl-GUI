unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls,
  JvComponentBase, JvCreateProcess, JvExMask, JvToolEdit, AboutUnit;

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
    PathJvDirectoryEdit: TJvDirectoryEdit;
    OutputBox: TListBox;
    ProgressBar: TProgressBar;

    { TODO 1 -oclopezramos -cimprove : Change youtubedlProcess visibility to private }
    youtubedlProcess: TJvCreateProcess;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GoButtonClick(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure youtubedlProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure youtubedlProcessTerminate(Sender: TObject; ExitCode: Cardinal);
  private
    outputPath: String;

    procedure startDownloadProcess;
    procedure readConfigFile(Parameter: string; var Output: string);
    procedure writeConfigFile(Parameter: string; Input: string);
    procedure addLog(const Text: string);
    procedure clearLogs;
    procedure getPercentageLog(Text: string; var Result: Boolean);
  public

  end;

var
  MainForm: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  readConfigFile('outputPath', outputPath);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  PathJvDirectoryEdit.SetSelText(outputPath);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  writeConfigFile('outputPath', PathJvDirectoryEdit.Text);
end;

procedure TFormMain.GoButtonClick(Sender: TObject);
begin
  clearLogs;
  startDownloadProcess;
  ProgressBar.Position := 0;
  GoButton.Enabled:= false;
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

procedure TFormMain.youtubedlProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
begin
  if S = #$C then
    clearLogs
  else if not S.IsEmpty then
    addLog(S)
end;

procedure TFormMain.youtubedlProcessTerminate(Sender: TObject;
  ExitCode: Cardinal);
begin
  GoButton.Enabled:= true;
end;

{ Private procedures }

procedure TFormMain.startDownloadProcess;
var
  commands: string;
begin
  commands := ' ' + '-o "' + PathJvDirectoryEdit.Text + '\%(title)s.%(ext)s' + '" ' + UrlEdit.Text;
  youtubedlProcess.CommandLine := commands;
  youtubedlProcess.ApplicationName :=  GetCurrentDir + '\dep\youtube-dl.exe';
  youtubedlProcess.ConsoleOptions := youtubedlProcess.ConsoleOptions + [coRedirect];
  youtubedlProcess.StartupInfo.ShowWindow := swHide;
  youtubedlProcess.StartupInfo.DefaultWindowState := False;
  youtubedlProcess.Run;
end;

procedure TFormMain.readConfigFile(Parameter: string; var Output: string);
var
  configFile: TextFile;
  line: string;
  word: string;
  found: Boolean;
begin
  found := false;
  AssignFile(configFile, GetCurrentDir + '\config');
  Reset(configFile);
  while not Eof(configFile) and not found do
  begin
    line := '';
    word := '';
    ReadLn(configFile, line);
    word := Copy(line, 1, Pos(' ', line) - 1);
    if word = Parameter then
    begin
      line := Copy(line, Pos(' ', line) + 1, Length(line) - Length(word) + 1);
      Output := line;
      found := true;
    end;
  end;
  CloseFile(configFile);
end;

procedure TFormMain.writeConfigFile(Parameter: string; Input: string);
var
  configFile: TextFile;
  line: string;
  word: string;
  found: Boolean;
  result: string;
begin
  found := false;
  result := '';
  AssignFile(configFile, GetCurrentDir + '\config');

  // try to find any previous config
  Reset(configFile);
  while not Eof(configFile) do
  begin
    line := '';
    word := '';
    ReadLn(configFile, line);
    word := Copy(line, 1, Pos(' ', line) - 1);
    if word = Parameter then
    begin
      line := Parameter + ' ' + Input;
      found := true;
    end;
    result := result + line + #13#10;
  end;

  // check if it wasn't found
  if not found then result := result + Parameter + ' ' + Input +  #13#10;

  // rewrite config file
  Rewrite(configFile);
  Write(configFile, result);
  CloseFile(configFile);
end;

procedure TFormMain.addLog(const Text: string);
begin
  OutputBox.AddItem(FormatDateTime('HH:NN:SS  ', Now) + Text, nil);
  OutputBox.ItemIndex := OutputBox.Items.Count - 1;
end;

procedure TFormMain.clearLogs;
begin
  OutputBox.Clear;
end;

{
procedure TFormMain.getPercentageLog(Text: string; var Result: Boolean);
var
  word: string;
  position: integer;
begin
  word := Copy(Text, 1, Pos(' ', Text) - 1);
  if word = '[download]' then
  begin
    Text := Copy(Text, Pos(' ', Text) + 1, Length(Text) - Length(word) + 1);
    word := Copy(Text, 1, Pos(' ', Text) - 1);
    integer:= Pos('%', Text);
    if integer = 2 or integer = 3 then

    word := Copy(word, 1, Pos('%', Text) - 1);

    Result:= true;
  end;
  Result:= false;
end;
}
end.
