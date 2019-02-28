## Install Docker
```bash
yum remove docker \ 
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

curl https://download.docker.com/linux/centos/docker-ce.repo \
  -o /etc/yum.repos.d/docker-ce.repo

yum install -y docker-ce --downloadonly
tar /var/cache/yum/x86_64/7
```

# Application Deployment

1. Install Docker
2. Clone Deployment Scripts
   ```bash
   git clone https://github.com/arashpath/fssai-docker.git
   cd fssai-docker/ ; git checkout deploy
   ``` 
3. Create SVN Password File at `build/.svn_pass`
   ```bash
   svn_url=
   svn_user=
   svn_pass=
   ```
4. Run Script
   ```bash
   ./create_release.sh
   ```

## Shipping Images
   ```bash
   image=centos ; ver=7.5.1804
   docker save fssai/$image:$ver | pxz > $image-$ver.tar.xz
   pxz -cd $image-$ver.tar.xz | docker load
   ```