#!/bin/bash
ID=$(id -u)
if [ id ne 0 ]
then
    echo "Error:please run the script in root user"
    exit 1
else
    echo "Your are root User"
fi        
yum install mysql -y
if [ $? ne 0]
then
    echo "Installing failed"
else
    echo "Sucess Installation"
fi        