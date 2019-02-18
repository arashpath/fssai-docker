#!/bin/bash
image=centos ; ver=7.5.1804                               # Host CentOS Version
dir="$(dirname $(readlink -f $0))"
case "$1" in

  centos) # Official CentOS Docker Image -------------------------------------#
    docker image pull $image:$ver
    docker image tag $image:$ver fssai/$image:$ver
    docker save fssai/$image:$ver | pxz > $dir/packages/$image-$ver.tar.xz
    pxz -cd $image-$ver.tar.xz | docker load
    ;;
  
  java8) # Oracle Java -------------------------------------------------------#
    java8page="https://www.oracle.com/technetwork/java/javase/downloads\
/jdk8-downloads-2133151.html"
    java8URL=$(curl -s $java8page | awk "
      /downloads\['/ && ! /demos/ && /\['files'\]/ && /linux-x64/ && /.rpm/
      " | grep -o 'http.*\.rpm' | head -1)
    curl -L -C - -b "oraclelicense=accept-securebackup-cookie" ${java8URL} \
      -o $dir/packages/${java8URL##*/}
    ;;

  docker|nginx|node) # Docker RPMs for offline installation ------------------#
    centos_image="$image:$ver"
    docker run --rm \
      -v $dir/packages:/packages \
      $centos_image sh /packages/get_rpm.sh $1
    ;;
  
  *)
    echo "Invalid option" 
    ;;

esac