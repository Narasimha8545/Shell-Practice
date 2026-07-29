R="\e[31m"
G="\e[32m"
B="\e[34m"
N="\e[0m" #normal color
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script started excuting at: $(date)" |tee -a $LOG_FILE

userid=$(id -u)
if [ $userid -ne 0 ]
then 
    echo -e " $R please run the script as root user $N " |tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo -e " $G your are running the root user $N " |tee -a $LOG_FILE
    fi
    # validate function takes the exist status, what command they tried to install
    validate(){
        if [ $1 -eq 0 ] 
        then
            echo -e " $G installing $2 is .... successful $N" |tee -a $LOG_FILE
        else    
            echo -e " $R installation $2 is .... failed $N "|tee -a $LOG_FILE
            exit 1
        fi 
    }
    dnf  install mysql-server -y &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "mysql is not installed.. going to install it"|tee -a $LOG_FILE
        validate $? mysql-server
    else
        echo -e " $B mysql is already installed.. nothing do it $N "|tee -a $LOG_FILE
    fi
    dnf  install python3 -y &>>$LOG_FILE
    if [ $? -ne 0 ]
    then 
        echo "python3 is not installed.. going to install it"|tee -a $LOG_FILE
        validate $? python3
    else
        echo -e " $B python3 is already installed.. nothing do it $N "|tee -a $LOG_FILE
    fi
    dnf  install nginx -y &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "nginx is not installed.. going to install it" |tee -a $LOG_FILE
        validate $? nginx
    else
        echo -e " $B nginx is already installed.. nothing do it $N "|tee -a $LOG_FILE
    fi