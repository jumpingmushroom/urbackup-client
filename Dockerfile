############################################################
# Dockerfile to run urbackup-client
# Based on Ubuntu Image
############################################################

FROM ubuntu:trusty
MAINTAINER Johnny Antonsen <johnny@jumpingmushroom.com>

RUN	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install libcrypto++-dev build-essential wget && \
	cd /root && \
	wget -O - http://netcologne.dl.sourceforge.net/project/urbackup/Server/1.4.7/urbackup-server-1.4.7.tar.gz | tar zxf - && \
	cd urbackup* && \
	./configure --enable-headless --without-mail && \
	make && \
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
