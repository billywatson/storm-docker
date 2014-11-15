FROM ubuntu:14.10
MAINTAINER billywatson

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN apt-get update \
 && apt-get install -y openjdk-7-jre-headless openjdk-7-jdk \
 && apt-get install -y make build-essential \
 && apt-get install -y supervisor \
 && apt-get install -y uuid-dev pkg-config libtool automake gcc g++ \
 && apt-get install -y pkg-config libtool autoconf automake git debhelper \
 && apt-get install -y zip unzip \
 && apt-get install -y curl \
 && echo [supervisord] | tee -a /etc/supervisor/supervisord.conf \
 && echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf \
 && rm -rf /var/lib/apt/lists/*

ENV STORM_HOME /usr/share/storm
ENV STORM_VERSION 0.8.1
ENV STORM_DOWNLOAD_URL https://www.dropbox.com/s/smesqx9uwa7f0qk/storm-0.8.1.zip

# Install ZeroMQ
RUN curl -sSL http://download.zeromq.org/zeromq-2.1.7.tar.gz -o zeromq-2.1.7.tar.gz \
 && tar zxvf zeromq-2.1.7.tar.gz \
 && cd zeromq-2.1.7 \
 && ./configure \
 && make \
 && make install \
 && sudo ldconfig \
 && cd ..

# Install Python ZeroMQ bindings -- optional???
# RUN curl -sSL http://pypi.python.org/packages/source/p/pyzmq/pyzmq-2.1.7.tar.gz#md5=aa4d7d81ad3c93dc1efd195153cb71ae -o pyzmq-2.1.7.tar.gz \
# && tar xvfz pyzmq-2.1.7.tar.gz \
# && cd pyzmq-2.1.7 \
# && python setup.py install \
# && cd ..

# Install JZMQ -- java bindings for ZeroMQ
RUN curl -sSL https://github.com/halfaleague/jzmq/archive/master.tar.gz -o master.tar.gz \
 && tar zxvf master.tar.gz \
 && cd jzmq-master \
 && ./autogen.sh \
 && ./configure \
 && make \
 && sudo make install \
 && cd .. \

# Install storm
RUN rm -rf /var/lib/apt/lists/* \
 && curl -sSL "$STORM_DOWNLOAD_URL" -o storm.zip \
 && unzip storm.zip -d /usr/share \
 && rm storm.zip \
 && groupadd storm \
 && useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm \
 && mkdir /var/log/storm \
 && chown -R storm:storm /var/log/storm \
 && ln -s /usr/share/storm-$STORM_VERSION $STORM_HOME \
 && ln -s $STORM_HOME/bin/storm /usr/bin/storm \
 && ln -s $STORM_HOME/logs /var/log/storm \
 && mkdir /var/lib/dhcp3/

ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD start-storm.sh /usr/bin/start-storm.sh 

VOLUME ["/var/log/storm"]

# nimbus (thrift drpc drpc.invocations)
EXPOSE 6627 3772 3773
# supervisor (slot logviewer)
EXPOSE 6700 8000
# ui
EXPOSE 8080

ENTRYPOINT ["/usr/bin/start-storm.sh"]
CMD []
