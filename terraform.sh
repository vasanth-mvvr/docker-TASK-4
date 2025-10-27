#/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%I:%M:%S:%p)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$R $2  Failed ... $N"
        exit 1
    else 
        echo -e "$G $2 Success ... $N"
    fi
}


if [ $USERID -ne 0 ] 
then
    echo -e " $R You need to have super user access $N"
    exit 1
else
    echo -e "$G You are super user $N"
fi   
# terraform install
yum install -y yum-utils &>>$LOG_FILE
validate $? "installing utils"
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo &>>$LOG_FILE
validate $? "Adding terraform repo"
yum -y install terraform &>>$LOG_FILE
validate $? "installing docker"