unit un_tarefaParalela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, SyncObjs;

type
   { Thread }
   TTarefaParalela = class(TThread)
      protected
        	{O código que será executado pela Thread. Uma boa prática é efetuar a
          verificação do valor da propriedade Terminated, pois se o
          mesmo for True indica que a 	Thread foi finalizada.}
         procedure Execute; override;

      private
        Controle : TCriticalSection;
        FProgressBar: TProgressBar;
        procedure SetCriticalSection(bAtivar: Boolean);

      public
        destructor Destroy; override;

        procedure ConfiguraTask(Barra: TProgressBar; bCreateSuspended: Boolean);
        procedure SetProgressBar;
   end;

implementation

{ TTarefaParalela }

destructor TTarefaParalela.Destroy;
begin
  inherited;
  Controle.Free;
end;

procedure TTarefaParalela.Execute;
begin
  {determinação do nível de prioridade de execução da Thread em
  questão com relação as outras Threads que fazem parte do 		processo atual;}
  Priority := tpNormal;

  try
    SetCriticalSection(True);
    SetProgressBar;
  finally
    SetCriticalSection(False);
  end;
end;

procedure TTarefaParalela.SetCriticalSection(bAtivar: Boolean);
begin
  if bAtivar then
    Controle.Acquire
  else
    Controle.Release;
end;

procedure TTarefaParalela.SetProgressBar;
var
  i:Integer;
begin
  for I := 1 to 100 do
  begin
    FProgressBar.Position := i;
    Sleep(25);
  end;
end;

procedure TTarefaParalela.ConfiguraTask(Barra: TProgressBar; bCreateSuspended: Boolean);
begin
  FProgressBar := Barra;

  Controle := TCriticalSection.Create;

  {	Quando definido como True, permite a 	destruição/liberação da instância de TThread
   de uma forma 	automática, dispensando assim o uso do FreeAndNil(), 	que é
   utilizado para liberar objetos.}
  FreeOnTerminate := True;

  {Faz com que a Thread inicie, caso tenha sido criada em estado de
  suspensão, efetuando assim o código presente no procedimento 	Execute;}
  Resume;
end;

end.
