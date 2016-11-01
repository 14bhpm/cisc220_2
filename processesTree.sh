#!/bin/bash

# MAIN LIST WITH ALL INFORMATION
export var=()
mapfile -t var < <(ps axo comm,pid,ppid,user,start | grep -e '')



export incr=0
export numProcesses=${#var[*]}
export listPpid=()
mapfile -t listPpid < <(ps axo comm,pid,ppid,user,start | grep -e '' | awk '{print $3}')





#PRINTS INFO IN MAIN LIST



# ALGORITHM SO FAR
#1. Go through each pid and ppid in list
#2. if pid == (ppid) then it is a child
#3. if ppid == 1 then it is a child of systemd

function recurse {
((incr=$incr+1))
for (( i=1; i<numProcesses; i++ )); do
	if [[ ${listPpid[i]} -eq $1 ]]; then
		echo ${var[i]}
		echo var[i] | awk '{print $2}' && echo swag
		echo var[i] | awk '{print $2}' | recurse
	fi
done 
((incr=$incr-1))
}

echo $numProcesses
recurse 0
