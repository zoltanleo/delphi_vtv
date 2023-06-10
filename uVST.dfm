object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 374
  ClientWidth = 816
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    816
    374)
  TextHeight = 15
  object VST: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 800
    Height = 321
    AccessibleName = 'www'
    Anchors = [akLeft, akTop, akRight, akBottom]
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
  object mds_m: TMemTableEh
    Params = <>
    Left = 200
    Top = 48
  end
  object ActList: TActionList
    Left = 288
    Top = 48
    object ActFillMDS: TAction
      Caption = 'ActFillMDS'
      OnExecute = ActFillMDSExecute
    end
    object ActFillTreeByMDS: TAction
      Caption = 'ActFillTreeByMDS'
      OnExecute = ActFillTreeByMDSExecute
    end
    object ActFillTreeByArray: TAction
      Caption = 'ActFillTreeByArray'
      OnExecute = ActFillTreeByArrayExecute
    end
    object ActFillArray: TAction
      Caption = 'ActFillArray'
      OnExecute = ActFillArrayExecute
    end
  end
  object mds_d: TMemTableEh
    ExternalMemData = mds_m
    Params = <>
    Left = 384
    Top = 48
  end
end
