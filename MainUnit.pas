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
    YoutubedlProcess: TJvCreateProcess;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GoButtonClick(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure YoutubedlProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure YoutubedlProcessTerminate(Sender: TObject; ExitCode: Cardinal);
  private
    outputPath: String;

    procedure startDownloadProcess;
    procedure readConfigFile(Parameter: string; var Output: string);
    procedure writeConfigFile(Parameter: string; Input: string);
    procedure addLog(const Text: string);
    procedure clearLogs;
    function getPercentageLog(Text: string; var percentage: string) : Boolean;
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

procedure TFormMain.YoutubedlProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
var
  percentage: string;
begin
  if S = #$C then
    clearLogs
  else if not S.IsEmpty then
  begin
    percentage := '';
    if getPercentageLog(S, percentage) then
      ProgressBar.Position:= strtoint(percentage)
    else addLog(S)
  end;
end;

procedure TFormMain.YoutubedlProcessTerminate(Sender: TObject;
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
  YoutubedlProcess.CommandLine := commands;
  YoutubedlProcess.ApplicationName :=  GetCurrentDir + '\dep\youtube-dl.exe';
  YoutubedlProcess.ConsoleOptions := YoutubedlProcess.ConsoleOptions + [coRedirect];
  YoutubedlProcess.StartupInfo.ShowWindow := swHide;
  YoutubedlProcess.StartupInfo.DefaultWindowState := False;
  YoutubedlProcess.Run;
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

function TFormMain.getPercentageLog(Text: string; var percentage: string) : boolean;
var
  StringList: TStringList;
  position: Integer;
begin
  Result := False;
  StringList := TStringList.Create();
  StringList.Text := StringReplace(Text, ' ', #13#10, [rfReplaceAll]);

  // search keyword
  if ansicomparestr('[download]', StringList[0]) = 0 then
  begin
    // erase empty elements
    for position := StringList.count - 1 downto 0 do
    begin
    if Trim(StringList[position]) = '' then
      StringList.Delete(position);
    end;
    // get string with the integer value
    if StringList[1].Length < 7 then
    begin
      if Pos('.', StringList[1]) > 0 then
      begin
        position := Pos('%', StringList[1]);
        if position = StringList[1].Length then
        begin
          percentage := Copy(StringList[1], 1, Pos('.', StringList[1]) - 1);
          Result := True;
        end;
      end;
    end;
  end;
  StringList.Free();
end;

end.
