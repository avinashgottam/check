#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
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
    echo -e "Your are $G Root User $N"
fi
dnf module disable mysql -y &>> $LOGFILE
VALIDATE $? "Disabling my sql"

cp /home/centos/check/project01/mysql.repo /etc/yum.repos.d/mysql.repo
dnf install mysql-community-server -y &>> $LOGFILE
VALIDATE $? "installing community server"
systemctl enable mysqld &>> $LOGFILE
VALIDATE $? "Enabling mysql"
systemctl start mysqld &>> $LOGFILE
VALIDATE $? "starting mysql"
mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOGFILE
VALIDATE $? "mysql secure installing"
