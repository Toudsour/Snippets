#!/bin/bash

function exit_signal_handler() {
   ps ax | grep pidstat | awk -F '{print $1}' | xargs kill 
}

pidstat -td
