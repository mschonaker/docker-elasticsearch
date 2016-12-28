FROM openjdk:8-jre
MAINTAINER Martín Schonaker <mschonaker@gmail.com>

WORKDIR /

# Install curl
RUN apt-get install -y curl && apt-get clean

# Download and unpack elasticsearch
RUN set -ex \
   && curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.tar.gz \
   && echo "e74d80d79269bb224153ad63b45f1cf7448f3398 *elasticsearch-1.2.1.tar.gz" | sha1sum -c - \
   && mkdir /elasticsearch \
   && tar zxvf elasticsearch-1.2.1.tar.gz -C /elasticsearch --strip-components=1 \
   && mkdir -m 777 /elasticsearch/logs /elasticsearch/data \
   && rm elasticsearch-1.2.1.tar.gz
   
WORKDIR /elasticsearch

VOLUME /elasticsearch/data
   
EXPOSE 9200 9300
CMD ["/elasticsearch/bin/elasticsearch"]
