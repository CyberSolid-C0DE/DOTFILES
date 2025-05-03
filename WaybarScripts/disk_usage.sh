#!/bin/bash

# Funktion für JSON-sichere Ausgabe einer Partition
disk_info() {
  MOUNTPOINT="$1"
  ICON="$2"
  COLOR="$3"

  read -r size used avail use_percent <<<$(df -h "$MOUNTPOINT" 2>/dev/null | awk 'NR==2 {print $2, $3, $4, $5}')

  ICON_COLORED="<span color='$COLOR'>$ICON</span>"

  if [[ -z "$use_percent" ]]; then
    echo "$ICON_COLORED N/A"
  else
    echo "$ICON_COLORED $used/$size"
  fi
}

# Infos holen mit farbigen Icons
root_info=$(disk_info "/" "" "#89b4fa")
backup_info=$(disk_info "/mnt/ChefBackup" "" "#a6e3a1")

# Ausgabe im JSON-Format für Waybar
echo "{\"text\": \"$root_info | $backup_info\", \"tooltip\": \"System: /, Backup: /mnt/ChefBackup\"}"
