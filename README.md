# Delphi_Thread — Exemplo de TThread com barra de progresso

Exemplo simples, de 2021, de uso de `TThread` em Delphi (VCL). Uma tarefa paralela (`TTarefaParalela`) avança uma `TProgressBar` de 1 a 100 sem congelar a tela principal.

> Projeto de estudo.

## Arquivos

| Arquivo | Conteúdo |
|---------|----------|
| `Thread.dpr` / `Thread.dproj` | Projeto Delphi |
| `un_principal.pas/.dfm` | Formulário com as barras de progresso e o botão de início |
| `un_tarefaParalela.pas` | `TTarefaParalela = class(TThread)`: configuração (`ConfiguraTask`), `Execute`, `FreeOnTerminate` e `TCriticalSection` |

## Conceitos demonstrados

- Herdar de `TThread` e sobrescrever `Execute`.
- Prioridade (`tpNormal`), criação suspensa e `FreeOnTerminate`.
- Uso de `TCriticalSection` (`Acquire`/`Release`).

## Boas práticas aplicadas

- Componentes VCL são atualizados só pela thread principal: a thread chama `Synchronize(AtualizaBarra)` e nunca toca em `FProgressBar` dentro de `Execute`.
- A thread é criada suspensa (`Create(True)`) e iniciada com `Start`, sem o antigo `Suspend`/`Resume` que competia com a execução.
- `OnTerminate` avisa o formulário quando a tarefa termina; os botões ficam desabilitados enquanto houver tarefas rodando.

## Como rodar

Abra `Thread.dproj` no Delphi (10.x ou mais novo) e execute (F9).

## Testes

A unit `un_tarefaParalela.pas` é testada com Free Pascal, sem Delphi. Pastas `tests/shim/` trazem substitutos mínimos de `Winapi.Windows`, `Vcl.ComCtrls`, `System.Classes` e `System.SyncObjs`.

Com FPC 3.2+ instalado (Linux, ou Windows com `fpc` no PATH):

```bash
bash tests/run_tests.sh
```

Os testes cobrem: a thread criada suspensa não roda antes de iniciar, a barra chega a 100 em ordem, todas as atualizações da barra acontecem na thread principal, e `Terminate` interrompe a tarefa.

O formulário (`un_principal.pas`) depende da VCL e só é validado compilando no Delphi.

## CI

O workflow `.github/workflows/ci.yml` roda em todo push e pull request para `master`/`main`:

- **estrutura**: confere se cada `un_*.pas` está no `Thread.dpr` e se o `.dfm` existe.
- **testes-unitarios**: instala o FPC no Ubuntu e roda `tests/run_tests.sh`.
- **build-delphi**: compila `Thread.dpr` em Win32 e Win64 com o `dcc32`/`dcc64`. Roda só se a variável de repositório `DELPHI_RUNNER` for `true`, num runner self-hosted Windows com Delphi instalado e a variável `DELPHI_BDS` apontando para a pasta do RAD Studio (ex.: `C:\Program Files (x86)\Embarcadero\Studio\23.0`).

Para ativar o build Delphi: em *Settings → Actions → Runners*, registre um runner Windows com a label `delphi`, e em *Settings → Variables* crie `DELPHI_RUNNER=true` e `DELPHI_BDS=<caminho>`.

## Licença

Este projeto usa **licença dupla**. O texto completo está em [LICENSE](LICENSE).

- **Uso pessoal, educacional e não comercial:** livre, nos termos da licença MIT (mantenha o aviso de copyright).
- **Uso comercial:** exige licença comercial. Isso inclui usar em produto ou serviço comercial, vender acesso ou derivados, usar em atividades com fins lucrativos e implantar em empresas.

Contato para licença comercial: ma.polli@hotmail.com
