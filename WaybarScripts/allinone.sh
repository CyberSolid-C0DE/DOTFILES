#!/bin/bash

# CPU-Auslastung (%)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
cpu_usage=$(printf "%.0f" "$cpu_usage")

# CPU-Temperatur (erste gefundene)
cpu_temp=$(sensors | grep -m 1 -E 'Package id 0|Tdie|temp1' | awk '{print $2}' | tr -d '+°C')
cpu_temp="${cpu_temp:-N/A}"

# GPU-Auslastung & Temperatur (nur wenn NVIDIA vorhanden)
if command -v nvidia-smi &>/dev/null; then
  gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n1 | tr -d ' %')
  gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | head -n1)
else
  gpu_usage="N/A"
  gpu_temp="N/A"
fi

# RAM-Auslastung (%)
mem_usage=$(free | awk '/Mem:/ { printf("%.0f", $3/$2 * 100) }')

# Anzeige mit Icons
#  CPU,  GPU,  RAM,  Temperatur
echo "  ${cpu_usage} %  ${cpu_temp}°C |   ${gpu_usage}%  ${gpu_temp}°C |  ${mem_usage}%"
