#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
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
    useradd roboshop
    exit 1
else
<<<<<<< HEAD
    echo "Already exits Skipping" 
fi
=======
    echo "Already exits  Skipping" 
fi  
>>>>>>> 0dcab8bb322e35dc4dd9b2c1a3de0ebc6161bcf0
mkdir -p /app &>> $LOGFILE
VALIDATE $? "making directory"
curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $LOGFILE
cd /app 
unzip -o /tmp/cart.zip 
VALIDATE $? "unziping the file"
npm install  &>> $LOGFILE
VALIDATE $? "Installing Dependencies"
cp /home/centos/check/project01/cart.service /etc/systemd/system/cart.service

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "Daemon reloading"
systemctl enable cart &>> $LOGFILE
VALIDATE $? "Enabling cart"
systemctl start cart &>> $LOGFILE
VALIDATE $? "Starting cart"
