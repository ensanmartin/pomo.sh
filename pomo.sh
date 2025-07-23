#!/bin/bash

to_seconds() {
	local INPUT_MINUTES=$1
	local INPUT_SECONDS=$((INPUT_MINUTES*60))
	
	echo $INPUT_SECONDS
}

count() {
	local MIN=$1
	local SECONDS=$(to_seconds MIN)

	#echo $MIN
	#echo $SECONDS

	ITERATOR=0
	CURR_MIN=0
	CURR_SEC=0

	while [ $ITERATOR -le $SECONDS ]; do
		if [ $CURR_SEC -ge 60 ]; then
			((CURR_MIN++))
			CURR_SEC=0
		fi

		if [ $CURR_SEC -lt 10 ]; then
			printf "\r$CURR_MIN:0$CURR_SEC"
		else
			printf "\r$CURR_MIN:$CURR_SEC"
		fi
		
		((ITERATOR++))
		((CURR_SEC++))
		sleep 0.1
		#sleep 1
	done

	printf "\n"
}

pomodoro() {
	local POMO=$1
	local REST=$2
	local LONG_REST=$3
	local INTERVAL=$4

	echo "Welcome to a $POMO/$REST/$LONG_REST/$INTERVAL pomodoro."
	
	for (( i=1;i<=$INTERVAL;i++ )); do
		echo "FOCUS! [$i/$INTERVAL]"
		count $POMO

	done

	echo "REST!"
	count $REST
}

POMO=$1
REST=$2
LONG_REST=$3
INTERVAL=$4

pomodoro $POMO $REST $LONG_REST $INTERVAL
#count $POMO
