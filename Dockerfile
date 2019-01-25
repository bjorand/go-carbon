FROM golang

WORKDIR /go/src/github.com/go-graphite/go-carbon

COPY . .

RUN make submodules && make

FROM busybox

RUN mkdir -p /data/graphite/whisper/
COPY --from=0 /go/src/github.com/go-graphite/go-carbon/go-carbon /usr/sbin
CMD ["go-carbon", "-config", "/data/graphite/carbon.conf"]

EXPOSE 2003 2004 7002 7007 2003/udp
VOLUME /data/graphite/
