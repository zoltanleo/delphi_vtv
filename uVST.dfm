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
    Width = 34
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Label1'
  end
  object VST: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 800
    Height = 289
    AccessibleName = 'www'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 25
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -12
    Header.Font.Name = 'Segoe UI'
    Header.Font.Style = []
    Header.Height = 25
    Header.Options = [hoAutoResize, hoColumnResize, hoOwnerDraw, hoShowHint, hoShowSortGlyphs, hoVisible, hoAutoSpring, hoFullRepaintOnResize, hoDisableAnimatedResize, hoHeaderClickAutoSort, hoAutoColumnPopupMenu, hoAutoResizeInclCaption]
    Header.ParentFont = False
    HintMode = hmTooltip
    ParentShowHint = False
    ShowHint = True
    StyleName = 'Windows'
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toShowFilteredNodes]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toCenterScrollIntoView, toAlwaysSelectNode]
    OnAddToSelection = VSTAddToSelection
    OnAdvancedHeaderDraw = VSTAdvancedHeaderDraw
    OnCompareNodes = VSTCompareNodes
    OnFreeNode = VSTFreeNode
    OnGetText = VSTGetText
    OnGetNodeDataSize = VSTGetNodeDataSize
    OnHeaderClick = VSTHeaderClick
    OnHeaderDrawQueryElements = VSTHeaderDrawQueryElements
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coSmartResize, coAllowFocus, coWrapCaption, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 0
        Text = 'ID'
        Width = 143
      end
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 1
        Text = 'Parent ID'
        Width = 100
      end
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable, coStyleColor]
        Position = 2
        Text = #1050#1086#1076' '#1052#1050#1041
        Width = 100
      end
      item
        CaptionAlignment = taCenter
        Color = clWindow
        Options = [coAllowClick, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAutoSpring, coSmartResize, coAllowFocus, coWrapCaption, coUseCaptionAlignment, coEditable]
        Position = 3
        Text = #1053#1072#1079#1074#1072#1085#1080#1077' '#1052#1050#1041
        Width = 453
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
  object VTHeaderPopupMenu1: TVTHeaderPopupMenu
    Left = 488
    Top = 128
    object rewtre1: TMenuItem
      Action = ActFillTreeByArray
    end
    object jjjjjjj1: TMenuItem
      Action = ActFillArray
    end
    object eeeee1: TMenuItem
      Caption = 'eeeee'
    end
  end
end
