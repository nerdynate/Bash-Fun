#!/bin/bash

FOLDER=/home/nate/.purple/logs
DATE=`date +%Y%m%d`
LOGS=logs.${DATE}.tar.gz

tar -cvzf /tmp/${LOGS} ${FOLDER} 
scp -P 2200 /tmp/${LOGS} nate@rudedwarf.net:/home/nate/logs/
rm /tmp/${LOGS}
