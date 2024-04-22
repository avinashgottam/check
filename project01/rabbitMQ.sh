#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$-$TIMESTAMP.log"
VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "ERROR:: $2.... FAILED"
        exit 1
    else
        echo "$2... SUCESSS"
    fi        
}
if [ $ID -ne 0 ]
then
    echo -e "Your are not Root User"
    exit 1
else
    echo -e "Your are Root User"
fi
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash 
VALIDATE $? "Configure YUM repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash 
dnf install rabbitmq-server -y &>> $LOGFILE
VALIDATE $? "Installing rabbitMQ"
systemctl enable rabbitmq-server &>> $LOGFILE
VALIDATE $? "Enabling rabbitMQ"
systemctl start rabbitmq-server &>> $LOGFILE
VALIDATE $? "Starting rabbitMQ"
rabbitmqctl add_user roboshop roboshop123 &>> $LOGFILE
VALIDATE $? "creating User"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>> $LOGFILE    
VALIDATE $? "Setting Permissions"
