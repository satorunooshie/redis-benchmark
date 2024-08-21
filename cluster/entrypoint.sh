#!/bin/bash

start_redis_node() {
  PORT=$1
  CONFIG_FILE="/usr/local/etc/redis/redis-${PORT}.conf"
  cp /usr/local/etc/redis/redis-cluster.tmpl $CONFIG_FILE
  sed -i "s/{{PORT}}/${PORT}/g" $CONFIG_FILE
  redis-server $CONFIG_FILE --daemonize yes
}

start_redis_node 6379
start_redis_node 6380
start_redis_node 6381
start_redis_node 6382
start_redis_node 6383
start_redis_node 6384

# wait for redis to start
sleep 10

# avoid [ERR] Node 127.0.0.1:PORT is not empty. Either the node already knows other nodes (check with CLUSTER NODES) or contains some key in database 0.
redis-cli -p 6379 FLUSHALL
redis-cli -p 6379 CLUSTER RESET HARD
redis-cli -p 6380 FLUSHALL
redis-cli -p 6380 CLUSTER RESET HARD
redis-cli -p 6381 FLUSHALL
redis-cli -p 6381 CLUSTER RESET HARD
redis-cli -p 6382 FLUSHALL
redis-cli -p 6382 CLUSTER RESET HARD
redis-cli -p 6383 FLUSHALL
redis-cli -p 6383 CLUSTER RESET HARD
redis-cli -p 6384 FLUSHALL
redis-cli -p 6384 CLUSTER RESET HARD

yes yes | redis-cli --cluster create 127.0.0.1:6379 127.0.0.1:6380 127.0.0.1:6381 127.0.0.1:6382 127.0.0.1:6383 127.0.0.1:6384 --cluster-replicas 1

tail -f /dev/null
