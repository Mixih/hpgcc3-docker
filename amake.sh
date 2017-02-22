#!/bin/env bash
set -e

python /hpgcc3/conf.py
cp /hpgcc3/makefile build/
cd build
make
