#!/bin/bash

redis-server /usr/local/etc/redis/redis.conf --port 6379 --daemonize yes

redis-server /usr/local/etc/redis/redis.conf --port 6380 --replicaof 127.0.0.1 6379 --daemonize yes

sleep 5

# avoid master becoming a slave
redis-cli -p 6379 SLAVEOF NO ONE

redis-cli -p 6380 SLAVEOF 127.0.0.1 6379

tail -f /dev/null
