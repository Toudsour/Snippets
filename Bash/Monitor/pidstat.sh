#!/bin/bash

interval=5

io_log='io_log'
cpu_log='cpu_log'
mem_log='mem_log'

pid=""

function exit_handler() {
   ps ax | grep pidstat | awk '{print $1}' | xargs kill
}

if [ "$pid" != "" ]
then
    pid_param="-p $pid"
fi

trap 'exit_handler' EXIT

pidstat -td $pid_param $interval 2>&1 >$io_log &
pidstat -r $pid_param $interval 2>&1 >$mem_log &
pidstat -t $pid_param $interval 2>&1 >$cpu_log &

time=0

while [ 1 ]
do
    let time=time+$interval
    sleep $interval
    echo -en "It's been recorded for $time seconds\r"

done
