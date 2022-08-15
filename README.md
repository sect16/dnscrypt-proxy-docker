# dnscrypt-proxy-docker
A dnscrypt-proxy docker container for Raspberrypi OS Bullseye.
# Usage
Build the image yourself using Dockerfile:

```
git clone https://github.com/sect16/dnscrypt-proxy-docker.git
cd dnscrypt-proxy-docker
sudo docker build -t dnscrypt-proxy .
```

Or pull image from docker hub:

```
docker pull sect16/dnscrypt-proxy:latest
```

# Starting the container
DNS query are normally served on port 53. The follow container binds on the host port 5350 intended for use with Pi-Hole.
```
docker run -dt -p 5350:53/udp -p 5350:53/tcp --name dnscrypt-proxy --restart unless-stopped sect16/dnscrypt-proxy:latest
```

# Troubleshooting
Timezone can be edited inside Dockerfile.

To open container console use:
```
docker exec -it dnscrypt-proxy sh
```
