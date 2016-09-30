#!/bin/sh

. .minecraft-library

if [ -f ${NO_RESTART_FILE} ]
then	echo "The ${NO_RESTART_FILE} file exists. Remove it if you really want to start."
else	if IsServerLoaded
	then	echo "The server is already loaded!"
	else	screen -S ${GNUSCREEN_SESSION} -t ${GNUSCREEN_WINDOW} -dm Scripts/setuid/startbukkit.sh
	fi
fi
