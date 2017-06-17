FROM openjdk:8-jre
MAINTAINER Keith Adkins <keithdadkins@me.com>

ENV DYNODB_PATH "/dynodb"
ENV DYNAMO_LINK 'https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz'
ENV DYNAMO_FILE "dynamodb_local_latest.tar.gz"

# apply latest patches unless you are maintaining your own base image
#RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# add our entrypoint script and add our dyno folders
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh && \
	mkdir -p /dynamodb && \
	mkdir -p /tmp/dynamo

# download, verify, and extract dynamodb
WORKDIR /tmp/dynamo
RUN wget "$DYNAMO_LINK" && \
	wget "${DYNAMO_LINK}.sha256" && \
	sha256sum -c "${DYNAMO_FILE}.sha256" > /dev/null 2>&1 && \
	tar -xzf $DYNAMO_FILE -C /dynamodb && \
	cd / && \
	rm -rf /tmp/dynamo

# RUN
EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh", "dynamodb"]
