FROM ubuntu:16.04

RUN apt-get update && apt-get install -y git-core build-essential pkg-config libtool libevent-dev libncurses-dev zlib1g-dev automake libssh-dev cmake ruby

WORKDIR /
RUN git clone https://github.com/msgpack/msgpack-c.git
WORKDIR /msgpack-c
RUN cmake . && make && make install

RUN apt install --reinstall -y software-properties-common && \
    add-apt-repository ppa:kedazo/libssh-0.7.x && \
    apt-get update && \
    apt-get install -y libssh-4

WORKDIR /
RUN git clone https://github.com/tmate-io/tmate-slave.git
WORKDIR /tmate-slave
RUN ./autogen.sh && ./configure && make

RUN mkdir -p keys
RUN ssh-keygen -t rsa -f keys/ssh_host_rsa_key -N '' -E md5
RUN ssh-keygen -t ecdsa -f keys/ssh_host_ecdsa_key -N '' -E md5

ENV LANG C.UTF-8

ENTRYPOINT ["/tmate-slave/tmate-slave", "-p", "2222"]
