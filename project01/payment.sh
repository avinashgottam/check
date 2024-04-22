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
dnf install python36 gcc python3-devel -y
id roboshop
if [ $? -ne 0 ]
then 
    echo "useradd roboshop"
    exit 1
else
    echo "Already exits Skipping" 
fi
mkdir -p /app &>> $LOGFILE
VALIDATE $? "creating directory"
curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip
cd /app &>> $LOGFILE
unzip -o /tmp/payment.zip &>> $LOGFILE
VALIDATE $? "Unzipping Files"
pip3.6 install -r requirements.txt &>> $LOGFILE
VALIDATE $? "Installing Pip"
cp /home/centos/check/project01/payment.service /etc/systemd/system/payment.service
systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "Daemon Reloading"
systemctl enable payment &>> $LOGFILE 
VALIDATE $? "Enabling payment"
systemctl start payment  &>> $LOGFILE
VALIDATE $? "starting Payemnt"
