#!/bin/bash
if [ $# -ne 1 ]; then
  echo "引数が設定されていません。"
  exit 1
fi

# 引数から渡されたデバイス名
DEVICE_NAME=$1
printf " - Device:\t %s \n" "$DEVICE_NAME"

FIND_REGEX=".*\(([0-9A-Z-]+)\)$"
UDID=$(
  xcrun xctrace list devices | grep "${DEVICE_NAME} Simulator" |
    grep -v "Apple Watch" |
    sed -r "s/$FIND_REGEX/\1/"
)
echo "UDID: $UDID"

flutter pub get
cd ios || exit 1
pod install
cd ../
flutter drive --target=test_driver/app.dart -d "$UDID"
