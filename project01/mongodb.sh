#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script started executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){
    if ($1 ne 0)
    then
        echo -e "Error:$2 ..$R Failed $N"
        exit 1
    else
        echo -e "$2... $G Success $N"
    fi      
}
if [ $ID -ne 0 ]
then
    echo -e "Your are not root user"
    exit 1
else
    echo -e "root user"
fi


cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
VALIDATE $? "copied mongorepo"
dnf install mongodb-org -y &>> $LOGFILE
VALIDATE $? "installing moongodb"
systemctl enable mongod
VALIDATE $? "enable moongodb"
systemctl start mongod
VALIDATE $? "starting moongodb"
sed -e 's/127.0.0.0/0.0.0.' /etc/mongod.conf &>> $LOGFILE
sytemctl restart mongod
VALIDATE $? "restarting mongodb"







