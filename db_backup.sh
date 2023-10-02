#!/bin/bash

echo "DB BACKUP JOB"
DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/root/db_backups"

SQL_DUMP_FILE="${BACKUP_DIR}/melvinmagro-online-dump-${DATE}.sql"

WPDBNAME_PROD=$(cat /var/www/html/melvinmagro.online/wp-config.php | grep ^define.*DB_NAME | cut -d \' -f 4)
WPDBUSER_PROD=$(cat /var/www/html/melvinmagro.online/wp-config.php | grep ^define.*DB_USER | cut -d \' -f 4)
WPDBPASS_PROD=$(cat /var/www/html/melvinmagro.online/wp-config.php | grep ^define.*DB_PASSWORD | cut -d \' -f 4)

echo "INFO: Creating MySQL dump.."

mysqldump --user=${WPDBUSER_PROD} --password=${WPDBPASS_PROD} ${WPDBNAME_PROD} > ${SQL_DUMP_FILE}

rc=$?
if [ "$rc" != 0 ]; then
  echo "ERROR: Failed to create dump"
  exit $rc
fi

echo "INFO: Creating MySQL dump finished"

#add backup retension.
#delete backups older than 7 days
find "${BACKUP_DIR}" -type f -name "melvinmagro-online-dump-*.sql" -mtime +7 -exec rm {} \;
