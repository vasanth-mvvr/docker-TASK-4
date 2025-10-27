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

R="\e[31m"
N="\e[0m"
dnf -y install dnf-plugins-core
validate $? "installing plugin core"

dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
validate $? "Adding docker repo"

dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
validate $? "installing plugins"

systemctl start docker
validate $? "Starting docker"

systemctl enable docker
validate $? "enabling docker"

usermod -aG docker ec2-user
validate $? "Adding home user to docker"

echo -e "$R logout and login again $N"