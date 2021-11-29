ARG CENTOS_VER=7.9.2009
FROM fssai/centos:${CENTOS_VER}

ARG NODE_VER=10.15.1 
ARG YARN_VER=1.13.0

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
 && curl -sL https://dl.yarnpkg.com/rpm/yarn.repo -o /etc/yum.repos.d/yarn.repo \
 && yum install -y gcc-c++ make \
 && yum install -y nodejs-${NODE_VER} \
 && yum install -y yarn-${YARN_VER} \
 && yum clean all

CMD [ "node" ]