unit uSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TfmSet = class(TForm)
    cbBook: TComboBox;
    cbLesson: TComboBox;
    Label1: TLabel;
    cbLesson2: TComboBox;
    cbMode: TComboBox;
    tbTime: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    bbOk: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    chbRand: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure cbBookChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSet: TfmSet;

implementation

uses uFunc, uMain;

{$R *.dfm}

procedure TfmSet.bbOkClick(Sender: TObject);
var
  cOldBook: string;
  cOldBegin, cOldEnd: integer;
begin
  cOldBook := cBook; cOldBegin := cBegin; cOldEnd := cEnd;

  if (cbLesson.ItemIndex = 0) and (cbLesson2.ItemIndex > 0)
    or (cbLesson2.ItemIndex = 0) and (cbLesson.ItemIndex > 0) then begin
    MessageDlg('开始课程和结束课程必须同时选全部！', mtError, [mbOk], 0);
    Exit;
  end;

  if cbLesson.ItemIndex > cbLesson2.ItemIndex then begin
    MessageDlg('开始课程不能大于结束课程！', mtError, [mbOk], 0);
    Exit;
  end;

  if tbTime.Position = 0 then begin
    MessageDlg('自动播放间隔不能为0！', mtError, [mbOk], 0);
    Exit;
  end;

  cBook := cbBook.Items[cbBook.ItemIndex];
  cBegin := cbLesson.ItemIndex;
  cEnd := cbLesson2.ItemIndex;
  cMode := cbMode.ItemIndex;
  if chbRand.Checked then cOrder := 1 else cOrder := 0;
  cInter := tbTime.Position;
  SaveConf;

  if (cBook <> cOldBook) or (cBegin <> cOldBegin) or (cEnd <> cOldEnd) then begin
    LoadWord(cPath + 'book\' + cBook);
    fmMain.lblJapan.Caption := cBook;
    fmMain.lblChina.Caption := '';
  end;

  ModalResult := mrOK;
end;

procedure TfmSet.cbBookChange(Sender: TObject);
begin
  slLesson.Clear;
  LoadLesson(cPath + 'book\' + cbBook.Text, slLesson);
  cbLesson.Items.Assign(slLesson);
  cbLesson.Items.Insert(0, '全部');
  cbLesson2.Items.Assign(slLesson);
  cbLesson2.Items.Insert(0, '全部');
  cbLesson.ItemIndex := 0;
  cbLesson2.ItemIndex := 0;
end;

procedure TfmSet.FormShow(Sender: TObject);
var
  i: integer;
begin
  LoadBooks(cPath + 'book\', slBook);
  cbBook.Items.Assign(slBook);

  for i := 0 to cbBook.Items.Count - 1 do
    if cbBook.Items[i]  = cBook then begin
      cbBook.ItemIndex := i;
      Break;
    end;

  LoadLesson(cPath + 'book\' + cBook, slLesson);
  cbLesson.Items.Assign(slLesson);
  cbLesson.Items.Insert(0, '全部');
  cbLesson2.Items.Assign(slLesson);
  cbLesson2.Items.Insert(0, '全部');

  cbLesson.ItemIndex := cBegin;
  cbLesson2.ItemIndex := cEnd;

  cbMode.ItemIndex := cMode;
  chbRand.Checked := (cOrder = 1);
  tbTime.Position := cInter;
end;

end.
