program Thread;

uses
  Vcl.Forms,
  un_principal in 'un_principal.pas' {frm_principal},
  un_tarefaParalela in 'un_tarefaParalela.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.Run;
end.
