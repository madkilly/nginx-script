#!/bin/bash

count=0
max=3
flag=0
DATE1=`date +%s%N|cut -c1-13`
function lvstest(){
while [ $count -eq 0 ]
do
	httpstat=$(curl -i -s  http://20.12.6.205|grep HTTP/1.1|awk  '{print $2}');
	if [ "$httpstat" != "200" ] 
	then

	  echo "error";
	  DATE1=`date +%s%N|cut -c1-13`
	  while [ $count -eq 0 ]
	  do
	    httpstat=$(curl -i -s  http://20.12.6.205|grep HTTP/1.1|awk  '{print $2}');
	    if [ "$httpstat" == "200" ] 
	    then
		break 2;	
	    fi
	  done
	fi	
done
}
echo "start"
lvstest;
DATE2=`date +%s%N|cut -c1-13`
echo "Running time:: $((${DATE2}-${DATE1}))ms"
echo "end"
