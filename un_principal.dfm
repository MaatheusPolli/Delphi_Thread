object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  Caption = 'Estudando Thread'
  ClientHeight = 227
  ClientWidth = 563
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
  object pnlGeral: TPanel
    Left = 0
    Top = 0
    Width = 563
    Height = 227
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 559
    ExplicitHeight = 359
    object lblBarra2: TLabel
      Left = 15
      Top = 80
      Width = 83
      Height = 13
      Caption = 'Barra de Progr. 2'
    end
    object lblBarra1: TLabel
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
    object btnBarra1: TButton
      Left = 15
      Top = 161
      Width = 98
      Height = 37
      Caption = 'Barra 1'
      TabOrder = 2
      OnClick = btnBarra1Click
    end
    object BtnBarra2: TButton
      Left = 135
      Top = 161
      Width = 97
      Height = 37
      Caption = 'Barra 2'
      TabOrder = 3
      OnClick = BtnBarra2Click
    end
    object btnMsgTela: TButton
      Left = 256
      Top = 161
      Width = 128
      Height = 37
      Caption = 'Mensagem na Tela'
      TabOrder = 4
      OnClick = btnMsgTelaClick
    end
    object btnIniciaTodasBarras: TButton
      Left = 400
      Top = 161
      Width = 145
      Height = 37
      Caption = 'Iniciar as Duas Barras'
      TabOrder = 5
      OnClick = btnIniciaTodasBarrasClick
    end
  end
end
