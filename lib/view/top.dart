import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app_sample/component/string_from_dialog.dart';
import 'package:weather_app_sample/component/toast_widget.dart';
import 'package:weather_app_sample/model/setting_state.dart';
import 'package:weather_app_sample/viewmodel/setting_notifier.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("お天気アプリ"),
      ),
      drawer: drawer(),
      body: Center(child: Text("Hello")),
    );
  }

  Drawer drawer() => Drawer(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                child: Text("お天気アプリ"),
              ),
              ListTile(
                title: const Text("APIキーの設定"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("地域の設定"),
                onTap: () {},
              )
            ],
          ),
        ),
      );

  /// APIキーを設定するためのウィンドウを開きます。
  /// [FToast]を使用します。
  void showApiKeyConfiguration(
      FToast fToast, BuildContext context, WidgetRef ref) {
    getStringFromDialog(
      context,
      title: "APIキーの設定",
      desc: "APIキーを入力してください。",
    ).then((v) {
      fToast.removeCustomToast();
      fToast.removeQueuedCustomToasts();
      if (v == null || v.isEmpty) {
        fToast.showToast(
          child: const ToastWidget(
            message: "APIキーの編集をキャンセルしました。",
            backgroundColor: Colors.amber,
            textColor: Colors.black,
            icon: Icons.warning_amber,
          ),
        );
      } else {
        ref.read(settingProvider.notifier).updateApiKey(v);
        fToast.showToast(
          child: ToastWidget(
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryTextTheme.bodyText1?.color,
            message: "APIキーの保存に成功しました。",
            icon: Icons.check_circle_outline,
          ),
        );
      }
    });
  }
}
