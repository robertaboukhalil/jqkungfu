FROM ubuntu:18.04
# docker build -t vanessa/jqkungfu .
RUN apt-get update && apt-get install -y git nginx build-essential python autoconf automake libtool bc
WORKDIR /opt
RUN git clone https://github.com/emscripten-core/emsdk.git && \
    cd emsdk && \
    git pull && \
    ./emsdk install latest && \
    ./emsdk activate latest

ENV PATH /opt/emsdk:/opt/emsdk/fastcomp/emscripten:/opt/emsdk/node/12.9.1_64bit/bin:$PATH

WORKDIR /var/www/html
COPY . /var/www/html
RUN /bin/bash compile.sh
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
