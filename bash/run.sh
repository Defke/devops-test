
#开发模式
MODE=dev
#版本号
VER=3.1.0
#程序目录
DIR=/go/src/$mode/$VER
#程序名称
APP_NAME=devops-test

deploy() {
    #是否存在目录
    if [ ! -d $DIR ]; then
        echo "准备创建目录 $DIR"
        midir -p DIR
    fi
     pid=`ps -ef | grep ./$APP | grep -v grep | awk '{print $2}'`
     #kill pid
     for id in $pid
     do
        kill -9 $id
        echo "kill $id"
     done
      cd $DIR
       nohup ./$APP_NAME > run.log &
       if [ $? = 0 ]; then
               echo "启动失败"
              else
               echo "启动成功"
               fi
}



#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh 执行脚本.sh [start|stop|restart|status|deploy]"
    exit 1
}

#检查程序是否运行
is_run() {
    pid=`ps -ef | grep ./$APP_NAME | grep -v grep | awk '{print $2}'`
    echo "运行的pid $pid"
    #运行返回1，未运行返回0
    if [ -z "$pid" ]; then
        return 0
     else
        return 1
    fi
}

#程序启动
start() {
    is_run
    if [ $? -eq "0" ]; then
       cd $DIR
       nohup ./$APP_NAME > run.log &
       if [ $? = 0 ]; then
        echo "启动失败"
       else
        echo "启动成功"
        fi
    fi
}

#程序关闭
stop() {
    is_run
    if [ $? -eq "0" ]; then
        echo "$APP_NAME is already running.pid = $pid"
    else
        kill -9 $pid
        echo "程序已经停止"
     fi
}

#输出运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is NOT running."
  else
     echo "${APP_NAME} is running. Pid is ${pid}"
  fi
}

#程序重启
restart() {
  stop
  start
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
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