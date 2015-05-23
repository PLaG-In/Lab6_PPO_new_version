unit Unit1;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.MPlayer, Vcl.ImgList;

type
  TForm1 = class(TForm)
    AnimationTimer: TTimer;
    MediaPlayer1: TMediaPlayer;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure AnimationTimerTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private

  public
    {procedure Click; override;
    property ClickCount : Longint read FClickCount write FClickCount;  }
  end;

Const
  LABEL_WIDTH = 41;
  LABEL_HEIGHT = 65;
  BALLOON_SPEED = 5;

var
  Form1: TForm1;
  background, backbuffer: TBitmap;
  balloon1: TBitmap;
  balloon2: TBitmap;
  balloon3: TBitmap;
  balloon4: TBitmap;
  boom: TBitmap;
  n, p, o, count,
  t, t1, t2, t3: integer;
  x: integer = 100;
  x1: integer = 200;
  x2: integer = 300;
  x3: integer = 400;
  y: integer = 0;
  y1: integer = 0;
  y2: integer = 0;
  y3: integer = 0;
implementation

{$R *.dfm}

function MyTimer(var t0: integer): integer;
begin
    MyTimer := t0 + BALLOON_SPEED;
end;

Procedure ReDraw;
Var
  down: Real;
begin
  {1. Рисуем все на backbuffer}
  backbuffer.Canvas.Draw(0, 0, background);
  {1.2. рисуем мяч, вычисляем угол движения мяча по кругу в зависимости
   от текущего времени}

  y := t;
  y1 := t1;
  y2 := t2;
  y3 := t3;
  Form1.Label2.Left:=Round(x);
  Form1.Label2.Top:=Round(y);
  Form1.Label3.Left:=Round(x1);
  Form1.Label3.Top:=Round(y1);
  Form1.Label4.Left:=Round(x2);
  Form1.Label4.Top:=Round(y2);
  Form1.Label5.Left:=Round(x3);
  Form1.Label5.Top:=Round(y3);
  backbuffer.Canvas.Draw(x, y, balloon1);
  backbuffer.Canvas.Draw(x1, y1, balloon2);
  backbuffer.Canvas.Draw(x2, y2, balloon3);
  backbuffer.Canvas.Draw(x3, y3, balloon4);
  {2. Отрисовываем backbuffer на форму}
  Form1.Canvas.Draw(0, 0, backbuffer);
  Form1.Label1.Caption := 'SCORE: ' + IntToStr(count);
end;

procedure BalloonsDown(Image: TBitmap; var y0: integer; var x0: integer; var t0: integer);
begin
  if y0 > (background.height - 50) then
  begin
    t0 := 0;
    x0 := Random(background.width - Image.width - 50);
    count := count - 1;
    Form1.Label1.Caption := 'SCORE: '+IntToStr(count);
  end;
end;

procedure TForm1.AnimationTimerTimer(Sender: TObject);
begin
  BalloonsDown(balloon1, y, x, t);
  BalloonsDown(balloon2, y1, x1, t1);
  BalloonsDown(balloon3, y2, x2, t2);
  BalloonsDown(balloon4, y3, x3, t3);
  Label1.Caption := 'SCORE: '+IntToStr(count);
  t := MyTimer(t);
  t1 := MyTimer(t1);
  t2 := MyTimer(t2);
  t3 := MyTimer(t3);
  ReDraw;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  randomize;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  {перерисовываем все, когда часть формы испортилась}
  ReDraw;
end;

procedure LoadImageOrDie(var bmp: TBitmap; fileName: string);
begin
  {пытаемся загрузить изображение}
  try
    bmp.LoadFromFile(fileName);
  except {если не получается, ругаемся и выходим из приложения}
    ShowMessage('Невозможно загрузить изображение ' + fileName);
    Application.Terminate;
  end;
end;

procedure LoadBalloonsAndBoom(var image: TBitmap; fileName: string);
begin
  image := TBitmap.Create;
  LoadImageOrDie(image, fileName);
  image.Transparent := true;
  image.TransparentColor := clWhite;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  count := 0; t := 0;
  t1 := 0; t2 := 0; t3 := 0;
  AnimationTimer.Enabled := false;
  {создаем bitmap для заднего фона}
  background := TBitmap.Create;
  LoadImageOrDie(background, 'back.bmp');

  Form1.Label2.Width := LABEL_WIDTH;
  Form1.Label3.Width := LABEL_WIDTH;
  Form1.Label4.Width := LABEL_WIDTH;
  Form1.Label5.Width := LABEL_WIDTH;
  Form1.Label2.Height := LABEL_WIDTH;
  Form1.Label3.Height := LABEL_WIDTH;
  Form1.Label4.Height := LABEL_WIDTH;
  Form1.Label5.Height := LABEL_WIDTH;

  LoadBalloonsAndBoom(balloon1, 'balloon1.bmp');
  LoadBalloonsAndBoom(balloon2, 'balloon2.bmp');
  LoadBalloonsAndBoom(balloon3, 'balloon3.bmp');
  LoadBalloonsAndBoom(balloon4, 'balloon4.bmp');
  LoadBalloonsAndBoom(boom, 'boom.bmp');

  {создаем backbuffer, размером с задний фон}
  backbuffer := TBitmap.Create;
  backbuffer.width := background.width;
  backbuffer.height := background.height;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  o := 1;
  if AnimationTimer.enabled = true then
  begin
    AnimationTimer.Enabled := false;
    Button1.Caption := 'Start';
    o := 0;
  end;

  if (AnimationTimer.Enabled = false) and (o = 1) then
  begin
    AnimationTimer.Enabled := true;
    Button1.Caption := 'Stop';
  end;
end;

procedure Clicker(Image: TBitmap; var t0: integer; var y0: integer; var x0: integer);
begin
  Form1.Canvas.Draw(x0 - 10, y0 - 10, boom);
  y0 := 0;
  t0 := 0;
  x0 := Random(background.width - Image.width - 50);
  count := count + 1;
  Form1.MediaPlayer1.FileName := 'exp.wav';
  Form1.MediaPlayer1.Open();
  Form1.MediaPlayer1.Play;
  Form1.Label1.Caption := 'SCORE: ' + IntToStr(count);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  Clicker(balloon1, t, y, x);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  Clicker(balloon2, t1, y1, x1);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  Clicker(balloon3, t2, y2, x2);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
  Clicker(balloon4, t3, y3, x3);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {на выходе из формы удаляем изображения}
  background.Free;
  backbuffer.Free;
  balloon1.Free;
  balloon2.Free;
  balloon3.Free;
  balloon4.Free;
  boom.Free;
end;

end.
