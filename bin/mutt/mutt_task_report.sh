#!/bin/bash

while :
do
  # Using double buffering to prevent screen from flickering.
  # We lose color tho :(
  output=$(task rc.verbose=label mutt) # verbose level set to a minimum
  clear
  echo "> task mutt"
  echo
  echo "$output"
  sleep 1
done
