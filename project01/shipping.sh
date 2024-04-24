#/bin/bash
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
    echo -e "Your are $G Root User $N"
fi
<<<<<<< HEAD
dnf install maven -y &>> $LOGFILE  $
=======
dnf install maven -y &>> $LOGFILE  
>>>>>>> 0dcab8bb322e35dc4dd9b2c1a3de0ebc6161bcf0
VALIDATE $? "installing maven"
id roboshop
if [ $? -ne 0 ]
then 
<<<<<<< HEAD
    echo "useradd roboshop"
else
    echo "User already exits Skipping"
fi  
=======
     useradd roboshop
     exit 1
else
    echo "Already exits  Skipping" 
fi
>>>>>>> 0dcab8bb322e35dc4dd9b2c1a3de0ebc6161bcf0
mkdir -p /app &>> $LOGFILE
VALIDATE $? "making directory"
curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> LOGFILE
VALIDATE $? " curl is creating"
cd /app
unzip -o /tmp/shipping.zip &>> $LOGFILE
VALIDATE $? "unziping"
mvn clean package &>> $LOGFILE
VALIDATE $? "Installing maven clean package"
mv target/shipping-1.0.jar shipping.jar &>> $LOGFILE
cp /home/centos/check/project01/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "system daemon reloading"
systemctl enable shipping &>> $LOGFILE 
VALIDATE $? "system enabaling"
systemctl start shipping &>> $LOGFILE
VALIDATE $? "system starting "
dnf install mysql -y &>> $LOGFILE
VALIDATE $? "installing mysql"
<<<<<<< HEAD
mysql -h 172.31.86.90 -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping &>> $LOGFILE
VALIDATE $? "system restarting "
=======
mysql -h mysql.ssrg.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping &>> $LOGFILE
VALIDATE $? "system restarting "
>>>>>>> 0dcab8bb322e35dc4dd9b2c1a3de0ebc6161bcf0