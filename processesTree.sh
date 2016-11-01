#!/bin/bash

# MAIN LIST WITH ALL INFORMATION
export list=$(ps axo comm,pid,ppid,user,start | awk '{print $1 " , " $2 " , " $3 " , " $4 " , " $5}')

# OTHER LIST DECLARATION TO TRY
declare -A tree
for status in /proc/[0-9]*/status; do
    while read type value; do
        [[ "$type" == Name: ]] && cmd=$value
        [[ "$type" == Pid: ]] && pid=$value
        [[ "$type" == PPid: ]] && ppid=$value
    done < "$status"
    tree[$pid:$ppid]="$cmd PID:$pid PPID:$ppid"
done
#END LIST


export incr=0
export numProcesses=${#list[*]}



# SUBLISTS WITH SPECIFIC INFORMATION
#listCommand=( $(echo "$list" | awk -F ' , ' '{print $1}') )
#listPid=( $(echo "$list" | awk -F ' , ' '{print $2}') )
#listPpid=( $(echo "$list" | awk -F ' , ' '{print $3}') )
#listUser=( $(echo "$list" | awk -F ' , ' '{print $4}') )
#listStartTime=( $(echo "" | awk -F ' , ' '{print $5}') )



#PRINTS INFO IN MAIN LIST

#printf "%s\n" "${list[@]}"


# ALGORITHM SO FAR
#1. Go through each pid and ppid in list
#2. if pid == (ppid) then it is a child
#3. if ppid == 1 then it is a child of systemd

function recurse {
((incr = $incr+1))
for (( i=1; i<=numProcesses; i++ )); do 
	if [[(echo list[i] | awk '{print $3}') -eq $1]]; then
		echo list[i]
		recurse echo list[i] | awk '{print $2}'
	fi
done 
((incr = $incr-1))
}

recurse 0
