FROM alpine:3.7

RUN adduser -D -h /home/ts3 ts3 && \
    apk --update --no-cache add \
                            wget \
                            bzip2 \
                            ca-certificates && \
    cd /home/ts3 && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk && \
    apk add glibc-2.23-r3.apk && \
    wget http://dl.4players.de/ts/releases/3.0.13.8/teamspeak3-server_linux_amd64-3.0.13.8.tar.bz2 && \
    tar xfvj teamspeak3-server_linux_amd64-3.0.13.8.tar.bz2 && \
    rm -rf teamspeak3-server_linux_amd64-3.0.13.8.tar.bz2 && \
    chown -R ts3:ts3 teamspeak3-server_linux_amd64 && \
    apk del wget bzip2 ca-certificates && \
    cd / && \
    ln -s /home/ts3/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh

USER ts3

CMD ["/ts3server_minimal_runscript.sh", "start"]
