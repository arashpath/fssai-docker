# Setup Docker in an air-gapped environment
> This repository is for using Docker in an air-gapped environment like [MeghRaj National Cloud by NIC](https://cloud.gov.in) where production systems are not connected to the open Internet.

## FSSAI Images

| Images | Version |
|-------|--------:|
|[![CentOS](https://img.shields.io/docker/pulls/fssai/centos.svg?link=https://hub.docker.com/r/fssai/centos&colorB=green&label=CentOS&logoColor=brightgreen&style=popout-square&logo=linux)](https://hub.docker.com/r/fssai/centos) | 7.9.2009 |
|[![Nginx](https://img.shields.io/docker/pulls/fssai/nginx.svg?colorB=green&label=Nginx&logoColor=brightgreen&style=popout-square&logo=nginx)](https://hub.docker.com/r/fssai/nginx) | 1.14.2 |
|[![Node.js](https://img.shields.io/docker/pulls/fssai/node.svg?colorB=green&label=Node.js&logoColor=brightgreen&style=popout-square&logo=Node.js)](https://hub.docker.com/r/fssai/node) | 10.15.1 |
|[![Oracle Java SE](https://img.shields.io/docker/pulls/fssai/java.svg?colorB=green&label=Java&logoColor=brightgreen&style=popout-square&logo=java)](https://hub.docker.com/r/fssai/java) | 8u301 |
|[![Maven](https://img.shields.io/docker/pulls/fssai/maven.svg?colorB=green&label=Maven&logoColor=brightgreen&style=popout-square&logo=khan%20academy)](https://hub.docker.com/r/fssai/maven) | 3.8.4 |
|[![PostgreSQL](https://img.shields.io/docker/pulls/fssai/postgres.svg?colorB=green&label=PostgreSQL&logoColor=brightgreen&style=popout-square&logo=postgresql)](https://hub.docker.com/r/fssai/postgres) |To build|

----------------
## TO DO LIST
- [x] Install Docker Offline
- [ ] Build Base Images
  - FROM scratch
    - [x] [CentOS](https://hub.docker.com/r/fssai/centos)
      - [x] [nodeJS + YARN](https://hub.docker.com/r/fssai/node)
      - [x] [NGINX](https://hub.docker.com/r/fssai/nginx)
      - [x] [JAVA](https://hub.docker.com/r/fssai/java)
        - [x] [MAVEN](https://hub.docker.com/r/fssai/maven)
      - [ ] PostgreSQL
- [ ] Create `Dockerfile` and `docker-compose.yml` for all services
  - [x] [Web - Dockerfile Build in nodeJS and deploy in Nginx](./app/web/Dockerfile)
  - [ ] Spring Cloud Services
  - [ ] PostgreSQL DB Cluster  
- [ ] Create Private Docker Registry
