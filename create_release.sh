#!/bin/bash
dir="$(dirname $(readlink -f $0))"
#source $dir/images/.env

#release="$(date +%y%m%d%H%M)"
#echo $release

images_base() { # ----------------- Images to deploy containers in Production #
  echo "Creating Base Images..."
  cd $dir/images/; docker-compose build
  echo "Base Images Created"
  docker image ls --filter label="fssai.type=base" 
  docker image save -o $dir/deploy/base_images.tar $(
    docker image ls --filter label="fssai.type=base" | awk '/^fssai/{print $1}'
  )
}

images_build() { # ----------- Images for building from sourcecode in Staging # 
  echo "Creating Build Images..."
  cd $dir/images/; docker-compose -f build.docker-compose.yml build
  echo "Build Images Created"
  docker image ls --filter label="fssai.type=build"
}

get_source() { # ------------------------------ Checkout latest code from SVN #
  echo "SVN Checkout $1 Source Code..."
  docker run --rm -v $dir/build:/build \
    fssai/svn bash /build/get_source.sh $1   
}

build_web() { # ---------------------------------- Build Frontend from Source #
  get_source "Frontend" 
  echo "Building Frontend..."
  cd $dir/build/; docker-compose up -d --build 
}

main () {
  images_base # Create base images and export in tar File ------------| STEP 01
  images_build # Create images for building source code --------------| STEP 02
  build_web # Build Frontend from latest svn source code -------------| STEP 03
}

main
