#!/usr/bin/env bash
echo -en "\x00prompt\x1f  Waybar Themes\n"

# Statische Liste (du kannst auch dynamisch machen, siehe unten)
THEMES=("chef" "frappe" "latte" "macchiato" "mocha")

if [[ -z "$1" ]]; then
  # Keine Auswahl übergeben – gib Theme-Liste aus (für Rofi)
  for theme in "${THEMES[@]}"; do
    echo "$theme"
  done
else
  # Theme wurde übergeben – führe Wechsel aus
  ~/.config/waybar-scripts/theme-switcher.sh "$1"
fi
