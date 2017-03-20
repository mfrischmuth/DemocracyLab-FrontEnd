FROM ubuntu:16.04


RUN apt-get update \
&& apt-get install -y --no-install-recommends \
git-core ssh ca-certificates build-essential libssl-dev curl

RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
RUN chmod 755 ./nodesource_setup.sh
RUN ./nodesource_setup.sh

RUN apt-get install -y --no-install-recommends nodejs

#RUN apt-get install -y --no-install-recommends npm

RUN git config --global http.sslVerify true
WORKDIR /
RUN git clone https://github.com/dheeti/churchill
WORKDIR /churchill
RUN npm config set loglevel warn
RUN npm install
WORKDIR /churchill/deploy
RUN pwd
RUN chmod 755 ./build_dev.sh
RUN ./build.sh
ENTRYPOINT ["bash","/churchill/deploy/run.sh"]
