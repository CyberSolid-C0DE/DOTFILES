#!/bin/bash

# Eine Liste von möglichen Shortcuts mit Beschreibungen
shortcuts=(
  ##NAVIGATION
  "Zum Anfang der Zeile: 0"
  "Zum Ende der Zeile: $"

  ##REPLACE
  "Ersetzt ein Zeichen unter dem Cursor: r"
  "Replace Mode: R"
  "Find and replace: :%s/{old}/{new}/g"
  "Replace in a specific range: :{range}s/{old}/{new}/g"
  "Search and replace interactively: :%s/{old}/{new}/c"

  ##DELETE
  "Löscht ein Zeichen unter dem Cursor: x"

  ##MACROS
  "Record a macro: q{letter from a-z}"
  "Playback a macro: @{letter from a-z}"

  ##UNDO AND REDO
  "Undo last action: u"
  "Redo last undone action: Ctrl-r"

  ##VISUAL MODE
  "Start visual mode: v"
  "Start linewise visual mode: V"
  "Start blockwise visual mode: Ctrl-v"

  ##CUT AND PASTE
  "Cut selected text (delete): d"
  "Copy selected text: y"
  "Paste: p"
  "Delete to end of line: D"
)

echo -en "\x00prompt\x1f Shortcuts\n"
# Zeige alle Shortcuts mit Beschreibungen an
for shortcut in "${shortcuts[@]}"; do
  echo "$shortcut"
done
