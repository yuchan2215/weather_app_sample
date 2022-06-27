import 'package:flutter/material.dart';

/// ダイアログを表示して、[String]型の入力を受け取ります。
/// タイトルは[title]、説明は[desc]に入力します。
/// 入力完了後のボタンのテキストは[okBtnText]にて指定します。
Future<String?> getStringFromDialog(BuildContext context,
    {required String title,
    required String desc,
    String okBtnText = "完了"}) async {
  String? inputText = await showDialog<String?>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        String text = ""; //入力されたテキストを一時的に格納しておく。
        return AlertDialog(
            title: Text(title),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text(desc), TextField(onChanged: (v) => text = v)]),
            actions: <Widget>[
              TextButton(
                child: Text(okBtnText),
                onPressed: () {
                  //入力値をpopする
                  Navigator.pop(context, text);
                },
              ),
            ]);
      });
  return Future<String?>.value(inputText);
}
