#!/bin/bash
#Zina Al-Sabbagh 10161380
#Rawan Alsaadi 10081442
#Omar Toutounji 10169506
#Beltan Michel 10169162

#Recursion doesn't work (don't understand why) -> it doesn't keep executing the for loop when coming back to previous instance or recurse

export var=()
mapfile -t var < <(ps axo comm,pid,ppid,user,start | grep -e '')
export incr=0
export numProcesses=${#var[*]}
export listPpid=()
mapfile -t listPpid < <(ps axo comm,pid,ppid,user,start | grep -e '' | awk '{print $3}')

function recurse {
((incr=$incr+1))
for (( i=1; i<numProcesses; i++ )); do
	if [[ ${listPpid[i]} -eq $1 ]]; then
		for ((n=1; n<incr; n++)); do
			printf '\t'
		done
		echo ${var[i]}
		PID=$(echo ${var[i]} | awk '{print $2}')
		recurse $PID
	fi
done 
((incr=$incr-1))
return 0
}

echo $numProcesses
recurse 0
