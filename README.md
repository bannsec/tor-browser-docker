# tor-browser-docker
Docker build for the tor browser

# Run
```bash
function tor {
  sudo docker pull bannsec/tor
  sudo docker run -it --rm -e XAUTHORITY=/authority -v $XAUTHORITY:/authority:ro -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY bannsec/tor
}
```
