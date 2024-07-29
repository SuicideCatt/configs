#!/usr/bin/sh

log()        { printf "SCT_CFG: $1"; }
lstatus()    { log "$1... "; }

llinking()   { lstatus "Linking $1"; }
linstaling() { lstatus "Instaling $1"; }
lupdating()  { lstatus "Updating $1"; }

ldone()      { printf "Done\n"; }
lerror()     { printf "Error\n"; }
lskip()      { printf "Skiped\n"; }
