#!/bin/bash

# プロジェクトのホームディレクトリへ移動
cd "$(dirname "$0")/.." || exit 1
current="$(pwd)"

# テスト実行
flutter test --coverage &&

  # HTML生成
  genhtml coverage/lcov.info -o coverage/html &&

  # 引数の1番目がwebならブラウザで開く
  if [ "$1" = "web" ]; then
    open "file://$current/coverage/html/index.html"
  fi
