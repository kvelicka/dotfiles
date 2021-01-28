#!/bin/bash
set -e errexit

pactl list sinks | rg -e '^Sink ' -e 'Name: ' | fzf --tac | cut -d# -f2 | xargs --no-run-if-empty pactl set-default-sink
