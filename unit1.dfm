object Form1: TForm1
  Left = 192
  Top = 107
  BorderStyle = bsSizeToolWin
  Caption = 'Balloons'
  ClientHeight = 606
  ClientWidth = 860
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 770
    Top = 8
    Width = 53
    Height = 22
    Caption = 'SCORE: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Gill Sans Ultra Bold Condensed'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 504
    Top = 248
    Width = 41
    Height = 49
    OnClick = Label2Click
  end
  object Label3: TLabel
    Left = 448
    Top = 248
    Width = 39
    Height = 49
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 385
    Top = 248
    Width = 3
    Height = 13
    OnClick = Label4Click
  end
  object Label5: TLabel
    Left = 330
    Top = 248
    Width = 3
    Height = 13
    OnClick = Label5Click
  end
  object MediaPlayer1: TMediaPlayer
    Left = 605
    Top = 502
    Width = 253
    Height = 20
    Visible = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 770
    Top = 528
    Width = 82
    Height = 41
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object AnimationTimer: TTimer
    Enabled = False
    Interval = 30
    OnTimer = AnimationTimerTimer
    Left = 384
    Top = 64
  end
end
