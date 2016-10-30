#!/bin/bash
#Rawan Alsaadi 10081442
#Omar Toutounji 10169506
#Beltan Michel 10169162

#Cron job: cron * 1 * * * ./repositoryBackup.sh <path to local repository> <git URL> <git username> <git password>

date=$(date | awk '{print $6}')$(date +'%m')$(date | awk '{print $3}')0100

ls $1 | grep -v .tgz$ | xargs tar cvzf Backup$date.tgz -C $1
mv Backup$date.tgz $1
echo "Backup Backup$date.tgz created successfully!" >> backupsLog

(cd $1 && git pull && git add Backup$date.tgz && git commit -m "Created Backup$date")
echo "Backup Backup$date.tgz committed to the local git repository" >> backupsLog
(cd $1 && git push https://$3:$4@$2 --all)
echo "Backup Backup$date.tgz pushed to the remote git repository" >> backupsLog

mv backupsLog $1
