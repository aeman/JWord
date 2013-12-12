object fmMain: TfmMain
  Left = 650
  Top = 0
  BorderStyle = bsNone
  Caption = 'fmMain'
  ClientHeight = 75
  ClientWidth = 287
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = pmMain
  Position = poDesigned
  ScreenSnap = True
  ShowHint = True
  SnapBuffer = 30
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblJapan: TLabel
    Left = 25
    Top = 8
    Width = 5
    Height = 19
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnMouseDown = FormMouseDown
  end
  object lblChina: TLabel
    Left = 25
    Top = 45
    Width = 5
    Height = 19
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnMouseDown = FormMouseDown
  end
  object sbPlay: TSpeedButton
    Left = 246
    Top = 24
    Width = 33
    Height = 33
    Hint = #33258#21160#25773#25918
    Flat = True
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777770000007777777777777777770000007777777777777777770000007777
      0777777700777700000077770077777700777700000077770007777700777700
      0000777700007777007777000000777700000777007777000000777700000077
      0077770000007777000000770077770000007777000007770077770000007777
      0000777700777700000077770007777700777700000077770077777700777700
      0000777707777777007777000000777777777777777777000000777777777777
      777777000000777777777777777777000000}
    ParentShowHint = False
    ShowHint = False
    OnClick = sbPlayClick
  end
  object tmWord: TTimer
    Enabled = False
    OnTimer = tmWordTimer
    Left = 56
    Top = 24
  end
  object pmMain: TPopupMenu
    AutoHotkeys = maManual
    Left = 24
    Top = 24
    object miTest: TMenuItem
      Caption = #27979#35797
      OnClick = miTestClick
    end
    object miSet: TMenuItem
      Caption = #35774#32622
      OnClick = miSetClick
    end
    object miAbout: TMenuItem
      Caption = #20851#20110'...'
      OnClick = miAboutClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miClose: TMenuItem
      Caption = #36864#20986
      OnClick = miCloseClick
    end
  end
end
