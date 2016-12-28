FROM openjdk:8-jre
MAINTAINER Martín Schonaker <mschonaker@gmail.com>

WORKDIR /

ARG ES_VERSION=1.2.4
ARG ES_CHECKSUM=c8bbe1f1975ffb6774744fadd0abb78616e96904

# Install curl
RUN apt-get install -y curl && apt-get clean

# Download and unpack elasticsearch
RUN set -ex \
   && curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz \
   && echo "$ES_CHECKSUM *elasticsearch-$ES_VERSION.tar.gz" | sha1sum -c - \
   && mkdir /elasticsearch \
   && tar zxvf elasticsearch-$ES_VERSION.tar.gz -C /elasticsearch --strip-components=1 \
   && mkdir -m 777 /elasticsearch/logs /elasticsearch/data \
   && rm elasticsearch-$ES_VERSION.tar.gz
   
WORKDIR /elasticsearch

VOLUME /elasticsearch/data
   
EXPOSE 9200 9300
CMD ["/elasticsearch/bin/elasticsearch"]
