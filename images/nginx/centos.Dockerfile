ARG OS_VER=7.5.1804
FROM fssai/centos:${OS_VER}
LABEL fssai.type="base"
ARG NGINX_VER=1.14.2
RUN echo "[nginx-stable]"                                                    > /etc/yum.repos.d/nginx.repo  \
 && echo "name=nginx stable repo"                                            >> /etc/yum.repos.d/nginx.repo \
 && echo "baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/" >> /etc/yum.repos.d/nginx.repo \
 && echo "gpgcheck=1"                                                        >> /etc/yum.repos.d/nginx.repo \
 && echo "enabled=1"                                                         >> /etc/yum.repos.d/nginx.repo \
 && echo "gpgkey=https://nginx.org/keys/nginx_signing.key"                   >> /etc/yum.repos.d/nginx.repo \
 && yum install -y nginx-${NGINX_VER} \
 && yum clean all

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
