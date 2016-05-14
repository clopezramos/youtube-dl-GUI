program GUI;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, MainForm);
  Application.CreateForm(TFormAbout, AboutForm);
  Application.Run;
end.
