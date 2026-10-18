{ Ponte para Classes no FPC, mantendo o nome Delphi nos testes }
unit System.Classes;

{$mode delphi}{$H+}

interface

uses
  Classes;

type
  TThread = Classes.TThread;
  TThreadPriority = Classes.TThreadPriority;

const
  tpNormal = Classes.tpNormal;

implementation

end.
