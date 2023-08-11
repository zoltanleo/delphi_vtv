unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees;

type
  PMyRec = ^TMyRec;
  TMyRec = record
    aInt: Integer;
  end;

  TForm1 = class(TForm)
    vst: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure FormShow(Sender: TObject);
    procedure vstInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
const
  cntR = 3;
  cntCh = 10;
var
  i,j: Integer;
  rNode, chNode: PVirtualNode;
  Data: PMyRec;
begin
  with vst do
  begin
    Header.Options:= Header.Options
            + [
//              hoAutoResize,
              hoVisible]
            - []
            ;
    Header.Columns.Clear;
    Header.MainColumn:= 0;
    Header.Columns.Add;
    Header.Columns[0].Text:= 'Строки';
    Header.Columns[0].MinWidth:= 200;
    Header.Columns[0].CheckBox:= True;


    Header.Columns.Add;
    Header.Columns[1].Text:= 'Номера';
    Header.Columns[1].MinWidth:= 100;



    TreeOptions.MiscOptions:= TreeOptions.MiscOptions
            + [toCheckSupport, toEditable]
            - []
            ;

    TreeOptions.SelectionOptions:= TreeOptions.SelectionOptions
            + [toExtendedFocus]
            - []
            ;
  end;

  for i := 0 to cntR do
  begin
    rNode:= vst.AddChild(nil);

    Data:= vst.GetNodeData(rNode);

    if not Assigned(Data) then Continue;

    Data^.aInt:= i;

    for j := 0 to cntCh do
    begin
      chNode:= vst.AddChild(rNode);
      Data:= vst.GetNodeData(chNode);

      if not Assigned(Data) then Continue;
      Data^.aInt:= j;
    end;
  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  vst.FullExpand(nil);
end;

procedure TForm1.vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PMyRec;
begin
  Data:= Sender.GetNodeData(Node);

  if Assigned(Data) then Finalize(Data^);
end;

procedure TForm1.vstGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize:= SizeOf(TMyRec);
end;

procedure TForm1.vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
    Data: PMyRec;
    NodeLvl: Integer;
begin
  Data:= Sender.GetNodeData(Node);

  if not Assigned(Data) then Exit;

  NodeLvl:= Sender.GetNodeLevel(Node);

  case NodeLvl of
    0:
      begin
        case Column of
          0: CellText:= 'Root-строка: ' + IntToStr(Data^.aInt);
          1: CellText:= '';
        end;
      end;
    1:
      begin
        case Column of
          0: CellText:= 'Child-строка: ' + IntToStr(Data^.aInt);
          1: CellText:= IntToStr(Data^.aInt);
        end;
      end;
  end;

end;

procedure TForm1.vstInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  Node^.CheckType:= ctTriStateCheckBox;
end;

end.
