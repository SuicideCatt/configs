#!/bin/sh
sed -i \
         -e 's/#323232/rgb(0%,0%,0%)/g' \
         -e 's/#ebebeb/rgb(100%,100%,100%)/g' \
    -e 's/#505050/rgb(50%,0%,0%)/g' \
     -e 's/#895aa2/rgb(0%,50%,0%)/g' \
     -e 's/#2b2b2b/rgb(50%,0%,50%)/g' \
     -e 's/#ebebeb/rgb(0%,0%,50%)/g' \
	"$@"
