#!/bin/bash

trap "echo hello" EXIT;
while true; do
  echo "while";
done
 
