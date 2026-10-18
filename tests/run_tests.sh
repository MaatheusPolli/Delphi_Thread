#!/usr/bin/env bash
# Compila e roda os testes da thread com Free Pascal (FPC 3.2+).
# Uso: tests/run_tests.sh   (a partir da raiz do projeto)
set -euo pipefail

raiz="$(cd "$(dirname "$0")/.." && pwd)"
build="$(mktemp -d)"
trap 'rm -rf "$build" 2>/dev/null || true' EXIT

# A unit real é compilada sem alterações; os nomes Delphi (Winapi.*, System.*, Vcl.*) vêm de tests/shim.
for f in "$raiz"/tests/shim/*.pas; do cp "$f" "$build/"; done
cp "$raiz/un_tarefaParalela.pas" "$build/"
cp "$raiz/tests/test_tarefa.pas" "$build/"

cd "$build"
fpc -Mdelphi -Sh -Fu. -FE. -FU. test_tarefa.pas
./test_tarefa
