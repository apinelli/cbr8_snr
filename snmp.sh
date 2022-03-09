#!/bin/bash

echo "Starting script"

IP=$1;
SNMP_PWD=$2;

while read IFINDEX;
do
   now=$(date +"%H:%M")
   UNERRORED=$(snmpwalk -v 2c -c $SNMP_PWD $IP .1.3.6.1.2.1.10.127.1.1.4.1.2.$IFINDEX)
   UNERRORED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.2.$IFINDEX = Counter32: /,/g" <<< "$UNERRORED")
   CORRECTED=$(snmpwalk -v 2c -c $SNMP_PWD $IP .1.3.6.1.2.1.10.127.1.1.4.1.3.$IFINDEX)
   CORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.3.$IFINDEX = Counter32: /,/g" <<< "$CORRECTED")
   UNCORRECTED=$(snmpwalk -v 2c -c $SNMP_PWD $IP .1.3.6.1.2.1.10.127.1.1.4.1.4.$IFINDEX)
   UNCORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.4.$IFINDEX = Counter32: /,/g" <<< "$UNCORRECTED")
   SNR=$(snmpwalk -v 2c -c $SNMP_PWD $IP .1.3.6.1.2.1.10.127.1.1.4.1.5.$IFINDEX)
   SNR=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.5.$IFINDEX = INTEGER: /,/g" <<< "$SNR")
   (echo $now$UNERRORED$CORRECTED$UNCORRECTED$SNR) >> $PWD/$IFINDEX.txt

done < $PWD/ifindex.txt
