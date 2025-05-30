#!/bin/bash

# CPU-Auslastung (%)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf "%.0f", 100 - $1}')
cpu_usage=$(printf "%.0f" "$cpu_usage")

# CPU-Tempe
# ratur
cpu_temp=$(sensors | grep -m 1 'Tctl:' | awk '{gsub(/\+/, "", $2); printf("%d°C", $2)}')
cpu_temp="${cpu_temp:-N/A}"

# GPU-Auslastung & Temperatur
if command -v nvidia-smi &>/dev/null; then
  gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n1 | tr -d ' %')
  gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | head -n1)
else
  gpu_usage="N/A"
  gpu_temp="N/A"
fi

# RAM-Auslastung
mem_usage=$(free | awk '/Mem:/ { printf("%.0f", $3/$2 * 100) }')

# Pango-Markup mit Farben direkt im Echo
echo "<span foreground='#cba6f7'>  </span> ${cpu_usage}% <span foreground='#f38ba8'></span> ${cpu_temp} | <span foreground='#89b4fa'></span> ${gpu_usage}% <span foreground='#f38ba8'></span> ${gpu_temp}°C | <span foreground='#f9e2af'></span> ${mem_usage}%"
