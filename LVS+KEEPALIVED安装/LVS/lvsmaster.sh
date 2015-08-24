#!/bin/sh
# description: Start LVS of Director server
./etc/rc.d/init.d/functions
VIP=20.12.6.205
RIP1=20.12.6.49
RIP2=20.12.6.52
case "$1" in
    start)
        echo " start LVS of Director Server"
#Clear IPVS table
       /sbin/ipvsadm -C
#set LVS
/sbin/ipvsadm -A -t $VIP:80 -s rr -p 600
/sbin/ipvsadm -a -t $VIP:80 -r $RIP1:80 -g
/sbin/ipvsadm -a -t $VIP:80 -r $RIP2:80 -g
#Run LVS
		;;
    stop)
        /sbin/ipvsadm -C
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac