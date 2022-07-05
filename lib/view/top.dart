import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app_sample/component/string_from_dialog.dart';
import 'package:weather_app_sample/component/toast_widget.dart';
import 'package:weather_app_sample/core/api_key.dart';

import '../constant/debug_keys.dart';

class MyHomePage extends ConsumerWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FToast fToast = FToast().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("お天気アプリ"),
        leading: IconButton(
          key: drawerKey,
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: drawer(fToast, context, ref),
      body: const Center(child: Text("Hello")),
    );
  }

  Drawer drawer(FToast fToast, BuildContext context, WidgetRef ref) => Drawer(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                child: Text("お天気アプリ"),
              ),
              ListTile(
                key: settingApiKeyOpenKey,
                title: const Text("APIキーの設定"),
                onTap: () => showApiKeyConfiguration(fToast, context, ref),
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
    ).then((v) async {
      fToast.removeCustomToast();
      fToast.removeQueuedCustomToasts();
      if (v == null || v.isEmpty) {
        fToast.showToast(
          child: const ToastWidget(
            message: "キャンセルしました",
            backgroundColor: Colors.amber,
            textColor: Colors.black,
            icon: Icons.warning_amber,
          ),
        );
      } else {
        await ApiKey.saveStorage(v);
        fToast.showToast(
          child: ToastWidget(
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryTextTheme.bodyText1?.color,
            message: "保存に成功しました",
            icon: Icons.check_circle_outline,
          ),
        );
      }
    });
  }
}
