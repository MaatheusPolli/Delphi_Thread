{ Ponte para SyncObjs no FPC, mantendo o nome Delphi nos testes }
unit System.SyncObjs;

{$mode delphi}{$H+}

interface

uses
  SyncObjs;

type
  TCriticalSection = SyncObjs.TCriticalSection;

implementation

end.
