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
  docker run --rm -v $dir/build/sourcecode:/sourcecode \
    fssai/svn bash /sourcecode/get_source.sh $1   
}

main () {
  images_base # Build all base images and export in tar File ---------| STEP 01
  images_build # Build required images for building from source code -| STEP 02
  get_source "Frontend" # Checkout latest frontend source code -------| STEP 03

}

main
