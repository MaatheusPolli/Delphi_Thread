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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

{ Tfrm_principal }

procedure Tfrm_principal.btnBarra1Click(Sender: TObject);
var
  Task: TTarefaParalela;
begin
  {	CreateSuspended. Se TThread.Create(True), então a Thread não é
  iniciada automaticamente, senão ela é executada a partir deste
  momento;}
  Task := TTarefaParalela.Create(True);
  Task.ConfiguraTask(ProgressBar1,True);
  try
    {Permite que a Thread seja pausada para que sua execução possa 	ocorrer posteriormente}
    Task.Suspend;

    if Pos('Task inicializada', lblBarra1.caption) = 0 then
      lblBarra1.caption := lblBarra1.Caption + '- Task inicializada!';

    {Inicia a Tarefa rodando Execute}
    Task.Start;
  finally
  end;
end;

procedure Tfrm_principal.BtnBarra2Click(Sender: TObject);
var
  Task: TTarefaParalela;
begin
  {	CreateSuspended. Se TThread.Create(True), então a Thread não é
  iniciada automaticamente, senão ela é executada a partir deste
  momento;}
  Task := TTarefaParalela.Create(True);
  Task.ConfiguraTask(ProgressBar2,True);
  try
    {Permite que a Thread seja pausada para que sua execução possa 	ocorrer posteriormente}
    Task.Suspend;

    if Pos('Task inicializada', lblBarra2.caption) = 0 then
      lblBarra2.caption := lblBarra2.Caption + '- Task inicializada!';

    {Inicia a Tarefa rodando Execute}
    Task.Start;
  finally
  end;
end;

procedure Tfrm_principal.btnMsgTelaClick(Sender: TObject);
begin
  ShowMessage('Mensagem teste .... Progresso aumenta enquanto tem mensagem na tela?');
end;

procedure Tfrm_principal.btnIniciaTodasBarrasClick(Sender: TObject);
begin
  btnBarra1Click(Sender);
  btnBarra2Click(Sender);
end;

end.
