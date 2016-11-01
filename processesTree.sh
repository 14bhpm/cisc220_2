#!/bin/bash

# MAIN LIST WITH ALL INFORMATION
export list=$(ps axo comm,pid,ppid,user,start | awk '{print $1 " , " $2 " , " $3 " , " $4 " , " $5}')
export incr=0
export numProcesses=${#list[*]}
export listPpid=( $(echo "$list" | awk -F ' , ' '{print $3}') )




#PRINTS INFO IN MAIN LIST

#printf "%s\n" "${list[@]}"


# ALGORITHM SO FAR
#1. Go through each pid and ppid in list
#2. if pid == (ppid) then it is a child
#3. if ppid == 1 then it is a child of systemd

function recurse {
((incr=$incr+1))
for (( i=1; i<numProcesses; i++ )); do
	echo swag 
	if [[ ${listPpid[i]} -eq $1 ]]; then
		echo swag2
		echo ${list[i]}
		echo list[i] | awk '{print $2}' | recurse
	fi
done 
((incr = $incr-1))
}

echo $numProcesses
recurse 0
