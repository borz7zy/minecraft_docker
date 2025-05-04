#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: Argument CORE_NAME is not provided."
  exit 1
fi

CORE_NAME="$1"

if [ -z "$CORE_NAME" ]; then
  echo "Error: Environment variable CORE_NAME is not set."
  exit 1
fi

extension="${CORE_NAME##*.}"

source_file="./core/$CORE_NAME"

if [ ! -f "$source_file" ]; then
  echo "Error: File '$source_file' does not exist."
  exit 1
fi

mv "$source_file" "./server.$extension"

echo "File '$source_file' successfully moved to './server.$extension'."
