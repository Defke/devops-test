#!/bin/bash

MODE=dev

VER=3.1.0

DIR=/home/$MODE/$VER

APP_NAME=devops-test

DIR=/home/holder/$MODE/$VER/$APP_NAME

deploy() {
    if [ ! -d $DIR ]; then
        echo "create dir $DIR"
        midir -p DIR
    fi
     pid=`ps -ef | grep ./$APP_NAME | grep -v grep | awk '{print $2}'`
     #kill pid
     for id in $pid
     do
        kill -9 $id
        echo "kill $id"
     done
      cd $DIR
      nohup ./$APP_NAME>run.log 2>&1 &
}


usage() {
    echo "Usage: sh 执行脚本.sh [start|stop|restart|status|deploy]"
    exit 1
}

is_run() {
    pid=`ps -ef | grep ./$APP_NAME | grep -v grep | awk '{print $2}'`
    if [ -z "$pid" ]; then
        return 0
     else
        return 1
    fi
}

start() {
    is_run
    if [ $? -eq "0" ]; then
       cd $DIR
       nohup ./$APP_NAME>run.log 2>&1 &
        is_run
           if [ $? -eq "0" ]; then
               echo "$APP_NAME run failed"
           else
               echo "$APP_NAME run success, Pid is $pid"
            fi
    else
        echo "$APP_NAME is already running, pid is $pid"
    fi
}

stop() {
    is_run
    if [ $? -eq "0" ]; then
        echo "$APP_NAME is not running"
    else
        kill -9 $pid
        echo "kill success, kill pid is $pid"
     fi
}

status(){
  is_run
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is not running."
  else
     echo "${APP_NAME} is running. Pid is ${pid}"
  fi
}

restart() {
  stop
  start
}

case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
   "deploy")
    deploy
    ;;
  *)
    usage
    ;;
esac