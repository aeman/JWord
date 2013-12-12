unit uFunc;

interface

uses
  Classes, IniFiles, Windows, Forms, Sysutils;

var
  cLeft, cTop: integer; //窗口位置
  cFormChange: boolean = False; //窗口位置是否改变

  cPath: string;  //系统当前路径，带“\”号
  cBook: string;  //系统当前书目

  cBegin: integer;    //从第几课
  cEnd: integer;      //到第几课
  cMode: integer;     //播放模式（单词和解释的先后顺序）
  cInter: integer;    //自动显示间隔
  cOrder: integer;    //是否顺序显示 0-顺序 1-随机

  cAuto: boolean;   //是否自动播放状态
  cHalf: boolean;   //是否显示了部分

  cTest: boolean;   //测试模式

  slBook, slLesson: TStrings;
  slRes, slWord, slDup, slTest: TStringList;
  sJapan, sChina: string;
  iWord, iDup, iTest: integer;    //计数器

procedure LoadConf;
procedure SaveConf;
procedure LoadBooks(sPath: string; var sBooks: TStrings);
procedure LoadLesson(sBook: string; var sLessons: TStrings);
procedure LoadWord(sBook: string);
procedure GetLimitWord(const ARes: TStringList; ABegin: integer; AEnd: integer;
  var ADes: TStringList);
procedure GetPriorWord;
procedure GetNextWord;
procedure SplitWord(const DWord: string; var JWord: string; var CWord: string);
procedure SaveFormPos(ALeft: integer; ATop: integer);

implementation

procedure LoadConf;
var
  myIni: TIniFile;
begin
  myIni := TIniFile.Create(cPath + 'JWord.ini');
  cLeft := myIni.ReadInteger('Form', 'left', 0);
  cTop := myIni.ReadInteger('Form', 'top', 0);

  cBook := myIni.ReadString('Book', 'name', '');
  cBegin := myIni.ReadInteger('Book', 'begin', 0);
  cEnd := myIni.ReadInteger('Book', 'end', 0);
  cMode := myIni.ReadInteger('Book', 'mode', 2);
  cOrder := myIni.ReadInteger('Book', 'order', 0);
  cInter := myIni.ReadInteger('Book', 'inter', 2);
  myIni.Free;
end;

procedure SaveConf;
var
  myIni: TIniFile;
begin
  myIni := TIniFile.Create(cPath + 'JWord.ini');
  myIni.WriteString('Book', 'name', cBook);
  myIni.WriteInteger('Book', 'begin', cBegin);
  myIni.WriteInteger('Book', 'end', cEnd);
  myIni.WriteInteger('Book', 'mode', cMode);
  myIni.WriteInteger('Book', 'order', cOrder);
  myIni.WriteInteger('Book', 'inter', cInter);
  myIni.Free;
end;

procedure LoadBooks(sPath: string; var sBooks: TStrings);
var
 sr: TSearchRec;
begin
  sBooks.Clear;
  FindFirst(sPath + '*.txt', faAnyFile, sr);
  sBooks.Add(sr.Name);
  while FindNext(sr) = 0 do sBooks.Add(sr.Name);
  FindClose(sr);
end;

procedure LoadLesson(sBook: string; var sLessons: TStrings);
var
  i: integer;
  slTmp: TStringList;
begin
  slTmp := TStringList.Create;
  try
    slTmp.LoadFromFile(sBook);
    for i := 0 to slTmp.Count - 1 do
      if Copy(slTmp[i],1,1) = '[' then sLessons.Add(slTmp[i]);
  finally
    slTmp.Free;
  end;
end;

procedure LoadWord(sBook: string);
var
  i, t, ic: integer;
  tmp: string;
begin
  slWord.Clear; slDup.Clear;
  iWord := 0; iDup := 0;

  //读取全部单词到slRes列表
  slRes.LoadFromFile(sBook);

  //根据配置文件从slRes中获取单词
  if cTest then slWord.Assign(slRes)
  else GetLimitWord(slRes, cBegin, cEnd, slWord);

  //复制slWord列表，乱序排列单词
  for i := 0 to slWord.Count - 1 do slDup.Add(slWord[i]);
  Randomize;
  ic := slDup.Count;
  for i := 0 to slDup.Count - 1 do begin
    t := Random(ic);
    tmp := slDup[t];
    slDup[t] := slDup[i];
    slDup[i] := tmp;
  end;
end;

procedure GetLimitWord(const ARes: TStringList; ABegin: integer; AEnd: integer;
  var ADes: TStringList);
var
  i, iB, iE: integer;
  sB, sE: string;
begin
  iB := 0; iE := 0;

  if (ABegin = 0) or (AEnd = 0) then begin
    for i := 0 to ARes.Count - 1 do if ARes[i] <> '' then ADes.Add(ARes[i]);
    Exit;
  end;

  sB := '[第' + IntToStr(cBegin) + '课]';
  sE := '[第' + IntToStr(cEnd+1) + '课]';

  for i := 0 to ARes.Count - 1 do begin
    if ARes[i] = sB then iB := i;
    if ARes[i] = sE then iE := i;
  end;

  if iE = 0 then iE := ARes.Count;
  for i := iB to iE - 1 do if ARes[i] <> '' then ADes.Add(ARes[i]);
end;

procedure GetPriorWord;
begin
  if cOrder = 0 then begin
    Dec(iWord);
    if iWord < 0 then iWord := slWord.Count-1;
    SplitWord(slWord[iWord], sJapan, sChina);
  end else begin
    Dec(iDup);
    if iDup < 0 then iDup := slDup.Count-1;
    SplitWord(slDup[iDup], sJapan, sChina);
  end;
end;

procedure GetNextWord;
begin
  if cOrder = 0 then begin
    SplitWord(slWord[iWord], sJapan, sChina);
    Inc(iWord);
    if iWord = slWord.Count then iWord := 0;
  end else begin
    SplitWord(slDup[iDup], sJapan, sChina);
    Inc(iDup);
    if iDup = slDup.Count then iDup := 0;
  end;
end;

procedure SplitWord(const DWord: string; var JWord: string; var CWord: string);
var
  i: integer;
begin
  i := Pos('|', DWord);
  JWord := Copy(DWord, 0, i-1);
  CWord := Copy(DWord, i+1);
end;

procedure SaveFormPos(ALeft: integer; ATop: integer);
var
  myIni: TIniFile;
begin
  myIni := TIniFile.Create(cPath + 'JWord.ini');
  myIni.WriteInteger('Form', 'left', ALeft);
  myIni.WriteInteger('Form', 'top', ATop);
  myIni.Free;
end;

end.
