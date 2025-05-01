#!/bin/bash

# Lese Speicherinformationen aus /proc/meminfo
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
MEM_USED=$((MEM_TOTAL - MEM_AVAILABLE))

# Berechne RAM-Auslastung in %
MEM_USAGE=$(((100 * MEM_USED) / MEM_TOTAL))

# JSON-Ausgabe für Waybar
echo "{\"text\": \"${MEM_USAGE} %\", \"tooltip\": \"Arbeitsspeicher: ${MEM_USED} / ${MEM_TOTAL} kB benutzt\"}"
