ARG CENTOS_VER=7.9.2009
FROM fssai/centos:${CENTOS_VER}

ARG JAVA_VER=8u301
ARG JAVA_URL=http://fssaigov.in/java

RUN yum install -y ${JAVA_URL}/jre-${JAVA_VER}-linux-x64.rpm && yum clean all

ENV JAVA_HOME /usr/java/default