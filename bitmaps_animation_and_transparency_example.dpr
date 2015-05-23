program bitmaps_animation_and_transparency_example;

uses
  Forms,
  unit1 in 'unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
