#!/bin/bash

updates=$(checkupdates | grep -c '.*')

[ "$updates" -gt 0 ] && output="$output  $updates"

echo "$output"
