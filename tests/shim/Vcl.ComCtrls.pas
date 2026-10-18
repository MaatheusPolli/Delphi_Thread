{ Substituto mínimo de TProgressBar: registra cada atualização e a thread que a fez }
unit Vcl.ComCtrls;

{$mode delphi}{$H+}

interface

type
  TProgressBar = class
  private
    FPosition: Integer;
    procedure SetPosition(Value: Integer);
  public
    property Position: Integer read FPosition write SetPosition;
  end;

var
  { Valores recebidos em ordem }
  AtualizacoesPosition: array of Integer;
  { Quantas atualizações vieram de outra thread que não a principal }
  AtualizacoesForaDaPrincipal: Integer = 0;
  { Id da thread principal, capturado na inicializa��o da unit }
  IdThreadPrincipal: TThreadID;

implementation

uses
  SysUtils;

procedure TProgressBar.SetPosition(Value: Integer);
begin
  FPosition := Value;
  SetLength(AtualizacoesPosition, Length(AtualizacoesPosition) + 1);
  AtualizacoesPosition[High(AtualizacoesPosition)] := Value;
  if GetCurrentThreadId <> IdThreadPrincipal then
    Inc(AtualizacoesForaDaPrincipal);
end;

initialization
  IdThreadPrincipal := GetCurrentThreadId;

end.
