#!/bin/bash

if [ ! -d "/var/lib/pgsql/16/data" ]; then
  /usr/pgsql-16/bin/postgresql-16-setup initdb
fi

/usr/pgsql-16/bin/postgres -D /var/lib/pgsql/16/data > /var/log/postgres.log 2>&1 &

/opt/kafka/bin/zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties
sleep 3
/opt/kafka/bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties

/opt/spark/sbin/start-master.sh
/opt/spark/sbin/start-worker.sh spark://localhost:7077

tail -f /dev/null
