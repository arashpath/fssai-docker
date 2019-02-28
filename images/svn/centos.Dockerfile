ARG OS_VER=7.5.1804
FROM centos:${OS_VER}
LABEL fssai.type="build"
RUN yum -y install subversion git && yum clean all