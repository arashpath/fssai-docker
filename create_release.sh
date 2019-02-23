#!/bin/bash
dir="$(dirname $(readlink -f $0))"
#source $dir/images/.env

#release="$(date +%y%m%d%H%M)"
#echo $release

base_images() { # ------------ Base Images to deploy containers in Production #
  echo "Creating Base Images..."
  cd $dir/images/; docker-compose build
  echo "Base Images Created"
  docker image ls --filter label="fssai.type=base" 
  docker image save -o $dir/deploy/base_images.tar $(
    docker image ls --filter label="fssai.type=base" | awk '/^fssai/{print $1}'
  )
}

build_images() { # ------ Build Images for building sourcecode in Development # 
  echo "Creating Build Images..."
  cd $dir/images/; docker-compose -f build.dokcer-compose.yml build
  echo "Build Images Created"
  docker image ls --filter label="fssai.type=build"
}

#base_images
#build_images
main () {
  base_images # Build all base images and export in tar File ---------| STEP 01
  build_images # Build required images for building from source code -| STEP 02
}

main