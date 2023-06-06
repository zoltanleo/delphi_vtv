object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 405
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object VST: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 612
    Height = 329
    Header.AutoSizeIndex = 0
    Header.MainColumn = -1
    TabOrder = 0
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <>
  end
  object mds: TMemTableEh
    Params = <>
    Left = 360
    Top = 48
  end
end
