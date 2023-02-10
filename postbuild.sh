#!/bin/bash

set -e

echo "Move assets from public/prefix to public/"

# ================================================================ #

# Create a temporary directory that is cleaned up after exit.
# Copied from: https://stackoverflow.com/a/34676160
#

# the temp directory used
WORK_DIR=$(mktemp -d)

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {
  rm -rf "$WORK_DIR"
  rm -rf /public/prefix
  echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

# ================================================================ #


echo "pwd"
pwd

echo "Move files from public/ to $WORK_DIR"
mv public/prefix/* "$WORK_DIR"

echo "Move files from $WORK_DIR to public/docs"
mv "$WORK_DIR"/* public/

echo "Assets moved to public/docs"

# This wont be needed on Vercel and will probably cause an error during build once _redirects is gone
echo "Copying _redirects file to public/"
cp _redirects public/
