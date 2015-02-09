#!/bin/bash

HEART='♥'
TRIFORCE_PART='▲ '
NUM_HEARTS=10

# Zenburn colors
GOLD='#[fg=colour223]'
RED='#[fg=colour174]'
GRAY='#[fg=colour248]'

if [[ `uname` == 'Linux' ]]; then
  current_charge=$(cat /sys/class/power_supply/BAT0/energy_now)
  total_charge=$(cat /sys/class/power_supply/BAT0/energy_full)
  charging=$(cat /sys/class/power_supply/ADP1/online)
elif [[ `uname` == 'Darwin' ]]; then
  current_charge=$(ioreg -l | grep -i CurrentCapacity | awk '{print $5}')
  total_charge=$(ioreg -l | grep -i MaxCapacity | awk '{print $5}')
  connected=$(pmset -g ps | head -1 | grep "AC")
  [[ -z $connected ]] && charging='1' || charging=''
fi

charged_slots=$(echo "(($current_charge/$total_charge)*$NUM_HEARTS)+1" |
bc -l | cut -d '.' -f 1)

if [[ $charged_slots -gt $NUM_HEARTS ]]; then
  charged_slots=$NUM_HEARTS
fi

if [[ $charged_slots == $NUM_HEARTS ]]; then
  echo -n $GOLD
  echo -n "$TRIFORCE_PART"
else
  if [[ $charging == '' ]]; then
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
