#!/bin/bash

HEART='♥'
TRIFORCE_PART='▲'
NUM_HEARTS=10

# Zenburn colors
#GOLD='#[fg=colour223]'
#RED='#[fg=colour174]'
#GRAY='#[fg=colour248]'

# Solarize colors
GOLD='#[fg=colour223]'
RED='#red'
GRAY='#gray'


if [[ `uname` == 'Linux' ]]; then
  current_charge=$(cat /sys/class/power_supply/BAT0/energy_now)
  total_charge=$(cat /sys/class/power_supply/BAT0/energy_full)
  charging=$(cat /sys/class/power_supply/ADP1/online)
fi

charged_slots=$(echo "(($current_charge/$total_charge)*$NUM_HEARTS)+1" |
  bc -l | cut -d '.' -f 1)

if [[ $charged_slots -gt $NUM_HEARTS ]]; then
  charged_slots=$NUM_HEARTS
fi

echo -n $GOLD
if [[ $charging == '' ]]; then
  echo -n "$TRIFORCE_PART"
  exit
fi
if [[ $charged_slots == $NUM_HEARTS ]]; then
  echo -n "$TRIFORCE_PART"
else
  if [[ $charging == 1 ]]; then
    echo -n $GOLD
  else
    echo -n $RED
  fi
  for i in `seq 1 $charged_slots`; do
    echo -n "$HEART"
  done
  if [[ $charged_slots -lt $NUM_HEARTS ]]; then
    echo -n $GRAY
    for i in `seq $charged_slots $NUM_HEARTS`; do
      echo -n "$HEART"
    done
  fi
fi
