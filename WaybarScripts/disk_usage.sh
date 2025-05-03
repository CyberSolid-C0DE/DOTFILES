#!/bin/bash

# Funktion für JSON-sichere Ausgabe einer Partition
disk_info() {
  MOUNTPOINT="$1"
  ICON="$2"

  read -r size used avail use_percent <<<$(df -h "$MOUNTPOINT" 2>/dev/null | awk 'NR==2 {print $2, $3, $4, $5}')

  if [[ -z "$use_percent" ]]; then
    echo "$ICON N/A"
  else
    echo "$ICON $used/$size "
  fi
}

# Infos holen
root_info=$(disk_info "/" " ")
backup_info=$(disk_info "/mnt/ChefBackup" " ")

# Ausgabe im JSON-Format für Waybar
echo "{\"text\": \"$root_info | $backup_info\", \"tooltip\": \"System: /, Backup: /mnt/ChefBackuo\"}"
