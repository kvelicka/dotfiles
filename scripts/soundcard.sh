#!/bin/bash

set -e errexit

A2DJ_SINK=$(pactl list sinks| grep -e 'DJ' -B 2 | head -n 1 | cut -d'#' -f 2)
echo $A2DJ_SINK
pactl set-default-sink $A2DJ_SINK
