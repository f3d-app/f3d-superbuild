#!/bin/bash


# Recover python version major.minor
python_version=`python --version`
python_version=`cut -d ' ' -f 2 <<< "$python_version"`
python_version=`cut -d '.' -f 1,2 <<< "$python_version"`

# Recover system information
machine=`uname -s`

# Try once in general
# Twice with macOS and python 3.12 to work around this issue:
# https://github.com/pytest-dev/pytest/issues/11647
max_retry=1
if test "$python_version" = "3.12"
then
  if test "$machine" = "Darwin"
  then
    max_retry=2
  fi
fi

# Run pytest command multiple times if needed to pass and it failed with -11
echo "Trying pytest a maximum of $max_retry times"
counter=0
until [ "$counter" -ge $max_retry ]
do
   pytest -s $1/python/testing
   retVal=$?
   if [ $retVal -ne -11 ]; then
     exit $retVal
   fi
   ((counter++))
done
