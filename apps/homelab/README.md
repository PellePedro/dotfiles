# Homelab


## Docker network
Create explicit network for homelab 
```
docker network create homelab
docker network ls
```

## Docker Compose
Add reference to the network docker compose 
```
networks:
  default:
    external:
      name: homelab

```


### Nginx-Proxy-Manager
```
version: "3.8"
services:
  app:
    image: jc21/nginx-proxy-manager:latest
    restart: unless-stopped
    ports:
      - 80:80
      - 81:81
      - 443:443
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt

networks:
  homelab:
    external: true

```


Gitea
```
version: '3'
services:
  gitea:
    image: gitea/gitea:latest
    environment:
      - USER_UID=1000
      - USER_GID=1000
    restart: always
    volumes:
      - ./gitea:/data
    ports:
      - "3000:3000" # Web interface
      - "2222:22" # SSH access (mapped to avoid conflict with the host's SSH server)


networks:
  homelab:
    external: true






```




### Incus Containers Step by Step

https://discussion.scottibyte.com/t/incus-containers-step-by-step/349

```

# enter root
sudo su

mkdir -p /etc/apt/keyrings/
curl -fsSL https://pkgs.zabbly.com/key.asc -o /etc/apt/keyrings/zabbly.asc

sh -c 'cat <<EOF > /etc/apt/sources.list.d/zabbly-incus-stable.sources
Enabled: yes
Types: deb
URIs: https://pkgs.zabbly.com/incus/stable
Suites: $(. /etc/os-release && echo ${VERSION_CODENAME})
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/zabbly.asc

EOF'

apt update

# exit root
exit

sudo apt install incus -y
sudo usermod -aG incus-admin $USER
newgrp incus-admin
groups

sudo apt install -y zfsutils-linux

sudo reboot now

```



```

incus admin init
incus list
incus launch images:ubuntu/22.04 test
incus profile create bridgeprofile
incus profile device add bridgeprofile eth0 nic nictype=bridged parent=bridge0
incus launch images:ubuntu/22.04 rproxy --profile default --profile bridgeprofile
incus list
```




```
incus shell rproxy

incus profile create cloud-dev
incus profile show cloud-dev
incus profile edit cloud-dev

```
users
  - name: username
    passwd: password
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - AAAAB3NzaC1yc2EAAAADAQABAAACAQClYEDmgdGMImg2ZeVLvd1d1ke9L+tp3K4bqlnpPQaJYVvZFXW8U4KZ1dO1RPziSF2baTr3ImeW+OokMM45FPcgGAAsU0N/s38iFuC4/k2qU/qh8PGwyYMWpbS07IAxxFsfw8ozwpj5v5dmWCg4GmxamUCAYks78jZ/ZKSpmOuQ4SFkMynesJSntyMZA4H+aJX236eb/WnVQYmb2S2ZthtOwRfg2W3z9MnLR+9JTEhRQ9yBHvBDqvlsJdSqEaGye/jNmDB4ncWCZLthwL61RotAui+JHdbUBBXnTg6JZFbL0C/7LeRxi8v0kQgfbuFi9QVh49uiFM9/ym8VjQW0cpvlYXLByTLIABGr7fSW96UFRnLDZCc3i2aHbR2z/xRM+tP3izL9lcU79Q/OQiKVp1BgY6cKWZefPFjknmBIYExvIRfKC4lh6G5izerPDLgHLQXgqN0eGDK2Fh1gJzEhfDhwI78vW/hu3o4f5AolFBvxH0bFYfpePLDKtZ9UwRnNj4IA4wwrplxGXPhdHXaW8+RK674JBhwauRiqqZcgdQu8ccIHXn8oMslsNGFutpSAbvOqxV+IOpVIZbjVZOwHnOuI0SRqSMu46HHiI8Nnorbo9ayVEiFOiAkdx4Rn/cPTg136ZK7Sg7GzwWjXcKBC0zqlcWCWuammgufri4Z/N571kQ== pedro@cloud
```
