#!/bin/bash

# CPU-Auslastung: Hole die Leerlaufzeit (idle) der CPU
CPU_IDLE=$(top -bn2 | grep "Cpu(s)" | tail -n1 | awk '{print int($8)}')
CPU_USAGE=$((100 - CPU_IDLE))

# JSON-Ausgabe für Waybar
echo "{\"text\": \"${CPU_USAGE} %\", \"tooltip\": \"Aktuelle CPU-Auslastung\"}"
