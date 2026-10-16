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

## Ponto de atenção

Hoje a thread altera `FProgressBar.Position` direto dentro de `Execute`. Componentes VCL devem ser atualizados só pela thread principal, com `TThread.Queue` ou `TThread.Synchronize`.

## Como rodar

Abra `Thread.dproj` no Delphi (10.x ou mais novo) e execute (F9).

## Licença

Este projeto usa **licença dupla**. O texto completo está em [LICENSE](LICENSE).

- **Uso pessoal, educacional e não comercial:** livre, nos termos da licença MIT (mantenha o aviso de copyright).
- **Uso comercial:** exige licença comercial. Isso inclui usar em produto ou serviço comercial, vender acesso ou derivados, usar em atividades com fins lucrativos e implantar em empresas.

Contato para licença comercial: ma.polli@hotmail.com
