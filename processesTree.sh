#!/bin/bash

# MAIN LIST WITH ALL INFORMATION
list=$(ps axo comm,pid,ppid,user,start | awk '{print $1 " , " $2 " , " $3 " , " $4 " , " $5}')

# SUBLISTS WITH SPECIFIC INFORMATION
listCommand=( $(echo "$list" | awk -F ' , ' '{print $1}') )
listPid=( $(echo "$list" | awk -F ' , ' '{print $2}') )
listPpid=( $(echo "$list" | awk -F ' , ' '{print $3}') )
listUser=( $(echo "$list" | awk -F ' , ' '{print $4}') )
listStartTime=( $(echo "" | awk -F ' , ' '{print $5}') )

#PRINTS INFO IN MAIN LIST
printf "%s\n" "${listPid[@]}"

# ALGORITHM SO FAR
#1. Go through each pid and ppid in list
#2. if pid == (ppid) then it is a child
#3. if ppid == 1 then it is a child of systemd
