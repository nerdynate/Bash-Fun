#! /bin/bash

# Removes older mysql backups from the 4500

date=date

find /pool/static/backup/clients -type f -mtime +5 -name '*.sql' | xargs rm

if [ $? -eq 0  ]
   then
         echo "Files older than 5 days deleted on ${date}" >> /var/log/backup.log
   else
         echo "No files to be deleted or delete failed on ${date}" >> /var/log/backup.log
         echo "No Backup files deleted on the 4500 on ${date}" | mail -s "no backup files deleted on sun001" nate.geouge@escapemg.com
fi
