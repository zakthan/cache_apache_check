#!/bin/bash
HOST=`hostname`
ZABBIX=pvzabbix01.cosmote.gr
KEY=cache_count_for_current_date
##MAILLIST=middleware@ote.gr
MAILLIST=azakopoulos@ote.gr
date=`date '+%b %d'`
##if data is 0? then remove 0
#####date=$(echo $date|sed "s/0/ /")
cache_root=/tmp/httpd/cache/
COUNT_FILES_WITH_CURRENT_DATE=$(find $cache_root  -type f|xargs ls -lt|head|grep "$(echo $date|sed "s/0/ /")"|wc -l)
####echo $COUNT_FILES_WITH_CURRENT_DATE

/usr/bin/zabbix_sender -z $ZABBIX -s $HOST -k $KEY -o $COUNT_FILES_WITH_CURRENT_DATE

if [ $COUNT_FILES_WITH_CURRENT_DATE -eq 0 ]
then 
##      echo 0
        mailx -s "check apache cache validity for $HOST" $MAILLIST <.
##else 
##      echo 1
fi
