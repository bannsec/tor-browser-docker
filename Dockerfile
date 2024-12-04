FROM ubuntu:latest

# sudo docker run -it --rm -e XAUTHORITY=/authority -v $XAUTHORITY:/authority:ro -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY bannsec/tor

ENV DEBIAN_FRONTEND=noninteractive

# Fix for tzdata install issue
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt dist-upgrade -y && \
    apt install -y curl xz-utils zenity libdbus-glib-1-2 libxt6

RUN URL=`curl https://www.torproject.org/download/ | grep -i downloadLink | egrep -o 'href="(.+?)linux-x86_64(.+?)"' | head -1 | cut -f 2 -d '"'` && \
    curl -L https://www.torproject.org/$URL > browser && \
    tar xf browser && rm browser && \
    useradd -m -s /bin/bash tor && \
    chown -R tor /tor-browser

USER tor

CMD ["/tor-browser/Browser/start-tor-browser"]
