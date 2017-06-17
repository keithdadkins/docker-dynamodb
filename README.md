# docker-dynamodb
Run a local dynamodb instance in a docker container.

Image is built using the binaries downloaded from http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html

## Setup

1. Install Docker [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)
1. Install [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)
1. Clone my repo and build the docker image:

```bash
git clone git@github.com:keithdadkins/docker-dynamodb.git
cd docker-dynamodb
docker build -t mydynamo .
docker run -p 8000:8000 --name=dynamo1 mydynamo
```

__Persistant Data__
If you want your dynamo data to persist after you stop a container, do:

```bash
docker volume create --opt o=size=5GB dynamodata
docker run -p 8000:8000 -v /dynamodata:/dynamodata mydynamo
```

## Usage

Once the dynamodb container is running you can interact with it using the same aws cli commands as you would the hosted version. However; you will need to append the local endpoint each time you run an `aws dynaodb` command. *There does not appear to be an environment variable you can set to bypass this. E.g.,:

```bash
export DOCKER_IP=192.168.99.100
aws dynamodb list-tables --endpoint-url http://$DOCKER_IP:8000
```

Using the `create-table-movies.json` sample file to create a table:

```
export DOCKER_IP=192.168.99.100
aws dynamodb create-table --cli-input-json file://create-table-movies.json --endpoint-url http://$DOCKER_IP:8000
aws dynamodb list-tables --endpoint-url http://$DOCKER_IP:8000
```
