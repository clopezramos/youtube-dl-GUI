object FormAbout: TFormAbout
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'About'
  ClientHeight = 150
  ClientWidth = 300
  Color = clBtnFace
  Constraints.MaxHeight = 189
  Constraints.MaxWidth = 316
  Constraints.MinHeight = 189
  Constraints.MinWidth = 316
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 95
    Top = 24
    Width = 80
    Height = 15
    Caption = 'youtube-dl GUI'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 45
    Width = 99
    Height = 13
    Caption = 'Based on youtube-dl'
  end
  object Label3: TLabel
    Left = 87
    Top = 88
    Width = 54
    Height = 13
    Caption = 'Created by'
  end
  object LabelVersion: TLabel
    Left = 161
    Top = 45
    Width = 94
    Height = 13
    Cursor = crHandPoint
    Hint = 
      'https://github.com/rg3/youtube-dl/commit/28b4f73620c82e7007b3154' +
      'e4d5f437cf6fb2608'
    Caption = 'release 2016.05.10'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = LabelVersionClick
  end
  object LabelAuthor: TLabel
    Left = 147
    Top = 88
    Width = 59
    Height = 13
    Cursor = crHandPoint
    Hint = 'https://github.com/clopezramos'
    Caption = 'clopezramos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = LabelAuthorClick
  end
  object Label4: TLabel
    Left = 181
    Top = 25
    Width = 32
    Height = 13
    Caption = 'ver1.0'
  end
  object OkButton: TButton
    Left = 113
    Top = 117
    Width = 75
    Height = 25
    Align = alCustom
    Caption = 'Ok'
    TabOrder = 0
    OnClick = OkButtonClick
  end
end
