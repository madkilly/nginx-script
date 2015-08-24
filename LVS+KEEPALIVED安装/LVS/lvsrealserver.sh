#!/bin/bash
#description : Start Real Server 
./etc/rc.d/init.d/functions
VIP=20.12.6.205
case "$1" in
    start)
        echo " Start LVS  of  Real Server"
 /sbin/ifconfig lo:0 $VIP broadcast $VIP netmask 255.255.255.255 up
 /sbin/route add -host $VIP dev lo:0
        echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
        echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
        echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
        echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce 
        ;;
    stop)
        /sbin/ifconfig lo:0 down
		/sbin/route del $VIP >/dev/null 2>&1
        echo "close LVS Director server"
        echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
        echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
        echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
        echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
		echo "RealServer Stop"
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac