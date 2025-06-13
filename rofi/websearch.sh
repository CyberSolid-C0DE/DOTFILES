#!/bin/bash

echo -en "\x00prompt\x1f WebSearch\n"

engine="https://duckduckgo.com/?q="

query="$1"

if [[ -z "$query" ]]; then
  echo -en "Suchbegriff!"
  exit 1
fi

# URL-encode mit Python
encoded_query=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$query")

url="$engine$encoded_query"

xdg-open "$url"
