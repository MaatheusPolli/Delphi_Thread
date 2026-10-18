program test_tarefa;

{$mode delphi}{$H+}

uses
  SysUtils, Classes, Vcl.ComCtrls, un_tarefaParalela;

type
  TOuvinte = class
  public
    Terminou: Boolean;
    procedure AoTerminar(Sender: TObject);
  end;

var
  Falhas: Integer = 0;
  Aprovados: Integer = 0;

procedure Verifica(Condicao: Boolean; const Descricao: string);
begin
  if Condicao then
  begin
    Inc(Aprovados);
    WriteLn('[OK]   ', Descricao);
  end
  else
  begin
    Inc(Falhas);
    WriteLn('[FALHA] ', Descricao);
  end;
end;

procedure TOuvinte.AoTerminar(Sender: TObject);
begin
  Terminou := True;
end;

{ Processa mensagens da thread principal ate a tarefa terminar ou estourar o tempo }
function EsperaTermino(Ouvinte: TOuvinte; LimiteMs: Integer): Boolean;
var
  Fim: TDateTime;
begin
  Fim := Now + (LimiteMs / (24 * 60 * 60 * 1000));
  while (Now < Fim) and not Ouvinte.Terminou do
    CheckSynchronize(10);
  Result := Ouvinte.Terminou;
end;

{ Processa mensagens da thread principal ate a barra registrar N atualizacoes }
function EsperaAtualizacoes(Quantidade, LimiteMs: Integer): Boolean;
var
  Fim: TDateTime;
begin
  Fim := Now + (LimiteMs / (24 * 60 * 60 * 1000));
  while (Now < Fim) and (Length(AtualizacoesPosition) < Quantidade) do
    CheckSynchronize(10);
  Result := Length(AtualizacoesPosition) >= Quantidade;
end;

procedure ZeraRegistros;
begin
  SetLength(AtualizacoesPosition, 0);
  AtualizacoesForaDaPrincipal := 0;
end;

var
  Barra: TProgressBar;
  Task: TTarefaParalela;
  Ouvinte: TOuvinte;
  i: Integer;
  Ordenado: Boolean;
begin
  { Teste 1: thread criada suspensa nao executa antes de Resume }
  ZeraRegistros;
  Barra := TProgressBar.Create;
  Ouvinte := TOuvinte.Create;
  Task := TTarefaParalela.Create(Barra);
  Task.OnTerminate := Ouvinte.AoTerminar;
  Sleep(60);
  Verifica(Length(AtualizacoesPosition) = 0, 'Create(True) nao executa antes de Start');
  Task.Resume;

  { Teste 2: execucao completa }
  Verifica(EsperaTermino(Ouvinte, 10000),
    'thread termina dentro do tempo limite');
  Verifica(Length(AtualizacoesPosition) = 100, 'recebe 100 atualizacoes');
  Ordenado := True;
  for i := 0 to High(AtualizacoesPosition) do
    if AtualizacoesPosition[i] <> i + 1 then
      Ordenado := False;
  Verifica(Ordenado, 'valores vao de 1 a 100 em ordem');
  Verifica(AtualizacoesForaDaPrincipal = 0, 'nenhuma atualizacao da VCL fora da thread principal');
  Verifica(Barra.Position = 100, 'barra termina em 100');
  Barra.Free;

  { Teste 3: Terminate interrompe a tarefa no meio }
  ZeraRegistros;
  Barra := TProgressBar.Create;
  Ouvinte.Terminou := False;
  Task := TTarefaParalela.Create(Barra);
  Task.OnTerminate := Ouvinte.AoTerminar;
  Task.Resume;
  EsperaAtualizacoes(10, 5000);
  Task.Terminate;
  Verifica(EsperaTermino(Ouvinte, 5000),
    'tarefa interrompida termina e dispara OnTerminate');
  Verifica((Length(AtualizacoesPosition) >= 10) and (Length(AtualizacoesPosition) < 100),
    'Terminate para a tarefa antes de chegar em 100');
  Barra.Free;

  Ouvinte.Free;
  WriteLn;
  WriteLn(Format('Resultado: %d aprovados, %d falhas', [Aprovados, Falhas]));
  if Falhas > 0 then
    Halt(1);
end.
