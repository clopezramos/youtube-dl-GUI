object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'youtube-dl GUI'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Constraints.MaxHeight = 459
  Constraints.MaxWidth = 616
  Constraints.MinHeight = 459
  Constraints.MinWidth = 616
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 400
    Align = alClient
    TabOrder = 0
    object UrlLabel: TLabel
      Left = 16
      Top = 21
      Width = 117
      Height = 13
      Caption = 'Place a youtube url here'
    end
    object PathLabel: TLabel
      Left = 16
      Top = 317
      Width = 22
      Height = 13
      Caption = 'Path'
    end
    object UrlEdit: TEdit
      Left = 16
      Top = 40
      Width = 482
      Height = 21
      TabOrder = 0
    end
    object GoButton: TButton
      Left = 496
      Top = 334
      Width = 75
      Height = 25
      Caption = 'Go!'
      TabOrder = 1
      OnClick = GoButtonClick
    end
    object JvFilenameEdit1: TJvFilenameEdit
      Left = 16
      Top = 336
      Width = 457
      Height = 21
      TabOrder = 2
      Text = ''
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
    Left = 552
    Top = 288
  end
end
