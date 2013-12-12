unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, Menus, ShellAPI, Dialogs;

const
  CM_RESTORE = WM_USER  + 100;

type
  TfmMain = class(TForm)
    tmWord: TTimer;
    lblJapan: TLabel;
    lblChina: TLabel;
    sbPlay: TSpeedButton;
    pmMain: TPopupMenu;
    miSet: TMenuItem;
    miClose: TMenuItem;
    miAbout: TMenuItem;
    miTest: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmWordTimer(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miSetClick(Sender: TObject);
    procedure sbPlayClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miTestClick(Sender: TObject);
  private
    { Private declarations }
    procedure RestoreRequest(var Msg: TMessage); message CM_RESTORE;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  nid: TNotifyIconData;

implementation

uses uSet, uFunc;

{$R *.dfm}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  AlphaBlend := True;
  AlphaBlendValue := 200;

  nid.cbSize := sizeof(nid);
  nid.Wnd := Handle;
  nid.uID := 0;
  nid.hIcon := Application.Icon.Handle;
  nid.szTip := 'JWord 0.1';
  nid.uCallbackMessage := CM_RESTORE;
  nid.uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
  Shell_NotifyIcona(NIM_ADD, @nid);

  slBook := TStringList.Create;
  slLesson := TStringList.Create;
  slRes := TStringList.Create;
  slWord := TStringList.Create;
  slDup := TStringList.Create;
  slTest := TStringList.Create;

  cPath := ExtractFilePath(Application.ExeName);
  LoadConf;
  Left := cLeft;
  Top := cTop;
  LoadWord(cPath + 'book\' + cBook);

  lblJapan.Caption := cBook;
  cAuto := False;
  cHalf := False;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  slBook.Free;
  slLesson.Free;
  slRes.Free;
  slWord.Free;
  slDup.Free;
  slTest.Free;

  Shell_NotifyIcona(NIM_DELETE, @nid);
end;

procedure TfmMain.FormHide(Sender: TObject);
begin
//  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then fmMain.Hide;

  //点击‘a’键将单词添加到测试列表
  if (not cTest) and (Key in [$41]) then begin
    if cOrder = 0 then
      slTest.Add(slWord[iWord-1])
    else
      slTest.Add(slDup[iDup-1]);
  end;

  if cTest then begin
    if Key in [VK_RETURN, VK_SPACE] then begin
      if slTest[iTest] = '' then begin
        Inc(iTest);
        Exit;
      end;
      SplitWord(slTest[iTest], sJapan, sChina);
      Inc(iTest);
      if iTest = slTest.Count then iTest := 0;
          lblChina.Caption := sChina;
          lblJapan.Caption := sJapan;
{        if not cHalf then begin
          lblJapan.Caption := '';
          lblChina.Caption := sChina;
        end else begin
          lblJapan.Caption := sJapan;
        end;
        cHalf := not cHalf;
 }
    end else if (Key in [$44]) then begin
      slTest[iTest-1] := '';
    end;
  end;


  if cAuto then Exit;

  if (not cTest) and (Key in [VK_RETURN, VK_SPACE, VK_RIGHT, VK_DOWN, VK_UP, VK_LEFT]) then begin
    if (cMode = 0) or ((cMode > 0) and (not cHalf)) then begin
      if Key in [VK_UP, VK_LEFT] then GetPriorWord else GetNextWord;
    end;

    case cMode of
      0: begin
        lblJapan.Caption := sJapan;
        lblChina.Caption := sChina;
      end;
      1: begin
        if not cHalf then begin
          lblJapan.Caption := sJapan;
          lblChina.Caption := '';
        end else begin
          lblChina.Caption := sChina;
        end;
        cHalf := not cHalf;
      end;
      2: begin
        if not cHalf then begin
          lblJapan.Caption := '';
          lblChina.Caption := sChina;
        end else begin
          lblJapan.Caption := sJapan;
        end;
        cHalf := not cHalf;
      end;
    end;  //end case
  end;  //end if Key in [VK_RETURN, VK_SPACE, VK_RIGHT, VK_DOWN, VK_UP, VK_LEFT]
end;

procedure TfmMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then cFormChange := True;

  ReleaseCapture;
  SendMessage(Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfmMain.miSetClick(Sender: TObject);
var
  dlg: TfmSet;
begin
  dlg := TfmSet.Create(Application);
  dlg.ShowModal;
end;

procedure TfmMain.miTestClick(Sender: TObject);
var
  i: integer;
begin
  cTest := not cTest;
  miTest.Checked := cTest;

  if cTest then begin
    if slTest.Count > 0 then begin
      if FileExists('test.txt') then DeleteFile('test.txt');
      slTest.SaveToFile('test.txt');
      slTest.Clear;
    end;
    slRes.LoadFromFile(cPath + 'test.txt');
    for i := 0 to slRes.Count - 1 do if slRes[i] <> '' then slTest.Add(slRes[i]);
    iTest := 0;
  end;
end;

procedure TfmMain.RestoreRequest(var Msg: TMessage);
var
  p:TPoint;
begin
  if Msg.LParam = WM_LBUTTONDBLCLK then begin
    fmMain.Show;
//    fmMain.BringToFront;
    Application.BringToFront;
  end else if Msg.LParam = WM_RBUTTONUP then begin
    GetCursorPos(P);//获得鼠标坐标
    pmMain.Popup(P.X, P.Y);//在鼠标光标处显示弹出菜单
  end;
end;

procedure TfmMain.miAboutClick(Sender: TObject);
begin
  MessageDlg('JWord 0.2 Beta            ' + #13#13
    + '功能：                           ' + #13
    + '1、播放按钮自动播放，再次按停止  ' + #13
    + '2、回车键或空格键手动播放        ' + #13
    + '3、[ESC]键界面隐藏               ' + #13
    + '4、双击桌面右下角小图标重新显示  ',
    mtInformation, [mbOk], 0);
end;

procedure TfmMain.miCloseClick(Sender: TObject);
begin
  if cFormChange then SaveFormPos(Left, Top);
  close;
end;

procedure TfmMain.sbPlayClick(Sender: TObject);
begin
  cAuto := not cAuto;
//  if cAuto then FormStyle := fsStayOnTop else FormStyle := fsNormal;

  tmWord.Interval := cInter*1000;
  tmWord.Enabled := cAuto;
end;

procedure TfmMain.tmWordTimer(Sender: TObject);
begin
  GetNextWord;

  lblJapan.Caption := sJapan;
//  lblChina.Caption := '';
//  Application.ProcessMessages;
//  Sleep(cInter*500);
  lblChina.Caption := sChina;
end;

end.
