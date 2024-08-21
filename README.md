# redis-benchmark
redis-benchmark enables you to benchmark Redis performance with [redis-benchmark](https://redis.io/docs/latest/operate/oss_and_stack/management/optimization/benchmarks/) in two configurations:

1. Primary-Replica (Single Node) Configuration: Redis with 1 primary and 1 replica, with cluster mode disabled.
2. Cluster Configuration: Redis cluster mode enabled, with multiple nodes configured in a cluster, including replication for fault tolerance.

## Primary-Replica Configuration Overview
In the primary-replica configuration, the Redis setup is composed of 2 nodes: one acting as the primary (master) node and the other as the replica (slave) node.

Primary Node: Managed by Node 1 (Port 6379) as the primary node.
Replica Node: Managed by Node 2 (Port 6380) as the replica node.

## Redis Cluster Configuration Overview
In the cluster configuration, the Redis cluster is set up with 6 nodes, divided into 3 shards. Each shard is replicated across 2 nodes.

Shard 1: Managed by Node 1 (Port 6379) as primary and Node 2 (Port 6380) as replica.
Shard 2: Managed by Node 3 (Port 6381) as primary and Node 4 (Port 6382) as replica.
Shard 3: Managed by Node 5 (Port 6383) as primary and Node 6 (Port 6384) as replica.
