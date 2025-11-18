#!/bin/sh

host="$1"
port="$2"
shift 2
cmd="$@"

echo "Waiting $host:$port..."

while ! nc -z -w 1 "$host" "$port"; do
  sleep 1
done

echo "$host:$port is available now, running: $cmd"

exec $cmd
