object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  Caption = 'Estudando Thread'
  ClientHeight = 359
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 559
    Height = 359
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 80
      Width = 83
      Height = 13
      Caption = 'Barra de Progr. 2'
    end
    object Label2: TLabel
      Left = 15
      Top = 5
      Width = 83
      Height = 13
      Caption = 'Barra de Progr. 1'
    end
    object ProgressBar1: TProgressBar
      Left = 15
      Top = 24
      Width = 530
      Height = 40
      TabOrder = 0
    end
    object ProgressBar2: TProgressBar
      Left = 15
      Top = 95
      Width = 530
      Height = 40
      TabOrder = 1
    end
    object Button1: TButton
      Left = 79
      Top = 162
      Width = 98
      Height = 37
      Caption = 'Barra 1'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 207
      Top = 161
      Width = 97
      Height = 37
      Caption = 'Barra 2'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 328
      Top = 161
      Width = 128
      Height = 37
      Caption = 'Mensagem na Tela'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 159
      Top = 233
      Width = 145
      Height = 37
      Caption = 'Iniciar as Duas Barras'
      TabOrder = 5
      OnClick = Button4Click
    end
  end
end
