temp="$(nvidia-smi -q -d temperature | awk 'NR==11{print $5}')"
temp1=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000)) 

echo  "GPU $temp°C " "CPU $temp1°C "

