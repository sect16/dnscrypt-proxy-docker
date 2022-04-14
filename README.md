# dnscrypt-proxy-docker
A custom dnscrypt-proxy docker container for Raspberrypi OS Bullseye.
# Usage
Build the image:

```
sudo docker build -t dnscrypt-proxy .
```

# Starting the container
DNS query are normally served on port 53. The follow container binds on the host port 5350 intended for use with Pi-Hole.
```
docker run -dt -p 5350:53/udp -p 5350:53/tcp --name dnscrypt-proxy --restart unless-stopped dnscrypt-proxy
```

# Troubleshooting
Timezone can be edited inside Dockerfile.

To open container console use:
```
docker exec -it dnscrypt-proxy sh
```
