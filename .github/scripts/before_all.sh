#!/bin/bash

set -e -u

sccache --start-server
sccache --stop-server
