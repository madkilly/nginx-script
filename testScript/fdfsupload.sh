#!/bin/bash

count=0
max=100
while [ $count -lt $max ]
do
	let "count = $count + 1"
	echo $count
	fdfs_upload_file /etc/fdfs/client.conf /liujmshare/zhu.JPG
	sleep 1
done
