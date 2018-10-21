#!/bin/bash

# Build base image
docker build -t apache/rocketmq-base:4.3.0 --build-arg version=4.3.0 ./rocketmq-base

# Build namesrv and broker
docker build -t apache/rocketmq-namesrv:4.3.0 ./rocketmq-namesrv
docker build -t apache/rocketmq-broker:4.3.0 ./rocketmq-broker

# Run namesrv and broker

#docker service	create  -p 9876:9876 --name rmqnamesrv --network exchange --replicas 1  -e "NAMESRV_ADDR=rmqnamesrv:9876"   apache/rocketmq-namesrv:4.3.0
docker service create -p 10911:10911 -p 10909:10909 --name rmqbroker --network exchange --replicas 1 -e "NAMESRV_ADDR=rmqnamesrv:9876" apache/rocketmq-broker:4.3.0
