object fmSet: TfmSet
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35774#32622
  ClientHeight = 229
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 13
    Top = 8
    Width = 315
    Height = 177
  end
  object Label1: TLabel
    Left = 40
    Top = 29
    Width = 48
    Height = 13
    Caption = #36873#25321#35789#27719
  end
  object Label2: TLabel
    Left = 40
    Top = 147
    Width = 72
    Height = 13
    Caption = #33258#21160#25773#25918#38388#38548
  end
  object Label3: TLabel
    Left = 272
    Top = 147
    Width = 12
    Height = 13
    Caption = #31186
  end
  object Label4: TLabel
    Left = 76
    Top = 64
    Width = 12
    Height = 13
    Caption = #20174
  end
  object Label5: TLabel
    Left = 183
    Top = 64
    Width = 12
    Height = 13
    Caption = #21040
  end
  object Label6: TLabel
    Left = 40
    Top = 104
    Width = 48
    Height = 13
    Caption = #25773#25918#39034#24207
  end
  object cbBook: TComboBox
    Left = 94
    Top = 26
    Width = 190
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbBookChange
  end
  object cbLesson: TComboBox
    Left = 94
    Top = 61
    Width = 83
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object cbLesson2: TComboBox
    Left = 201
    Top = 61
    Width = 83
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object cbMode: TComboBox
    Left = 94
    Top = 101
    Width = 137
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      #21333#35789#21644#32763#35793#21516#26102#26174#31034
      #21333#35789#20808#20110#32763#35793#26174#31034
      #21333#35789#21518#20110#32763#35793#26174#31034)
  end
  object tbTime: TTrackBar
    Left = 118
    Top = 139
    Width = 148
    Height = 39
    Ctl3D = True
    DoubleBuffered = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentShowHint = False
    Position = 2
    ShowHint = False
    ShowSelRange = False
    TabOrder = 4
  end
  object bbOk: TBitBtn
    Left = 147
    Top = 191
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    DoubleBuffered = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = bbOkClick
  end
  object BitBtn2: TBitBtn
    Left = 238
    Top = 191
    Width = 75
    Height = 25
    Caption = #21462#28040
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 6
  end
  object chbRand: TCheckBox
    Left = 248
    Top = 103
    Width = 50
    Height = 17
    Caption = #38543#26426
    TabOrder = 7
  end
end
