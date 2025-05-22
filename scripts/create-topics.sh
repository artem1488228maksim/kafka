#!/bin/bash

PARTITIONS=3
REPLICATION_FACTOR=1
RETENTION_MS=604800000

while IFS= read -r topic; do
  if [[ -n "$topic" && ! "$topic" =~ ^# ]]; then
    echo "Creating topic: $topic"
    kafka-topics --bootstrap-server kafka:9092 --create \
      --topic "$topic" \
      --partitions $PARTITIONS \
      --replication-factor $REPLICATION_FACTOR \
      --config retention.ms=$RETENTION_MS
  fi
done < /topics.txt

echo "Available topics:"
kafka-topics --bootstrap-server kafka:9092 --list
