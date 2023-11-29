#!/bin/bash
set -uo pipefail

# Get Python major.minor version
python_version=$(python --version)
python_version=${python_version#* }
python_version=${python_version%.*}
echo "Python version: $python_version"

# Recover system information
machine=$(uname -s)

# Try once in general
# Twice with macOS and python 3.12
max_retry=1
if [[ $python_version == '3.12' && $machine == 'Darwin' ]]
then
  max_retry=2
fi

# Run pytest command multiple times if needed to pass
echo "Trying pytest a maximum of $max_retry times"
counter=0
while [[ $counter -lt $max_retry ]]
do
  # Exit if the test succeeds.
  pytest -s "$1/python/testing"
  result=$?
  echo $result
  if [[ result -eq 11 ]]
  then
   ((counter++))
   echo "Try $counter failed! Tries remaining: $((max_retry - counter))"
   continue
  else
    echo "Not retrying"
    exit $result
  fi
done
