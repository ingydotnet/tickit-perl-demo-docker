#!/bin/sh

set -e
set -x

(
  finalize=${1:?"First argument must be true or false"}

  apks="curl wget"
  apks_dev="bash ruby vim"

  apk add --update $apks

  if ! $finalize; then
    apk add $apks_dev
    gem install gist || true
  fi

  wget https://cpan.metacpan.org/authors/id/P/PE/PEVANS/Tickit-0.56.tar.gz
  tar xzf Tickit-0.56.tar.gz
  cp Tickit-0.56/examples/*.pl /
  grep SYNOPSIS -A18 Tickit-0.56/README | tail -n 18 > /demo-hello-world.pl

  if $finalize; then
    apk del $apks
    apk del $apks_dev
    rm -fr /var/cache/apk/*

    rm -f /build.sh /docker-build.log

    rm -fr /Tickit*
  fi

  du -sh /
) 2>&1 | tee /docker-build.log
