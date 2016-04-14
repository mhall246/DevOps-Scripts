#!/bin/bash

DATE=`/bin/date '+%Y%m%d'`
YESTERDAY=`/bin/date -d "yesterday 13:00 " '+%Y%m%d'`
NEWDBNAME=us$YESTERDAY
BACKUPFILE=`/opt/dbrestorepython/dblookup -p admissions -r us -d $YESTERDAY`
USER=root
USERADD=devopsuser
PASSWORD=0vQxj9hOgqbkcvkLj5JrYXx0vgZW8hUBUY1
DBCHECK=`/usr/bin/mysql -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '"$NEWDBNAME"';"`
USERCHECK=`/usr/bin/mysql -e "select user from mysql.user where user = '"$USERADD"';"`
GRANT=`/usr/bin/mysql -e "grant all privileges on "$NEWDBNAME".* to "$USERADD"@'%' identified by '"$PASSWORD"';"`

touch /var/tmp/$NEWDBNAME.txt
echo "The date from yesterday:" >> /var/tmp/$NEWDBNAME.txt
echo $YESTERDAY >> /var/tmp/$NEWDBNAME.txt 

echo "New Database to be created" >> /var/tmp/$NEWDBNAME.txt
echo $NEWDBNAME >> /var/tmp/$NEWDBNAME.txt

echo "Username:" >> /var/tmp/$NEWDBNAME.txt
echo "$USERADD" >> /var/tmp/$NEWDBNAME.txt

echo "Password:" >> /var/tmp/$NEWDBNAME.txt
echo "$PASSWORD" >> /var/tmp/$NEWDBNAME.txt

if [ -n "$DBCHECK" ];
then
    echo "Database Already Exists!!" >> /var/tmp/$NEWDBNAME.txt
else
    echo "Backup File Name" >> /var/tmp/$NEWDBNAME.txt
    echo $BACKUPFILE >> /var/tmp/$NEWDBNAME.txt
    echo "Command to start DBrefresh" >> /var/tmp/$NEWDBNAME.txt
    echo "/opt/dbrestorepython/dbrestore -p admissions -r us -b $BACKUPFILE -d $NEWDBNAME" >> /var/tmp/$NEWDBNAME.txt
    /opt/dbrestorepython/dbrestore -p admissions -r us -b "$BACKUPFILE" -d "$NEWDBNAME"
fi

if [ -n "$USERCHECK" ]; 
then
    echo "User Already Created" >> /var/tmp/$NEWDBNAME.txt
else
#    echo "MySQL CREATE command" >> /var/tmp/$NEWDBNAME.txt
    CREATEUSER=`mysql -e "CREATE USER "$USERADD"@'%' identified by '"$PASSWORD"';"`
#    echo "$CREATEUSER" >> /var/tmp/$NEWDBNAME.txt
    $CREATEUSER
fi

#echo "MySQL GRANT command" >> /var/tmp/$NEWDBNAME.txt
#echo "$GRANT" >> /var/tmp/$NEWDBNAME.txt
$GRANT

cat /var/tmp/$NEWDBNAME.txt | mail -s "HIRE US DB Refresh $DATE" matthew.hall@sykes.com
cat /var/tmp/$NEWDBNAME.txt | mail -s "HIRE US DB Refresh $DATE" christopher.mastrogiuseppe@sykes.com
cat /var/tmp/$NEWDBNAME.txt | mail -s "HIRE US DB Refresh $DATE" rex.recio@sykes.com
cat /var/tmp/$NEWDBNAME.txt | mail -s "HIRE US DB Refresh $DATE" scott.devos@sykes.com
cat /var/tmp/$NEWDBNAME.txt | mail -s "HIRE US DB Refresh $DATE" david.barrios@sykes.com

rm -f /var/tmp/$NEWDBNAME.txt
