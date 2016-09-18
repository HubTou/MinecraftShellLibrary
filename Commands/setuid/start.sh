#!/bin/sh

. .server-settings

cd ${SERVER_ROOT}
screen -S ${GNUSCREEN_SESSION} -t ${GNUSCREEN_WINDOW} -dm setuid/startbukkit.sh
