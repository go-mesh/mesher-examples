#!/usr/bin/env bash

run_client(){
if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get -v github.com/go-mesh/mesher-examples/Go-Mesher-Example/client
cp -r bin/client $1/Go-Mesher-Example/client/
cd $1/Go-Mesher-Example/client/
export http_proxy=http://127.0.0.1:30101

./client > client.log 2>&1 &

}

run_server(){
if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get -v github.com/go-mesh/mesher-examples/Go-Mesher-Example/server
cp -r bin/server $1/Go-Mesher-Example/server/
cd $1/Go-Mesher-Example/server/

./server > server.log 2>&1 &

}

run_mesher_consumer(){

if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi
if [ $2 == "" ]; then
    echo "SERVICE_CENTER_ADDR variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get -v github.com/go-mesh/mesher
cp -r bin/mesher $1/Go-Mesher-Example/mesher/mesher-consumer/
cd $1/Go-Mesher-Example/mesher/mesher-consumer/

net_name=$(ip -o -4 route show to default | awk '{print $5}')
listen_addr=$(ifconfig $net_name | grep -E 'inet\W' | grep -o -E [0-9]+.[0-9]+.[0-9]+.[0-9]+ | head -n 1)
sed -i s/"listenAddress:\s\{1,\}[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}"/"listenAddress: $listen_addr"/g conf/chassis.yaml
export CSE_REGISTRY_ADDR=$2

./mesher > mesher-consumer.log 2>&1 &

}

run_mesher_provider(){


if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi
if [ $2 == "" ]; then
    echo "SERVICE_CENTER_ADDR variable in not passed.....aborting....."
    exit 1
fi

if [ $3 == "" ]; then
    echo "SERVICE_NAME variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get github.com/go-mesh/mesher
cp -r bin/mesher $1/Go-Mesher-Example/mesher/mesher-provider/
cd $1/Go-Mesher-Example/mesher/mesher-provider/
net_name=$(ip -o -4 route show to default | awk '{print $5}')
listen_addr=$(ifconfig $net_name | grep -E 'inet\W' | grep -o -E [0-9]+.[0-9]+.[0-9]+.[0-9]+ | head -n 1)
sed -i s/"listenAddress:\s\{1,\}[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}"/"listenAddress: $listen_addr"/g conf/chassis.yaml
export CSE_REGISTRY_ADDR=$2
export SERVICE_NAME=$3
export SERVICE_PORTS=$4

./mesher > mesher-provider.log 2>&1 &

}

rm -rf $2/tmp
# Get the Command
case $1 in
    client )
        run_client $2 ;;

    server )
        run_server $2;;

    mesher-consumer )
        run_mesher_consumer $2 $3;;

    mesher-provider )
        run_mesher_provider $2 $3 $4 $5;;

esac
