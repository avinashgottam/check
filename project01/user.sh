#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo "script started excited at $TIMESTAMP" &>> LOGFILE
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
    echo -e "Your are $G Root User $N"
fi
dnf module disable nodejs -y &>> $LOGFILE
VALIDATE $? "Disabling node js"
dnf module enable nodejs:18 -y &>> $LOGFILE
VALIDATE $? "Enabling nodejs 18"
dnf install nodejs -y &>> $LOGFILE
VALIDATE $? "installing nodejs 18"
id roboshop
if [ $? -ne 0 ]
then 
    echo "useradd roboshop"
else
    echo "Already exits $Y Skipping$N" 

mkdir -p &>> $LOGFILE
VALIDATE $? "making directory"
curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE
cd /app 
unzip /tmp/user.zip 
VALIDATE $? "unziping the file"
npm install  &>> $LOGFILE
VALIDATE $? "Installing Dependencies"
cp /home/centos/check/project01/user.service /etc/systemd/system/user.service

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "Daemon reloading"
systemctl enable user &>> $LOGFILE
VALIDATE $? "Enabling user"
systemctl start user &>> $LOGFILE
VALIDATE $? "Starting User"
cp /home/centos/check/project01/mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org-shell -y &>> LOGFILE
VALIDATE $? "installing client mongodb"
mongo --host 172.31.31.146 </app/schema/user.js
