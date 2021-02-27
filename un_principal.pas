unit un_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, un_tarefaParalela;

type
  Tfrm_principal = class(TForm)
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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

procedure Tfrm_principal.Button1Click(Sender: TObject);
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

    if Pos('Task inicializada', Label2.caption) = 0 then
      Label2.caption := Label2.Caption + '- Task inicializada!';

    {Inicia a Tarefa rodando Execute}
    Task.Start;
  finally
    {Faz com que a execução da Thread seja encerrada.}
  end;
end;

procedure Tfrm_principal.Button2Click(Sender: TObject);
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

    if Pos('Task inicializada', Label1.caption) = 0 then
      Label1.caption := Label1.Caption + '- Task inicializada!';

    {Inicia a Tarefa rodando Execute}
    Task.Start;
  finally
    {Faz com que a execução da Thread seja encerrada.}
  end;
end;

procedure Tfrm_principal.Button3Click(Sender: TObject);
begin
  ShowMessage('Mensagem teste .... Progresso aumenta enquanto tem mensagem na tela?');
end;

procedure Tfrm_principal.Button4Click(Sender: TObject);
begin
  Button1Click(Sender);
  Button2Click(Sender);
end;

end.
