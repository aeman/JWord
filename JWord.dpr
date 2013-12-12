program JWord;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uFunc in 'uFunc.pas',
  uSet in 'uSet.pas' {fmSet};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
