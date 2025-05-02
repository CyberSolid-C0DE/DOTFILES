#!/bin/bash

API_KEY=$(<~/.config/waybar-scripts/alphavatageapikey.txt) # <-- Ersetze durch deinen Alpha Vantage API Key
SYMBOL="NVDA"

# Aktuellen Kurs in USD abrufen
response=$(curl -s "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$SYMBOL&apikey=$API_KEY")
price_usd=$(echo "$response" | jq -r '.["Global Quote"]["05. price"]')

# Ausgabe formatieren
if [[ -n "$price_usd" && "$price_usd" != "null" ]]; then
  printf "NVIDIA: \$%.2f\n" "$price_usd"
else
  echo "NVIDIA: N/A"
fi
