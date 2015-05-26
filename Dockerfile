############################################################
# Dockerfile to run urbackup-client
# Based on Ubuntu Image
############################################################

FROM ubuntu:trusty
MAINTAINER Johnny Antonsen <johnny@jumpingmushroom.com>

ENV VERSION 1.4.7

RUN	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install libcrypto++-dev build-essential wget && \
	cd /root && \
	wget -O - http://netcologne.dl.sourceforge.net/project/urbackup/Server/$VERSION/urbackup-server-$VERSION.tar.gz | tar zxf - && \
	cd urbackup* && \
	./configure --enable-headless --without-mail && \
	make -j 4 && \
	make install && \
	cd /root/ && \
	rm -rf urbackup*

# Ports to expose
EXPOSE 35621
EXPOSE 35622
EXPOSE 35623

VOLUME /data

ENTRYPOINT ["/usr/local/sbin/start_urbackup_client"]
CMD ["--no_daemon"]
