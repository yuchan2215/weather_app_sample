import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app_sample/core/api_key.dart';
import 'package:weather_app_sample/view/top.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _load(), //async function
        builder: (context, sc) {
          if (sc.hasData) {
            return const MyHomePage();
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }

  Future<bool> _load() async {
    debugPrint("_loadが呼び出されたよ！");
    await ApiKey.loadStorage(const FlutterSecureStorage());
    return Future<bool>.value(true);
  }
}
