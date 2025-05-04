#!/usr/bin/env sh

if [[ "$TEMPLATE_WORLD" == "1" ]]; then
    SOURCE="./templates/paper-world-defaults.yml"
    DEST_DIR="./config"
    DEST_FILE="$DEST_DIR/paper-world-defaults.yml"

    mkdir -p "$DEST_DIR"

    if [[ -f "$SOURCE" ]]; then
        cp -u "$SOURCE" "$DEST_FILE"
        echo "The file has been copied to $DEST_FILE"
    else
        echo "Error: File $SOURCE not found."
        exit 1
    fi
else
    echo "Variable TEMPLATE_WORLD is not equal to 1. Copying skipped."
fi

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


java -Xms${MEMORY} -Xmx${MEMORY} -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui