#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGFILE=

VALIDATE(){
    if ($1 ne 0)
    then
        echo -e "Error:$2 .. Failed"
        exit 1
    else
        echo -e "$2 ... Success
    fi      
}
