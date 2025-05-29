#!/bin/bash

# Alle verfügbaren Themes
VALID_THEMES=("chef" "frappe" "latte" "macchiato" "mocha")

# Theme-Pfad-Grundlage
THEME_DIR="$HOME/.config/waybar/themes"
TARGET_STYLE="$HOME/.config/waybar/style.css"

# Prüfen ob gültiger Name übergeben wurde
if [[ ! " ${VALID_THEMES[@]} " =~ " $1 " ]]; then
  echo "❌ Ungültiges Theme: '$1'"
  echo "➡️  Benutzung: $0 [${VALID_THEMES[*]}]"
  exit 1
fi

# Theme style.css kopieren (oder alternativ verlinken)
cp "$THEME_DIR/$1/style.css" "$TARGET_STYLE"
# Alternativ (Symlink statt Kopie):
# ln -sf "$THEME_DIR/$1/style.css" "$TARGET_STYLE"

# Waybar neustarten
pkill waybar && nohup waybar >/dev/null 2>&1 &
pkill rofi
echo "✅ Theme gewechselt zu: $1"
