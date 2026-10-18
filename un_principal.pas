unit un_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, un_tarefaParalela;

type
  Tfrm_principal = class(TForm)
    pnlGeral: TPanel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    btnBarra1: TButton;
    BtnBarra2: TButton;
    lblBarra2: TLabel;
    lblBarra1: TLabel;
    btnMsgTela: TButton;
    btnIniciaTodasBarras: TButton;
    procedure btnMsgTelaClick(Sender: TObject);
    procedure btnBarra1Click(Sender: TObject);
    procedure BtnBarra2Click(Sender: TObject);
    procedure btnIniciaTodasBarrasClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FTarefasAtivas: Integer;
    procedure IniciaTarefa(Barra: TProgressBar; Lbl: TLabel);
    procedure TarefaTerminou(Sender: TObject);
    procedure AtualizaBotoes;
  public
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

{ Tfrm_principal }

procedure Tfrm_principal.IniciaTarefa(Barra: TProgressBar; Lbl: TLabel);
var
  Task: TTarefaParalela;
begin
  Task := TTarefaParalela.Create(Barra);
  Task.OnTerminate := TarefaTerminou;

  if Pos('Task inicializada', Lbl.Caption) = 0 then
    Lbl.Caption := Lbl.Caption + ' - Task inicializada!';

  Inc(FTarefasAtivas);
  AtualizaBotoes;

  Barra.Position := 0;
  { Start executa Execute na thread criada suspensa }
  Task.Start;
end;

procedure Tfrm_principal.TarefaTerminou(Sender: TObject);
begin
  { OnTerminate roda na thread principal }
  Dec(FTarefasAtivas);
  AtualizaBotoes;
end;

procedure Tfrm_principal.AtualizaBotoes;
begin
  { Evita iniciar a mesma barra duas vezes enquanto há tarefas rodando }
  btnBarra1.Enabled := FTarefasAtivas = 0;
  BtnBarra2.Enabled := FTarefasAtivas = 0;
  btnIniciaTodasBarras.Enabled := FTarefasAtivas = 0;
end;

procedure Tfrm_principal.btnBarra1Click(Sender: TObject);
begin
  IniciaTarefa(ProgressBar1, lblBarra1);
end;

procedure Tfrm_principal.BtnBarra2Click(Sender: TObject);
begin
  IniciaTarefa(ProgressBar2, lblBarra2);
end;

procedure Tfrm_principal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  { As threads chamam Synchronize com o formulário; fechar com tarefas rodando causaria acesso a objeto liberado }
  CanClose := FTarefasAtivas = 0;
  if not CanClose then
    MessageDlg('Aguarde o término das barras de progresso antes de fechar.', mtInformation, [mbOK], 0);
end;

procedure Tfrm_principal.btnMsgTelaClick(Sender: TObject);
begin
  ShowMessage('Mensagem teste .... Progresso aumenta enquanto tem mensagem na tela?');
end;

procedure Tfrm_principal.btnIniciaTodasBarrasClick(Sender: TObject);
begin
  IniciaTarefa(ProgressBar1, lblBarra1);
  IniciaTarefa(ProgressBar2, lblBarra2);
end;

end.
