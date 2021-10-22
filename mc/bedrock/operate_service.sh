#!/bin/bash

USERNAME='yzy'
BIN_PATH='/opt/mc-bedrock/1.16.40.02'
BOOT_FILE='startup.sh'
NAME='Minecraft-Bedrock'
LOG="$BIN_PATH/logs/record_status.log"

WAITING_TIME=5

ME=`whoami`


if [ $ME != $USERNAME ] ; then
	echo "Please run the $USERNAME user."
	exit
fi

direct() {
	cd $BIN_PATH
	$BIN_PATH/$BOOT_FILE
}

start() {
	if pgrep -u $USERNAME -f $NAME > /dev/null ; then
		echo "$NAME is already running"
		exit
	fi

	echo "Starting $NAME..."

	cd $BIN_PATH
	screen -AmdS $NAME $BIN_PATH/$BOOT_FILE

	echo $(date +%Y/%m/%d-%H:%M)_Start $NAME >> $LOG
	exit
}

stop() {
	if pgrep -u $USERNAME -f $NAME > /dev/null ; then
		echo "$NAME stopped"
	else
		echo "$NAME is not running"
		exit
	fi

	#screen -S $NAME -X quit
	screen -S $NAME -X eval 'stuff "stop"\015'

	echo $(date +%Y/%m/%d-%H:%M)_Stop $NAME >> $LOG
	exit
}

restart() {
	if pgrep -u $USERNAME -f $NAME > /dev/null ; then
		#screen -S $NAME -X quit
		screen -S $NAME -X eval 'stuff "stop"\015'
	fi

	echo "Please wait $WAITING_TIME seconds for restarting"
	sleep $WAITING_TIME

	cd $BIN_PATH
	screen -AmdS $NAME $BIN_PATH/$BOOT_FILE
	echo "$NAME restarted"

	echo $(date +%Y/%m/%d-%H:%M)_Restart $NAME >> $LOG
	exit
}

status() {
	if pgrep -u $USERNAME -f $NAME > /dev/null ; then
		echo "$NAME is already running"
		exit
	else
		echo "$NAME is not running"
		exit
	fi
}

cleanItem() {
	if pgrep -u $USERNAME -f $NAME > /dev/null ; then
		screen -S $NAME -X eval 'stuff "say Will clean up the fallen objects"\015'
		sleep $WAITING_TIME
		screen -S $NAME -X eval 'stuff "kill @e[type=minecraft:item]"\015'
	fi
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		restart
		;;
	status)
		status
		;;
	direct)
		direct
		;;
	cleanItem)
		cleanItem
		;;
	*)
		echo "Usage: $0 [start/stop/restart/status/direct/cleanItem]"
esac
