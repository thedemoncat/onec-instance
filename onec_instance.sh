#!/bin/bash
set -e
# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts

# Hostname to add/remove.
# HOSTNAME=$(grep HOSTNAME .env | xargs)
export $(grep -v '^#' .env | xargs)

function removehost() {
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}

function addhost() {
    HOSTNAME=$1
    HOSTS_LINE="$serverIP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME уже существует : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Добавляем $HOSTNAME в $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME упешно добавлен \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "ошибка добавления $HOSTNAME, попробуйте еще раз!";
            fi
    fi
}

function running() {
    ID_CONTAINER=$(docker-compose ps -q server)
    local status="$(docker inspect --format='{{.State.Status}}' $ID_CONTAINER)"
    if [[ "$status" = "running" ]] ; then
        echo "Сервер 1С запущен"
        return 0
    else
        echo "Сервер 1С остановлен"
        return 1
    fi
}

function start(){

    docker-compose up -d

    # DEFAULT IP FOR HOSTNAME
    ID_CONTAINER=$(docker-compose ps -q server)
    serverIP="$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $ID_CONTAINER )"
    
    addhost $HOSTNAME

}

function stop(){
    
    # DEFAULT IP FOR HOSTNAME
    ID_CONTAINER=$(docker-compose ps -q server)
    serverIP="$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $ID_CONTAINER )"
    
    # Останавливаем контейнер
    docker-compose down

    removehost $HOSTNAME
}


if [ "$1" == "start" ]; then
    start && exit 0 || exit -1

elif [ "$1" == "stop" ]; then
    stop && exit 0 || exit -1

elif [ "$1" == "restart" ]; then
    stop && sleep 1
    start && exit 0 || exit -1

elif [ "$1" == "status" ]; then
    if running; then
        echo "instance running"
        exit 0
    else
        echo "instance stopped"
        exit 1
    fi
else
    help
fi
