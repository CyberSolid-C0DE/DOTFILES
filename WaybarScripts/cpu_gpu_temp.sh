temp="$(nvidia-smi -q -d temperature | awk 'NR==11{print $5}')"
temp1=$(sensors | grep -m 1 'Tctl:' | awk '{gsub(/\+/, "", $2); printf("%d°C", $2)}')

echo "CPU $temp1 " "GPU $temp°C "
