unit un_tarefaParalela;

interface

uses
  Winapi.Windows, System.Classes, Vcl.ComCtrls, System.SyncObjs;

type
  { Thread que avança uma TProgressBar de 1 a 100 sem travar a tela }
  TTarefaParalela = class(TThread)
  private
    FProgressBar: TProgressBar;
    FControle: TCriticalSection;
    FPosicao: Integer;
    procedure AtualizaBarra;
  protected
    { Código executado pela thread. Verifique Terminated para encerrar cedo. }
    procedure Execute; override;
  public
    { Cria a thread suspensa. Chame Start para iniciá-la. }
    constructor Create(Barra: TProgressBar);
    destructor Destroy; override;
  end;

implementation

{ TTarefaParalela }

constructor TTarefaParalela.Create(Barra: TProgressBar);
begin
  inherited Create(True);
  FProgressBar := Barra;
  FControle := TCriticalSection.Create;

  { Libera a instância sozinha ao terminar, sem precisar de Free }
  FreeOnTerminate := True;
  Priority := tpNormal;
end;

destructor TTarefaParalela.Destroy;
begin
  FControle.Free;
  inherited;
end;

procedure TTarefaParalela.AtualizaBarra;
begin
  { Roda na thread principal (via Synchronize), onde é seguro usar componentes VCL }
  FControle.Acquire;
  try
    FProgressBar.Position := FPosicao;
  finally
    FControle.Release;
  end;
end;

procedure TTarefaParalela.Execute;
var
  i: Integer;
begin
  for i := 1 to 100 do
  begin
    if Terminated then
      Exit;

    FControle.Acquire;
    try
      FPosicao := i;
    finally
      FControle.Release;
    end;

    Synchronize(AtualizaBarra);
    Sleep(25);
  end;
end;

end.
