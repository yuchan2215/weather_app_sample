#!/bin/bash
if [ $# -ne 1 ]; then
  echo "引数が設定されていません。"
  exit 1
fi

# 引数から渡されたデバイス名
DEVICE_NAME=$1
printf " - Device:\t %s \n" "$DEVICE_NAME"

# UDIDを探すための正規表現
UDID_REGEX=".*\(([0-9A-Z-]+)\)$"

#UDIDの検索
UDID="$(
  xcrun xctrace list devices | grep "$DEVICE_NAME Simulator" |
    grep -v "Apple Watch" |
    sed -r "s/$UDID_REGEX/\1/"
)"
printf " - UDID:\t %s \n" "$UDID"

# Statusを探すための正規表現
STATUS_REGEX="^.*\(${UDID}\).*\(([a-zA-Z]*)\).*$"

STATUS="$(xcrun simctl list | grep "$UDID" | grep -v "Phone:" | sed -r "s/$STATUS_REGEX/\1/")"
printf " - Status:\t %s\n" "$STATUS"

# すでに起動していたらスキップする
test "$STATUS" = "Booted" && echo "すでに起動されているため、起動処理ををスキップします。" && exit 0

echo "エミュレータを起動します"
xcrun simctl boot "${UDID:?No Simulator with this name found}" > /dev/null

echo "エミュレータの起動を待機しています"
xcrun simctl bootstatus "${UDID:?No Simulator with this name found}" > /dev/null
echo "エミュレータが起動しました！"
