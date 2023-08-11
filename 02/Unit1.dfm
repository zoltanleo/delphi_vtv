object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 333
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object vst: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 436
    Height = 317
    Header.AutoSizeIndex = 0
    TabOrder = 0
    OnFreeNode = vstFreeNode
    OnGetText = vstGetText
    OnGetNodeDataSize = vstGetNodeDataSize
    OnInitNode = vstInitNode
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        Position = 0
        Width = 432
      end>
  end
end
