#!/usr/bin/env bash

# Workaround XProtect race condition for "hdiutil create" for MacOS 13
# Copied from hexrdgui, BSD 3-Clause License
# Copyright (c) 2024, Kitware, Inc., Lawrence Livermore National Laboratory, and Air Force Research Laboratory.

set -e

if [ "$1" != "create" && "$1" != "detach" ]; then
  # If it isn't an `hdiutil create` or `hdiutil detach` command, just run and exit normally
  hdiutil "$@"
  exit 0
fi

# Adapted from https://github.com/actions/runner-images/issues/7522#issuecomment-1556766641
echo killing XProtect...; /usr/bin/sudo /usr/bin/pkill -9 XProtect >/dev/null || true;
while pgrep XProtect; echo waiting...; do sleep 1; done;

# Try repeatedly
# This prevents spurious errors caused by a race condition with XProtect
# See https://github.com/actions/runner-images/issues/7522
retry_limit=20
i=0
until
/usr/bin/sudo /usr/bin/hdiutil "$@"
do
if [ $i -eq $retry_limit ]; then exit 1; fi
i=$((i+1))
sleep 1
done

echo "hdiutil command completed after $i attempts."
