#!/bin/bash

#if [ $1 == "-t"] || [ $1 == "--task" ]; then
#  echo "the task is $2"
#else
#  echo "Error while specifying the task..."
#fi
#
#if [ $3 == "-pt"] || [ $3 == "--pomodoro-time" ]; then
#  echo "the pomodoro time is $4"
#fi
#
#if [ $5 == "-r"] || [ $5 == "--rest" ]; then
#  echo "the rest time is $6"
#fi
#
LOW_VOLUME=0.2

# $0 - DELAY
# $1 - LOW_VOLUME
# $2 - SOUND_PATH
# $3 - NOTIFICATION
execute-notification () {
  sleep $0 &&
    CURRENT_VOLUME=$(osascript -e 'set ovol to output volume of (get volume settings)') &&
    osascript -e "set volume output volume $1" &&
    sleep 0.5 &&
    afplay --volume 3 $2 &&
    sleep 0.5 &&
    osascript -e "set volume output volume $CURRENT_VOLUME" &&
    osascript -e 'display notification '$3' with title "Pomoshell"'
}

echo "Starting pomodoro..."

START=$(date "+%HH:%MM")

SOUND_PATH="./TP_Get_Heart.wav"
DELAY=15
execute-notification $WORK_TIME $LOW_VOLUME "./TP_Get_Heart.wav" ""

echo "Starting rest phase... :)"

SOUND_PATH="./TP_Get_Rupee.wav"
DELAY=15
execute-notification

echo "Pomodoro ended..."

END=$(date "+%HH:%MM")
echo "Period: $START-$END -> task: $1" >> $HOME/.pomoshell.log
