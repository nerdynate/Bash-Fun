#!/bin/bash

# APMPM - Advanced Poor Man Power Management
# Script to see power management status of USB devices
# by LuisManson - 08/10/08

declare -a ARRAYDEV
declare -a ARRAYPROD
declare -a ARRAYPWRSTATUS
let nprod=0

# funcion para consultar power/level
function query_level {
# level: on - auto - suspend

if [ -e $1/power/level ]; then
ARRAYPWRSTATUS[$nprod]=$(cat $devhome/power/level)
else if [ ! -e $devhome/power/level ]; then
ARRAYPWRSTATUS[$nprod]=NA
fi
fi
}


for idVendor in $(ls /sys/bus/usb/devices/*/idVendor); do
devhome=$(dirname $idVendor)
devlevel=$devhome/power/level

# if product, leo, else leo idvendor e idproduct
if [ -e $devhome/product ]; then
    ARRAYPROD[$nprod]="$devhome"
    ARRAYPRODDESC[$nprod]="$(cat $devhome/product)"
    query_level $devhome
    ((nprod++))
else if [ -e $devhome/idVendor ]; then
    ARRAYPROD[$nprod]="$devhome"
    ARRAYPRODDESC[$nprod]="$(cat $devhome/idVendor):$(cat $devhome/idProduct)"
    query_level $devhome
    ((nprod++))
fi
fi

done

echo -e "Description:\n"
echo -e "\tOn: Device ALLWAYS on"
echo -e "\tauto: managed by the kernel"
echo -e "\tsuspend: Device is suspended and autoresume is not allowed\n"



for element in $(seq 0 $((${#ARRAYPROD[@]} -1)))
  do
    echo -e "${ARRAYPROD[$element]}"\\n \\t "${ARRAYPRODDESC[$element]}"\\n \
    \\t Power status: ${ARRAYPWRSTATUS[$element]} \\n
done
