#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e " Error $2 :: FAILURE"
    else
        echo -e " $2 ....SUCCESS"
    fi
}
if [ $ID -ne 0 ]
then 
    echo -e " Your are not Root User"
else
    echo -e " U R Root User"
fi        
dnf install nginx -y &>> $LOGFILE
VALIDATE $? "installing nginx"
systemctl enable nginx &>> $LOGFILE
VALIDATE $? " Enabling nginx"
systemctl start nginx &>> $LOGFILE
VALIDATE $? "Starting nginx"
rm -rf /usr/share/nginx/html/* &>> $LOGFILE
VALIDATE $? " moving default file"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
cd /usr/share/nginx/html
unzip -o /tmp/web.zip &>> $LOGFILE
VALIDATE $? "unzping files"
cp /home/centos/check/project01/roboshop.conf /etc/nginx/default.d/roboshop.conf 
VALIDATE $? "creating reverse proxy"
systemctl restart nginx &>> $LOGFILE
VALIDATE $? "Nginx restarting"
