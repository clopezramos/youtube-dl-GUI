object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'youtube-dl GUI'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 400
    Align = alClient
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    object FileMenu: TMenuItem
      Caption = '&File'
      object Separator1: TMenuItem
        Caption = '-'
      end
      object Exit: TMenuItem
        Caption = 'E&xit'
        OnClick = ExitClick
      end
    end
    object Help: TMenuItem
      Caption = '&Help'
      object About: TMenuItem
        Caption = '&About...'
        OnClick = AboutClick
      end
    end
  end
end
