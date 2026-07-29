R="\e[31m"
G="\e[32m"
B="\e[34m"
N="\e[0m" #normal color
LOGS_FOLDER="/var/logs/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
FILE_NAME= "$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script started excuting at: $(date)" |tee -a $FILE_NAME

userid=$(id -u)
if [ $userid -ne 0 ]
then 
    echo -e " $R please run the script as root user $N " |tee -a $FILE_NAME
    exit 1 #give other than 0 upto 127
else
    echo -e " $G your are running the root user $N " |tee -a $FILE_NAME
    fi
    # validate function takes the exist status, what command they tried to install
    validate(){
        if [ $1 -eq 0 ] 
        then
            echo -e " $G installing $2 is .... successful $N" |tee -a $FILE_NAME
        else    
            echo -e " $R installation $2 is .... failed $N "|tee -a $FILE_NAME
            exit 1
        fi 
    }
    dnf list installed mysql-server -y
    if [ $? -ne 0 ]
    then
        echo "mysql is not installed.. going to install it"|tee -a $FILE_NAME
        validate $? mysql-server
    else
        echo -e " $B mysql is already installed.. nothing do it $N "|tee -a $FILE_NAME
    fi
    dnf list installed python3 -y
    if [ $? -ne 0 ]
    then 
        echo "python3 is not installed.. going to install it"|tee -a $FILE_NAME
        validate $? python3
    else
        echo -e " $B python3 is already installed.. nothing do it $N "|tee -a $FILE_NAME
    fi
    dnf list installed nginx -y
    if [ $? -ne 0 ]
    then
        echo "nginx is not installed.. going to install it" |tee -a $FILE_NAME
        validate $? nginx
    else
        echo -e " $B nginx is already installed.. nothing do it $N "|tee -a $FILE_NAME
    fi