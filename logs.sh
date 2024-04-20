
#!/bin/bash

ID=$(id -u) 1000
TIMESTAMP=$(date +%F-%H-%M-%S) 
2024-04-20-16-15-19



LOGFILE="/tmp/$0-$TIMESTAMP.log"  /tmp/logs-2024-04-20-16-15-19.log

echo "Script started executing at $TIMESTAMP" &  >> $LOGFILE
Script started executing at 2024-04-20-16-15-19
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "ERROR:: $2 ...  FAILED "
        exit 1
    else
        echo -e "$2 ...  SUCCESS "
    fi
}

if [ $ID -ne 0 ]
then
    echo -e " ERROR:: Please run this script with root access "
    exit 1 # you can give other than 0
else
    echo "You are root user"
fi # fi means reverse of if, indicating condition end

yum install mysql -y &>> $LOGFILE

VALIDATE $? "Installing MySQL"

yum install git -y &>> $LOGFILE

VALIDATE $? "Installing GIT"
