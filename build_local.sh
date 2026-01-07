#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./build_local.sh [left|right|reset]"
  exit 1
fi

SIDE=$1
SHIELD=""

if [ "$SIDE" == "left" ]; then
  SHIELD="charybdis_left"
elif [ "$SIDE" == "right" ]; then
  SHIELD="charybdis_right"
elif [ "$SIDE" == "reset" ]; then
  SHIELD="settings_reset"
else
  echo "Invalid argument. Use: left, right, or reset"
  exit 1
fi

echo "Building $SIDE ($SHIELD)..."

CMD="west build -s /workspace/zmk/zmk/app -d /workspace/zmk/build/$SIDE -b nice_nano -- -DSHIELD=$SHIELD -DZMK_CONFIG=/workspace/config/config -DBOARD_ROOT=/workspace/config && cp /workspace/zmk/build/$SIDE/zephyr/zmk.uf2 /workspace/firmware/$SHIELD.uf2 && echo 'Build Successful! Saved to firmware/$SHIELD.uf2'"

docker compose exec zmk bash -c "$CMD"
