object FormAbout: TFormAbout
  Left = 0
  Top = 0
  Caption = 'About'
  ClientHeight = 150
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 119
    Top = 8
    Width = 111
    Height = 13
    Caption = 'youtube-dl GUI ver 1.0'
  end
  object Label2: TLabel
    Left = -185
    Top = 40
    Width = 720
    Height = 13
    Caption = 
      'Based on youtube-dl release <a href="https://github.com/rg3/yout' +
      'ube-dl/commit/28b4f73620c82e7007b3154e4d5f437cf6fb2608">2016.05.' +
      '10</a>'
  end
  object Label3: TLabel
    Left = 117
    Top = 72
    Width = 116
    Height = 13
    Caption = 'Created by clopezramos'
  end
  object OkButton: TButton
    Left = 142
    Top = 117
    Width = 75
    Height = 25
    Align = alCustom
    Caption = 'Ok'
    TabOrder = 0
    OnClick = OkButtonClick
  end
end
