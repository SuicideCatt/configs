#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#323232/g' \
         -e 's/rgb(100%,100%,100%)/#ebebeb/g' \
    -e 's/rgb(50%,0%,0%)/#505050/g' \
     -e 's/rgb(0%,50%,0%)/#895aa2/g' \
 -e 's/rgb(0%,50.196078%,0%)/#895aa2/g' \
     -e 's/rgb(50%,0%,50%)/#2b2b2b/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#2b2b2b/g' \
     -e 's/rgb(0%,0%,50%)/#ebebeb/g' \
	"$@"
