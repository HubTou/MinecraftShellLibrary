#!/bin/sh

. .server-settings

su -m ${SERVER_USER} -c 'setuid/start.sh'
