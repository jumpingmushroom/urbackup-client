############################################################
# Dockerfile to run urbackup-client
# Based on Ubuntu Image
############################################################

FROM ubuntu:trusty
MAINTAINER Johnny Antonsen <johnny@jumpingmushroom.com>

VOLUME /data

RUN	apt-get update && \
	apt-get upgrade && \
	apt-get install -y libcrypto++-dev build-essential && \
	cd /root && \
	wget http://netcologne.dl.sourceforge.net/project/urbackup/Server/1.4.7/urbackup-server-1.4.7.tar.gz && \
	tar zxvf urbackup* && \
	cd urbackup* && \
	./configure --enable-headless && \

# Ports to expose
EXPOSE 35621
EXPOSE 35622
EXPOSE 35623

ENTRYPOINT ["/usr/local/sbin/start_urbackup_client"]
CMD ["--no_daemon"]
