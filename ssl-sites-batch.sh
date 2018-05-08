#!/bin/bash

ssbdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd $ssbdir

webroot="$ssbdir/acme-challenge"
ngxsdir="$ssbdir/nginx"
certdir="$ssbdir/certs"

[ -d $webroot ] || mkdir $webroot
[ -d $ngxsdir ] || mkdir $ngxsdir
[ -d $certdir ] || mkdir $certdir

while read site
do
  # Check if cert for this site exists
  if [ ! -f "$certdir/$site/fullchain.cer" ]
  then
    echo Creating cert to $site
    ./acme.sh/acme.sh --home "$ssbdir/acme-home" --cert-home "$certdir" --issue -d $site -w $webroot &&
    sed -e "s,<SSBDIR>,$ssbdir,g" -e "s/<DOMAIN>/$site/g" "$ssbdir/nginx-template.conf" > "$ngxsdir/$site.conf"
  else
    echo Cert of $site exists. Remove $certdir/$site and try again
  fi
done < "${1:-/dev/stdin}"
