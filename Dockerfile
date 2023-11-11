FROM emscripten/emsdk:latest as base
RUN apt-get update
FROM base as systemd
RUN apt-get install systemd -y
RUN chmod +x /usr/bin/systemctl
FROM systemd as pandoc
RUN apt-get install pandoc -y
FROM pandoc as docker
RUN apt-get install docker.io -y
FROM docker as clone
EXPOSE 8080 8081
VOLUME /src
RUN git clone --depth 1 https://github.com/sipa/miniscript /src/miniscript
FROM clone as make
WORKDIR /src/miniscript
RUN make miniscript
FROM make as install
RUN install ./miniscript /usr/local/bin
WORKDIR /src
FROM install as miniscript
COPY --from=clone /src /src
ENV PATH=$PATH:/usr/bin/systemctl
RUN ps -p 1 -o comm=
EXPOSE 8080 8081
