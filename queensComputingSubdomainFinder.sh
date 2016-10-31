# Rawan Alsaadi 10081442 
# Omar Toutounji 10169506 
# Beltan Michel 10169162 

#!/bin/bash
printf "IP Address\tSub-Domain\n"
for ip in 130.15.{0..255}.{0..255}; do     
	printf "$ip\t"
	LOOKUP_RES='nslookup $IP'
	NAME='echo $LOOKUP_RES | grep -v nameserver | cut -f 2 | grep name | cut -f 2 -d "=" | sed 's/ //'';
	echo $NAME	
done