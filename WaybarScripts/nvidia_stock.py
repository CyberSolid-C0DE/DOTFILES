#!/usr/bin/env python3
import urllib.request
import csv
import io
import sys

def fetch_nvda_close():
    # Stooq-CSV-Endpoint für NVDA (US-Ticker .us)
    url = "https://stooq.com/q/l/?s=nvda.us&f=sd2t2ohlcv&h&e=csv"
    try:
        with urllib.request.urlopen(url, timeout=5) as resp:
            data = resp.read().decode('utf-8')
    except Exception:
        return None

    # CSV parsen
    reader = csv.reader(io.StringIO(data))
    rows = list(reader)
    if len(rows) < 2:
        return None

    # Header ist rows[0], Daten in rows[1]; Spalte 6 (0-basiert) = CLOSE
    close = rows[1][6].strip()
    if not close or close.upper() == "N/D":
        return None
    return close

def main():
    price = fetch_nvda_close()
    if price:
        # Ausgabe für Waybar
        print(f" NVIDIA: ${price}")
        sys.exit(0)
    else:
        print(" NVIDIA: N/A")
        sys.exit(1)

if __name__ == "__main__":
    main()
