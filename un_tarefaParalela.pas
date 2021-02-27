unit un_tarefaParalela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, SyncObjs;

type
   { Thread }
   TTarefaParalela = class(TThread)
      protected
        	{O c�digo que ser� executado pela Thread. Uma boa pr�tica � efetuar a
          verifica��o do valor da propriedade Terminated, pois se o
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
  {determina��o do n�vel de prioridade de execu��o da Thread em
  quest�o com rela��o as outras Threads que fazem parte do 		processo atual;}
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

  {	Quando definido como True, permite a 	destrui��o/libera��o da inst�ncia de TThread
   de uma forma 	autom�tica, dispensando assim o uso do FreeAndNil(), 	que �
   utilizado para liberar objetos.}
  FreeOnTerminate := True;

  {Faz com que a Thread inicie, caso tenha sido criada em estado de
  suspens�o, efetuando assim o c�digo presente no procedimento 	Execute;}
  Resume;
end;

end.
