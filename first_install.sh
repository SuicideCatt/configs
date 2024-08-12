#!/usr/bin/bash

echo "Specific configs: pc laptop"
printf "Select specific config: "
read CFG

./select.sh $CFG

./install.sh

chch -s /usr/bin/zsh
