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
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    628
    405)
  TextHeight = 15
  object VST: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 612
    Height = 329
    AccessibleName = 'www'
    Anchors = [akLeft, akTop, akRight]
    Header.AutoSizeIndex = 0
    TabOrder = 0
    OnFreeNode = VSTFreeNode
    OnGetText = VSTGetText
    OnGetNodeDataSize = VSTGetNodeDataSize
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        Position = 0
        Text = 'www'
        Width = 608
      end>
  end
  object mds: TMemTableEh
    Params = <>
    Left = 360
    Top = 48
  end
  object ActList: TActionList
    Left = 288
    Top = 48
    object ActFillMDS: TAction
      Caption = 'ActFillMDS'
      OnExecute = ActFillMDSExecute
    end
    object ActFillTree: TAction
      Caption = 'ActFillTree'
      OnExecute = ActFillTreeExecute
    end
  end
end
