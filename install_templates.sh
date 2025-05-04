#!/bin/bash

if [[ "$TEMPLATE_WORLD" == "1" ]]; then
    SOURCE="./templates/paper-world-defaults.yml"
    DEST_DIR="./config"
    DEST_FILE="$DEST_DIR/paper-world-defaults.yml"

    mkdir -p "$DEST_DIR"

    if [[ -f "$SOURCE" ]]; then
        cp -u "$SOURCE" "$DEST_FILE"
        echo "The file has been copied to$DEST_FILE"
    else
        echo "Error: File $SOURCE not found."
        exit 1
    fi
else
    echo "Variable TEMPLATE_WORLD is not equal to 1. Copying skipped."
fi
