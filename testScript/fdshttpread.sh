#!/bin/bash

count=0
max=100
while [ $count -lt $max ]
do
	let "count = $count + 1"
	echo $count
	curl -H 'Connection:close'  http://20.12.6.91/g1/M00/00/00/FAwGK1W1mGiAEszZAAD5B24UP-0941.jpg >$- 2>$-
	sleep 1
done
