object fmMain: TfmMain
  Left = 0
  Top = 0
  Cursor = crArrow
  Caption = 'ByTag Selector'
  ClientHeight = 561
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 400
  Constraints.MinHeight = 600
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 58
    Height = 25
    Caption = #1051#1086#1075#1080#1085
  end
  object Label2: TLabel
    Left = 8
    Top = 50
    Width = 31
    Height = 25
    Caption = #1058#1101#1075
  end
  object edUsername: TEdit
    Left = 88
    Top = 8
    Width = 288
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edTag: TEdit
    Left = 88
    Top = 47
    Width = 288
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object moURLs: TMemo
    Left = 8
    Top = 136
    Width = 368
    Height = 393
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btStart: TButton
    Left = 8
    Top = 86
    Width = 368
    Height = 44
    Caption = #1042#1054#1047#1056#1040#1041#1054#1058#1040#1049' '#1046#1045
    TabOrder = 3
    OnClick = btStartClick
  end
  object pbMain: TProgressBar
    Left = 8
    Top = 536
    Width = 368
    Height = 17
    TabOrder = 4
  end
  object alMain: TActionList
    Left = 296
    Top = 464
    object acSelectAll: TAction
      Caption = 'acSelectAll'
      ShortCut = 16449
      OnExecute = acSelectAllExecute
    end
  end
end
