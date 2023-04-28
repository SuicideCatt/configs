#!/usr/bin/sh

log()        { echo "SCT_CFG: $1"; }
lstatus()    { log "$1..."; }

llinking()   { lstatus "Linking $1"; }
linstaling() { lstatus "Instaling $1"; }
lupdating()  { lstatus "Updating $1"; }

ldone()      { log Done; }
lerror()     { log Error; }
lskip()      { log Skiped; }
