
# Fetches SNR & FEC data via SNMP


This script has been written to read Forward Error Correction and Signal-To-Noise Ratio data, at given time intervals, for upstream channels in the Cisco CBR8 platform. It does so based on the following OIDs:

docsIfSigQUnerroreds	.1.3.6.1.2.1.10.127.1.1.4.1.2
	Codewords received on this channel without error.
 	This includes all codewords, whether or not they
 	were part of frames destined for this device.

docsIfSigQCorrecteds	.1.3.6.1.2.1.10.127.1.1.4.1.3
	Codewords received on this channel with correctable
 	errors. This includes all codewords, whether or not
 	they were part of frames destined for this device.

docsIfSigQUncorrectables  	.1.3.6.1.2.1.10.127.1.1.4.1.4
	Codewords received on this channel with uncorrectable
 	errors. This includes all codewords, whether or not
 	they were part of frames destined for this device.

docsIfSigQSignalNoise	.1.3.6.1.2.1.10.127.1.1.4.1.5
	Signal/Noise ratio as perceived for this channel.
 	At the CM, describes the Signal/Noise of the downstream
 	channel.  At the CMTS, describes the average Signal/Noise
 	of the upstream channel.

It is necessary to have net-snmp package since the script invokes snmpwalk command.

How to use it:

1) Clone the following from github: 
https://github.com/apinelli/cbr8_snr

2) Use `#show snmp mib ifmib ifindex` in the CBR8 in order to obtain the indexes of the interfaces you want to grab information from. For example, if you want to grab statistics from your modem 0025.2eab.84a6 first identify to which interface it belongs:
```
CBR8#show cable modem 0025.2eab.84a6
Load for five secs: 5%/0%; one minute: 5%; five minutes: 7%
Time source is NTP, 17:42:11.137 EDT Mon May 2 2022
                                                                                       D
MAC Address    IP Address      I/F           MAC               Prim  RxPwr  Timing Num I
                                             State             Sid   (dBmV) Offset CPE P
0025.2eab.84a6 25.25.25.16     C1/0/0/UB     w-online(pt)      1    *7.00   3358   0   N
```
Now check the upstreams associated to this mac-domain (C1/0/0):
```
F241-38-5-CBR8-2#sh run int cable 1/0/0
Load for five secs: 5%/0%; one minute: 6%; five minutes: 7%
Time source is NTP, 17:41:08.836 EDT Mon May 2 2022

Building configuration...

Current configuration : 738 bytes
!
interface Cable1/0/0
 description F241.38.5-DIPLEX FILTER 1 (temp Maxnet II diplex)
 load-interval 30
 downstream Integrated-Cable 1/0/0 rf-channel 0-31
 upstream 0 Upstream-Cable 1/0/0 us-channel 0
 upstream 1 Upstream-Cable 1/0/0 us-channel 1
 upstream 2 Upstream-Cable 1/0/0 us-channel 2
 upstream 3 Upstream-Cable 1/0/0 us-channel 3
<snip>
```
From the output above you can see the upstreams associated to interface Cable 1/0/0. Now you can run the command to check what are the indexes of those upstream channels:
```
F241-38-5-CBR8-2#show snmp mib ifmib ifindex
Load for five secs: 6%/0%; one minute: 9%; five minutes: 9%
Time source is NTP, 17:37:34.657 EDT Mon May 2 2022
<snip>
Cable1/0/0-upstream0: Ifindex = 488040
Cable1/0/0-upstream1: Ifindex = 488041
Cable1/0/0-upstream2: Ifindex = 488042
Cable1/0/0-upstream3: Ifindex = 488043
```

3) Modify the `ifindex.txt` file to include those indexes. Each line of the file must contain one index.

Example: 488091.txt:
```
488040
488041
488042
488043
```
4) Run the script:
```
./snmp.sh
```
Make sure you give the correct IP address for the CMTS you want to obtain the data from. Also provide the SNMP community, interval for each polling and number of times the device will be polled.

5) The result will be one txt file per interface you specified in the `ifindex.txt` file. The files will be named with the corresponding ifindex and will have the following contents:
```
[Time (HH:MM)],[Nb of cw without error],[Nb of cw corrected],[Nb of cw uncorrected],[SNR]
```
Example:
```
18:22,149994,0,448,421
18:22,149995,0,448,421
18:22,149996,0,448,421
18:23,149996,0,448,421
```

6) The file `fec_snr.bas` can be imported to Excel in order to facilitate producing the charts:

1) From Excel main menu go to Developer
2) Click the option "Visual Basic"
3) From the Visual Basic menu go to File > Import File and select `fec_snr.bas`
4) Two macros will be available:
   - Open_txt_SNRFEC (which opens the text files generated by the script)
   - Generates_SNRFEC_graphs (which generates the charts for FEC and SNR for each upstream channel)
5) The end result is as follows:

![Chart Example](pic_sample_for_md_readme.JPG)



   
