ARG OS_VER=7.5.1804
FROM fssai/centos:${OS_VER}
LABEL fssai.type="base"

ARG JAVA_VER=8u201
ARG JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.rpm

RUN curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O ${JAVA_URL} \
 && yum -y localinstall jdk-${JAVA_VER}-linux-x64.rpm \
 && rm -vf jdk-${JAVA_VER}-linux-x64.rpm \
 && yum clean all

ENV JAVA_HOME /usr/java/default
VOLUME /tmp
ENV JAR_FILE=${JAR_FILE}
WORKDIR /services
CMD java -Djava.security.egd=file:/dev/./urandom -jar /services/${JAR_FILE}