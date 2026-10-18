{ Substituto mínimo de Winapi.Windows para compilar a thread com FPC nos testes }
unit Winapi.Windows;

{$mode delphi}{$H+}

interface

procedure Sleep(Milliseconds: Cardinal);

implementation

uses
  SysUtils;

procedure Sleep(Milliseconds: Cardinal);
begin
  SysUtils.Sleep(Milliseconds);
end;

end.
