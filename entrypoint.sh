#!/bin/sh
set -e

if [ "$1" = 'dynamodb' ]; then
  cd /dynamodb
  exec java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb -dbPath /dynamodata -optimizeDbBeforeStartup
fi

exec "$@"