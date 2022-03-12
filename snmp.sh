#!/bin/bash

echo
echo
echo "This script does an snmpwalk on the following OIDs"
echo
echo "docsIfSigQUnerroreds .1.3.6.1.2.1.10.127.1.1.4.1.2 Codewords received on this channel without error."
echo "docsIfSigQCorrecteds .1.3.6.1.2.1.10.127.1.1.4.1.3 Codewords received on this channel with correctable errors."
echo "docsIfSigQUncorrectables .1.3.6.1.2.1.10.127.1.1.4.1.4 Codewords received on this channel with uncorrectable errors."
echo "docsIfSigQSignalNoise .1.3.6.1.2.1.10.127.1.1.4.1.5 Signal/Noise ratio as perceived for this channel."
echo
echo "Use the file ifindex.txt to put the ifindexes of the upstream interfaces you want to poll."
echo "Use '#show snmp mib ifmib ifindex' in the CBR8 in order to obtain the indexes of the interfaces."
echo "A file will be created for each index row in ifindex.txt."
echo
echo "Syntax: ./snmp.sh"
echo
read -p "IP address of the CBR8             : " IP
read -p "SNMP community                     : " SNMP
read -p "Polling interval in seconds        : " INTERV 
read -p "How many times you want to poll    : " TIMES
echo
echo "Polling CBR8 at $IP..."
echo

for i in {1..3}; do
   while read IFINDEX; do
     now=$(date +"%H:%M")
     UNERRORED=$(snmpwalk -v 2c -c $SNMP $IP .1.3.6.1.2.1.10.127.1.1.4.1.2.$IFINDEX)
     UNERRORED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.2.$IFINDEX = Counter32: /,/g" <<< "$UNERRORED")
     CORRECTED=$(snmpwalk -v 2c -c $SNMP $IP .1.3.6.1.2.1.10.127.1.1.4.1.3.$IFINDEX)
     CORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.3.$IFINDEX = Counter32: /,/g" <<< "$CORRECTED")
     UNCORRECTED=$(snmpwalk -v 2c -c $SNMP $IP .1.3.6.1.2.1.10.127.1.1.4.1.4.$IFINDEX)
     UNCORRECTED=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.4.$IFINDEX = Counter32: /,/g" <<< "$UNCORRECTED")
     SNR=$(snmpwalk -v 2c -c $SNMP $IP .1.3.6.1.2.1.10.127.1.1.4.1.5.$IFINDEX)
     SNR=$(sed "s/SNMPv2-SMI::transmission.127.1.1.4.1.5.$IFINDEX = INTEGER: /,/g" <<< "$SNR")
     (echo $now$UNERRORED$CORRECTED$UNCORRECTED$SNR) >> $PWD/$IFINDEX.txt
   done < $PWD/ifindex.txt
   sleep $INTERV
done
