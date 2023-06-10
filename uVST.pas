unit uVST;

interface

uses
  Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.StrUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , MemTableDataEh
  , Data.DB
  , MemTableEh
  , VirtualTrees
  , System.Actions
  , Vcl.ActnList
  , System.Generics.Collections
  , DBGridEhGrouping
  , ToolCtrlsEh
  , DBGridEhToolCtrls
  , DynVarsEh
  , EhLibVCL
  , GridsEh
  , DBAxisGridsEh
  , DBGridEh
  ;

type

  PTreeData = ^TTreeData;

  TTreeData= packed record
    ID: Integer;
    ParentID: Integer;
    Mkb_code: string;
    Mkb_caption: string;
  end;

  TForm1 = class(TForm)
    VST: TVirtualStringTree;
    mds_m: TMemTableEh;
    ActList: TActionList;
    ActFillMDS: TAction;
    ActFillTreeByMDS: TAction;
    ActFillTreeByArray: TAction;
    mds_d: TMemTableEh;
    ActFillArray: TAction;
    procedure ActFillMDSExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure ActFillTreeByMDSExecute(Sender: TObject);
    procedure ActFillArrayExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActFillTreeByArrayExecute(Sender: TObject);
  private
    FValuesList: TList<TTreeData>;
    { Private declarations }
  public
    { Public declarations }
    property ValuesList: TList<TTreeData> read FValuesList;
  end;

const
  DataFile = 'c:\proj\test_delphi\delphi_vtv\base\mkb10.txt';
  ExcludeStr1 = 'INSERT INTO';
  ExcludeStr2 = 'REINSERT';
  a = '(''';
  b = ' ';
  c = ''', ';
  d = ', ';
  e = ');';
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ActFillArrayExecute(Sender: TObject);
var
  SL: TStringList;
  i: Integer;
  s, ss: string;
  k,m: Integer;
  MyRec: TTreeData;
begin
  SL:= TStringList.Create;
  try
    SL.LoadFromFile(DataFile,TEncoding.UTF8);

    for i := 0 to Pred(SL.Count) do
    begin
      if (Pos(ExcludeStr1,SL.Strings[i]) = 0) then
        if (Pos(ExcludeStr2,SL.Strings[i]) = 0) then Continue;

      k:= PosEx(a,SL.Strings[i]) + System.Length(a);
      m:= PosEx(b,SL.Strings[i],k);
      MyRec.Mkb_code := Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(b);
      m:= PosEx(c,SL.Strings[i],k);
      MyRec.Mkb_caption:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(c);
      m:= PosEx(d,SL.Strings[i],k);
      MyRec.ParentID:= StrToInt(Copy(SL.Strings[i],k,m-k));

      k:= m + System.Length(d);
      m:= PosEx(e,SL.Strings[i],k);
      MyRec.ID:= StrToInt(Copy(SL.Strings[i],k,m-k));

      FValuesList.Add(MyRec);
    end;

    FValuesList.TrimExcess;
  finally
    SL.Free;
  end;
end;

procedure TForm1.ActFillMDSExecute(Sender: TObject);
const
  a = '(''';
  b = ' ';
  c = ''', ';
  d = ', ';
  e = ');';
var
  SL: TStringList;
  i: Integer;
  s, ss: string;
  k,m: Integer;
begin
  SL:= TStringList.Create;
  try
    SL.LoadFromFile(DataFile,TEncoding.UTF8);

    if mds_m.Active
      then mds_m.EmptyTable
      else mds_m.Active:= True;

    mds_m.DisableControls;

    for i := 0 to Pred(SL.Count) do
    begin
      if (Pos(ExcludeStr1,SL.Strings[i]) = 0) then
        if (Pos(ExcludeStr2,SL.Strings[i]) = 0) then Continue;

      mds_m.Append;

      k:= PosEx(a,SL.Strings[i]) + System.Length(a);
      m:= PosEx(b,SL.Strings[i],k);
      mds_m.FieldByName('MKB_CODE').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(b);
      m:= PosEx(c,SL.Strings[i],k);
      mds_m.FieldByName('MKB_CAPTION').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(c);
      m:= PosEx(d,SL.Strings[i],k);
      mds_m.FieldByName('TREE_ID').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(d);
      m:= PosEx(e,SL.Strings[i],k);
      mds_m.FieldByName('VALUES_UID').AsString:= Copy(SL.Strings[i],k,m-k);
    end;

//    if not mds_m.IsEmpty then mds_m.Post;
    if not (mds_m.State in [dsBrowse]) then mds_m.Post;

  finally
    mds_m.EnableControls;
    FreeAndNil(SL);
  end;
end;

procedure TForm1.ActFillTreeByArrayExecute(Sender: TObject);
  procedure AddNodes(ANode: PVirtualNode; aID: Integer);
  var
    Node: PVirtualNode;
    Data: PTreeData;
    i: Integer;
    tmpList: TList<TTreeData>;
    tmpRec: TTreeData;
  begin
    //иницилизируем переменные
    Data:= nil;
    Node:= nil;

    tmpList:= TList<TTreeData>.Create;
    try
      tmpList.Clear;
      for i := 0 to Pred(ValuesList.Count) do
        if ((ValuesList[i].ParentID = aID) and (ValuesList[i].ID <> 0)) then tmpList.Add(ValuesList[i]);

      tmpList.TrimExcess;

      if (tmpList.Count = 0) then Exit;

      for i := 0 to Pred(tmpList.Count) do
      begin
        Node:= VST.AddChild(ANode);
        Data:= VST.GetNodeData(Node);
        Data^.ID:= tmpList[i].ID;
        Data^.ParentID:= tmpList[i].ParentID;
        Data^.Mkb_code:= tmpList[i].Mkb_code;
        Data^.Mkb_caption:= tmpList[i].Mkb_caption;

        AddNodes(Node,tmpList[i].ID);
      end;
    finally
      tmpList.Free;
    end;
  end;
begin

  try
    VST.BeginUpdate;
    AddNodes(nil,0);
  finally
    VST.EndUpdate;
  end;
end;

procedure TForm1.ActFillTreeByMDSExecute(Sender: TObject);
var
  IntArr: array of Integer;
  I: Integer;
  Node: PVirtualNode;
  Data: PTreeData;
  DataRec: TTreeData;

  procedure AddNodes(aID: Integer; ANode: PVirtualNode);
  var
    Node: PVirtualNode;
    Data: PTreeData;
    DataRec: TTreeData;
    IntArr: array of Integer;
    i: Integer;
  begin
    mds_d.Filtered:= False;
    mds_d.Filter:= 'TREE_ID=' + IntToStr(aID);
    mds_d.Filtered:= True;

    if (mds_d.RecordCount = 0) then Exit;
    SetLength(IntArr,mds_d.RecordCount);

    i:= 0;
    while not mds_d.Eof do
    begin
      IntArr[i]:= mds_d.FieldByName('VALUES_UID').AsInteger;
      Inc(i);
      mds_d.Next;
    end;

    for i := Low(IntArr) to High(IntArr) do
    begin
      if (i > 2) then Break;
      mds_m.First;
      if not mds_m.Locate('VALUES_UID',IntArr[i],[]) then Continue;


      Node:= VST.AddChild(ANode);
      Data:= VST.GetNodeData(Node);
      Data.ID:= mds_m.FieldByName('VALUES_UID').AsInteger;
      Data.ParentID:= mds_m.FieldByName('TREE_ID').AsInteger;
      Data.Mkb_code:= mds_m.FieldByName('MKB_CODE').AsString;
      Data.Mkb_caption:= mds_m.FieldByName('MKB_CAPTION').AsString;

      mds_d.Filtered:= False;
      mds_d.Filter:= 'TREE_ID=' + IntToStr(Data.ID);
      mds_d.Filtered:= True;

      if (mds_d.RecordCount > 0) then AddNodes(Data.ID, Node);
    end;
  end;
begin
  Exit;
  VST.BeginUpdate;
  try
    VST.Clear;

    mds_d.Filtered:= False;
    mds_d.Filter:= 'TREE_ID=0';
    mds_d.Filtered:= True;

    if (mds_d.RecordCount = 0) then Exit;
    SetLength(IntArr,mds_d.RecordCount);

    i:= 0;
    mds_d.First;
    while not mds_d.Eof do
    begin
      IntArr[i]:= mds_d.FieldByName('VALUES_UID').AsInteger;
      Inc(i);
      mds_d.Next;
    end;

    for I := Low(IntArr) to High(IntArr) do
    begin
//      if (i>0) then Break;
      
      mds_m.First;
      if not mds_m.Locate('VALUES_UID',IntArr[i],[]) then Continue;
      Node:= VST.AddChild(nil);
      Data:= VST.GetNodeData(Node);
      Data.ID:= mds_m.FieldByName('VALUES_UID').AsInteger;
      Data.ParentID:= mds_m.FieldByName('TREE_ID').AsInteger;
      Data.Mkb_code:= mds_m.FieldByName('MKB_CODE').AsString;
      Data.Mkb_caption:= mds_m.FieldByName('MKB_CAPTION').AsString;

      mds_d.Filtered:= False;
      mds_d.Filter:= 'TREE_ID=' + IntToStr(Data.ID);
      mds_d.Filtered:= True;

      if (mds_d.RecordCount > 0) then AddNodes(Data.ID, Node);
    end;

  finally
    VST.EndUpdate;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FValuesList:= TList<TTreeData>.Create;
  FValuesList.Clear;

  with mds_m do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
  end;

  with mds_d do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
  end;

  with VST do
  begin
    TreeOptions.AutoOptions:= TreeOptions.AutoOptions
                              + [toAutoDropExpand, toAutoExpand,
                                  toAutoScrollOnExpand, toAutoSort,
                                  toAutoTristateTracking, toAutoDeleteMovedNodes,
                                  toAutoChangeScale];


    Header.AutoSizeIndex:= 2;
    Header.Options:= Header.Options
                      + [hoAutoResize, hoColumnResize, {hoOwnerDraw,} hoShowHint, hoShowSortGlyphs, hoVisible]
                      - [hoDrag];
    Header.Columns.Clear;

    Header.Columns.Add;
    i:= 0;

    with Header.Columns.Items[0] do
    begin
      CheckType:= ctNone;
      MinWidth:= 50;
      Width:= 200;
      CaptionAlignment:= taCenter;
      Text:= 'ID';
    end;

    Header.Columns.Add;
    Inc(i);

    with Header.Columns.Items[1] do
    begin
      CheckType:= ctNone;
      MinWidth:= 50;
      MaxWidth:= 100;
      CaptionAlignment:= taCenter;
      Text:= 'Parent ID';
    end;

    Header.Columns.Add;
    Inc(i);

    with Header.Columns.Items[2] do
    begin
      CheckType:= ctNone;
      MinWidth:= 50;
      MaxWidth:= 100;
      CaptionAlignment:= taCenter;
      Text:= 'Код МКБ';
    end;

    Header.Columns.Add;
    Inc(i);

    with Header.Columns.Items[3] do
    begin
      CheckType:= ctNone;
      MinWidth:= 200;
      CaptionAlignment:= taLeftJustify;
      Text:= 'Название МКБ';
    end;
  end;

  for i := 0 to Pred(VST.Header.Columns.Count) do
    VST.Header.Columns.Items[i].Options:= VST.Header.Columns.Items[i].Options
                      + [coAllowClick, coEnabled, coParentBidiMode,
                        coParentColor, coResizable, coShowDropMark,
                        coVisible, coAllowFocus];
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FValuesList.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  a,b: Cardinal;
begin

//  ActFillMDSExecute(Sender);
//  mds_d.Active:= True;
//  ActFillTreeByMDSExecute(Sender);

  ActFillArrayExecute(Sender);
  a:= GetTickCount;
  ActFillTreeByArrayExecute(Sender);
  b:= GetTickCount;
  Caption:= Format('Execute time: %d msec',[b-a]);
end;

procedure TForm1.VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if Assigned(Sender.GetNodeData(Node)) then
  begin
    PTreeData(Sender.GetNodeData(Node))^.ID:= -1;
    PTreeData(Sender.GetNodeData(Node))^.ParentID:= -1;
    PTreeData(Sender.GetNodeData(Node))^.Mkb_code:= '';
    PTreeData(Sender.GetNodeData(Node))^.Mkb_caption:= '';
  end;
end;

procedure TForm1.VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize:= SizeOf(TTreeData);
end;

procedure TForm1.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  case Column of
    0: CellText:= IntToStr(PTreeData(Sender.GetNodeData(Node))^.ID);
    1: CellText:= IntToStr(PTreeData(Sender.GetNodeData(Node))^.ParentID);
    2: CellText:= PTreeData(Sender.GetNodeData(Node))^.Mkb_code;
    3: CellText:= PTreeData(Sender.GetNodeData(Node))^.Mkb_caption;
  end;
end;

end.
