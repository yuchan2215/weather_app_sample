import 'package:flutter/material.dart';
import 'package:weather_app_sample/constant/debug_keys.dart';

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
            contentPadding: EdgeInsets.all(12),
            title: Text(title),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(desc),
              TextField(
                key: apiKeyTextFieldKey,
                onChanged: (v) => text = v,
              )
            ]),
            actions: <Widget>[
              TextButton(
                key: opBtnKey,
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
