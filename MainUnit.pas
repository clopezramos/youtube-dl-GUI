unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.Mask,
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

    { TODO 1 -oclopezramos -cimprove : Change youtubedlProcess visibility to private }
    youtubedlProcess: TJvCreateProcess;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GoButtonClick(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    outputPath: String;

    procedure StartDownloadProcess();
    procedure ReadConfigFile(Parameter: string; var Output: string);
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

procedure TFormMain.FormShow(Sender: TObject);
begin
  PathJvDirectoryEdit.SetSelText(outputPath);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteConfigFile('outputPath', PathJvDirectoryEdit.Text);
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

procedure TFormMain.ReadConfigFile(Parameter: string; var Output: string);
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

procedure TFormMain.WriteConfigFile(Parameter: string; Input: string);
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

end.
