#!/bin/sh

. .server-settings

PATH=${JAVA_PATH}:${PATH}

java -Xms${SERVER_MINRAM} -Xmx${SERVER_MAXRAM} ${JAVA_OPTS} -jar ${SERVER_NAME} nogui --log-strip-color
