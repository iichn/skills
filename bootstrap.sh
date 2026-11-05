#!/usr/bin/env bash
# Использование: ./bootstrap.sh /путь/к/проекту
# Копирует скелет в проект. Существующие файлы не перезаписывает.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DST="${1:?Укажите путь к проекту: ./bootstrap.sh /путь/к/проекту}"

copy_safe() {  # copy_safe <from> <to>
  if [ -e "$2" ]; then
    echo "пропущено (уже есть): ${2#$DST/}"
  else
    mkdir -p "$(dirname "$2")"
    cp "$1" "$2"
  fi
}

mkdir -p "$DST"
(cd "$SRC/skeleton" && find . -type f) | while read -r f; do
  copy_safe "$SRC/skeleton/$f" "$DST/$f"
done

copy_safe "$SRC/roles/04-agent-executor.md" "$DST/AGENTS.md"
copy_safe "$SRC/roles/04-agent-executor.md" "$DST/.github/copilot-instructions.md"

echo "Готово: $DST"
echo "Дальше: заполни docs/PLAN.md и блок «Проект» в AGENTS.md и .github/copilot-instructions.md"
echo "Затем вставь roles/02 в Bridge и roles/03 в Routine."
