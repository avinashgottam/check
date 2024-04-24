#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo "script started excited at $TIMESTAMP" &>> $LOGFILE
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "Error $2... $R Failed$N"
        exit 1
    else 
        echo -e "$2..$G success$N"  
    fi      
}
if [ $ID -ne 0 ]
then 
    echo -e "Error $R your are not Root User$N"
    exit 1
else    
    echo -e "Your are $G Root User$N"
fi

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
VALIDATE $? "Installing remi repo"
dnf module enable redis:remi-6.2 -y &>> $LOGFILE
VALIDATE $? "Installing remi 6.2"
dnf install redis -y &>> $LOGFILE
VALIDATE $? "Installing redis"
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
systemctl enable redis &>> $LOGFILE
VALIDATE $? "Enabling redis"
systemctl start redis &>> $LOGFILE
VALIDATE $? "Starting redis"