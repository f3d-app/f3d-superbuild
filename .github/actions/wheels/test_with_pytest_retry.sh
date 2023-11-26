#!/bin/bash

# Run pytest command two times if needed to pass
max_retry=2
counter=0
until pytest -s $1/python/testing 
do
   [[ counter -eq $max_retry ]] && echo "Failed!" && exit 1
   echo "Trying again. Try #$counter"
   ((counter++))
done
