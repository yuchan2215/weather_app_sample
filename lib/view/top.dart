import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
}
