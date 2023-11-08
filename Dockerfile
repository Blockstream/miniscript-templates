FROM emscripten/emsdk:latest
EXPOSE 8080 8081
VOLUME /src
RUN git clone --depth 1 https://github.com/sipa/miniscript /src/miniscript
WORKDIR /src/miniscript
RUN make miniscript && install ./miniscript /usr/local/bin
WORKDIR /src
## RUN apt update && apt install -y vim
