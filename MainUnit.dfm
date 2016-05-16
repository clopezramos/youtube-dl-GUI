object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'youtube-dl GUI'
  ClientHeight = 400
  ClientWidth = 520
  Color = clBtnFace
  Constraints.MaxHeight = 459
  Constraints.MaxWidth = 536
  Constraints.MinHeight = 459
  Constraints.MinWidth = 536
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 400
    Align = alClient
    TabOrder = 0
    object UrlLabel: TLabel
      Left = 19
      Top = 21
      Width = 117
      Height = 13
      Caption = 'Place a youtube url here'
    end
    object PathLabel: TLabel
      Left = 19
      Top = 67
      Width = 22
      Height = 13
      Caption = 'Path'
    end
    object UrlEdit: TEdit
      Left = 19
      Top = 40
      Width = 482
      Height = 21
      TabOrder = 0
    end
    object GoButton: TButton
      Left = 426
      Top = 359
      Width = 75
      Height = 25
      Caption = 'Go!'
      TabOrder = 1
      OnClick = GoButtonClick
    end
    object PathJvDirectoryEdit: TJvDirectoryEdit
      Left = 19
      Top = 86
      Width = 482
      Height = 21
      DialogKind = dkWin32
      TabOrder = 2
      Text = ''
    end
    object OutputBox: TListBox
      Left = 19
      Top = 248
      Width = 482
      Height = 96
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 11
      ParentFont = False
      TabOrder = 3
    end
    object ProgressBar: TProgressBar
      Left = 19
      Top = 359
      Width = 386
      Height = 25
      TabOrder = 4
    end
  end
  object MainMenu: TMainMenu
    object FileMenu: TMenuItem
      Caption = '&File'
      object Separator1MenuItem: TMenuItem
        Caption = '-'
      end
      object ExitMenuItem: TMenuItem
        Caption = 'E&xit'
        OnClick = ExitMenuItemClick
      end
    end
    object HelpMenuItem: TMenuItem
      Caption = '&Help'
      object AboutMenuItem: TMenuItem
        Caption = '&About...'
        OnClick = AboutMenuItemClick
      end
    end
  end
  object youtubedlProcess: TJvCreateProcess
    OnTerminate = youtubedlProcessTerminate
    OnRead = youtubedlProcessRead
    Left = 472
    Top = 304
  end
end
