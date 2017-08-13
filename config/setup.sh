#!/bin/bash

for f in $(pwd)/*; do
  if [[ -d $f ]]; then
    cd $f
    ./setup.sh
    echo "$f done!"
  fi
done
