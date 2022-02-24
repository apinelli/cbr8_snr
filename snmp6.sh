#!/bin/bash

echo "Starting script"

IP=$1;
IFINDEX1=$2;
IFINDEX2=$3;
IFINDEX3=$4;
IFINDEX4=$5;

while :
do
   now=$(date +"%H:%M")
   UNERRORED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.2.$IFINDEX1)
   UNERRORED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.2.$IFINDEX1 = Counter32: /,/g" <<< "$UNERRORED")
   CORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.3.$IFINDEX1)
   CORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.3.$IFINDEX1 = Counter32: /,/g" <<< "$CORRECTED")
   UNCORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.4.$IFINDEX1)
   UNCORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.4.$IFINDEX1 = Counter32: /,/g" <<< "$UNCORRECTED")
   SNR=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.5.$IFINDEX1)
   SNR=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.5.$IFINDEX1 = INTEGER: /,/g" <<< "$SNR")
   (echo $now$UNERRORED$CORRECTED$UNCORRECTED$SNR) >> $PWD/$IFINDEX1.txt

   UNERRORED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.2.$IFINDEX2)
   UNERRORED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.2.$IFINDEX2 = Counter32: /,/g" <<< "$UNERRORED")
   CORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.3.$IFINDEX2)
   CORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.3.$IFINDEX2 = Counter32: /,/g" <<< "$CORRECTED")
   UNCORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.4.$IFINDEX2)
   UNCORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.4.$IFINDEX2 = Counter32: /,/g" <<< "$UNCORRECTED")
   SNR=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.5.$IFINDEX2)
   SNR=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.5.$IFINDEX2 = INTEGER: /,/g" <<< "$SNR")
   (echo $now$UNERRORED$CORRECTED$UNCORRECTED$SNR) >> $PWD/$IFINDEX2.txt

   UNERRORED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.2.$IFINDEX3)
   UNERRORED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.2.$IFINDEX3 = Counter32: /,/g" <<< "$UNERRORED")
   CORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.3.$IFINDEX3)
   CORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.3.$IFINDEX3 = Counter32: /,/g" <<< "$CORRECTED")
   UNCORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.4.$IFINDEX3)
   UNCORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.4.$IFINDEX3 = Counter32: /,/g" <<< "$UNCORRECTED")
   SNR=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.5.$IFINDEX3)
   SNR=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.5.$IFINDEX3 = INTEGER: /,/g" <<< "$SNR")
   (echo $now$UNERRORED$CORRECTED$UNCORRECTED$SNR) >> $PWD/$IFINDEX3.txt

   UNERRORED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.2.$IFINDEX4)
   UNERRORED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.2.$IFINDEX4 = Counter32: /,/g" <<< "$UNERRORED")
   CORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.3.$IFINDEX4)
   CORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.3.$IFINDEX4 = Counter32: /,/g" <<< "$CORRECTED")
   UNCORRECTED=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.4.$IFINDEX4)
   UNCORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.4.$IFINDEX4 = Counter32: /,/g" <<< "$UNCORRECTED")
   SNR=$(snmpwalk -v 2c -c cisco123 $IP .1.3.6.1.2.1.10.127.1.1.4.1.5.$IFINDEX4)
   SNR=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.5.$IFINDEX4 = INTEGER: /,/g" <<< "$SNR")
   (echo $now$UNERRORED$CORRECTED$UNCORRECTED$SNR) >> $PWD/$IFINDEX4.txt

   sleep 10

done
