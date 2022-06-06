FROM emscripten/emsdk:3.1.8
RUN apt-get update
RUN apt-get install -y autoconf libtool
