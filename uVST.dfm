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
  object Label1: TLabel
    Left = 8
    Top = 312
    Width = 49
    Height = 15
    Caption = 'Label1'
  end
  object VST: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 800
    Height = 289
    AccessibleName = 'www'
    Anchors = [akLeft, akTop, akRight]
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 25
    Header.Height = 25
    Header.Options = [hoColumnResize, hoShowSortGlyphs, hoVisible, hoAutoSpring, hoFullRepaintOnResize, hoDisableAnimatedResize, hoHeaderClickAutoSort, hoAutoResizeInclCaption]
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toCenterScrollIntoView, toAlwaysSelectNode]
    OnAddToSelection = VSTAddToSelection
    OnFreeNode = VSTFreeNode
    OnGetText = VSTGetText
    OnGetNodeDataSize = VSTGetNodeDataSize
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        Color = clWindow
        Options = [coAllowClick, coEnabled, coParentBidiMode, coResizable, coVisible, coAutoSpring, coSmartResize, coAllowFocus, coEditable, coStyleColor]
        Position = 0
        Text = 'ID'
        Width = 133
      end
      item
        Position = 1
        Text = 'Parent ID'
        Width = 100
      end
      item
        Position = 2
        Text = #1050#1086#1076' '#1052#1050#1041
        Width = 100
      end
      item
        Position = 3
        Text = #1053#1072#1079#1074#1072#1085#1080#1077' '#1052#1050#1041
        Width = 500
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
    object ActFillTreeByArrayG: TAction
      Caption = 'ActFillTreeByArrayG'
      OnExecute = ActFillTreeByArrayGExecute
    end
    object ActFillArrayG: TAction
      Caption = 'ActFillArrayG'
      OnExecute = ActFillArrayGExecute
    end
    object ActFillArray: TAction
      Caption = 'ActFillArray'
      OnExecute = ActFillArrayExecute
    end
    object ActFillTreeByArray: TAction
      Caption = 'ActFillTreeByArray'
      OnExecute = ActFillTreeByArrayExecute
    end
  end
  object mds_d: TMemTableEh
    ExternalMemData = mds_m
    Params = <>
    Left = 384
    Top = 48
  end
end
