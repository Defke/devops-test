
DIR = /go/src/release
App = devops-test

pid=`ps -ef | grep ./devops-test | grep -v grep | awk '{print $2}'`
echo "---------------"
for id in $pid
do
kill -9 $id
echo "killed $id"
done
echo "---------------"