#!/bin/bash
set -e
sourcecode="$(dirname $(readlink -f $0))"
svn_path="$1"

cd $sourcecode
source .svn_pass

# Check out from SVN
svn co $svn_url/$svn_path \
  --non-interactive \
  --no-auth-cache \
  --username $svn_user \
  --password $svn_pass
