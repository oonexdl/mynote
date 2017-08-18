#!/bin/bash

##### trace bugs

set -x
number='1'

if [[ $number = '1' ]]; then
    echo "number is equal to 1"
else
    echo "number isn't equal to 1"
fi
set +x
