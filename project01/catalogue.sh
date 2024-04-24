#!/bin/bash
ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo "script started exceted at $TIMESTAMP" &>>LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "Error $2 .. $R Failure$N"
        exit 1
    else
        echo -e "$2 ....$G Success$N"   
    fi     
}
if [ $ID -ne 0 ]
then
    echo -e "$R Error: please run the script in Root user$N"
    exit 1
else
    echo -e "$G U R are root user$N"    
fi

dnf module disable nodejs -y &>> $LOGFILE
VALIDATE $? "Disabling nodejs"

dnf module enable nodejs:18 -y &>> $LOGFILE
VALIDATE $? "Enabling nodejs18"

dnf install nodejs -y &>> $LOGFILE
VALIDATE $? "installing nodejs"
id roboshop
if [ $? -ne 0 ] 
then 
     useradd roboshop
     exit 1
     VALIDATE $? "Adding user"
else 
    echo -e "already exits $Y skipping$N"
fi        


mkdir -p /app &>> $LOGFILE
VALIDATE $? "adding directory"

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE
cd /app 
unzip -o /tmp/catalogue.zip &>> $LOGFILE
VALIDATE $? "unzipping"

npm install &>> $LOGFILE
VALIDATE $? "installing client"

cp /home/centos/check/project01/catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload  &>> $LOGFILE
VALIDATE $? "daemon reloading"

systemctl enable catalogue &>> $LOGFILE
VALIDATE $? "system enabling"

systemctl start catalogue &>> $LOGFILE
VALIDATE $? "system starting"

cp /home/centos/check/project01/mongo.repo /etc/yum.repos.d/mongo.repo 

dnf install mongodb-org-shell -y &>> $LOGFILE


mongo --host mongodb.ssrg.online </app/schema/catalogue.js &>> $LOGFILE
VALIDATE $? "loading catalogue data"


