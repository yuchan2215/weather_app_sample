import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app_sample/constant/debug_keys.dart';
import 'package:weather_app_sample/constant/storage_keys.dart';
import 'package:weather_app_sample/core/api_key.dart';
import 'package:weather_app_sample/core/secure_storage.dart';
import 'package:weather_app_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('apiKeyTest', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    const testKey = "hogehoge";

    //APIキーをリセットする
    await SecureStorage.storage.write(key: apiKeyStorageKey, value: null);
    ApiKey.key = null;
    expect(ApiKey.key, null);

    //Drawerを開く
    await tester.tap(find.byKey(drawerKey));
    await tester.pumpAndSettle();

    //APIキーの設定を開く
    await tester.tap(find.byKey(settingApiKeyOpenKey));
    await tester.pumpAndSettle();

    //APIキーの入力をアクティブにする
    await tester.tap(find.byKey(apiKeyTextFieldKey));
    await tester.pumpAndSettle();

    //APIキーを入力する
    await tester.enterText(find.byKey(apiKeyTextFieldKey), testKey);
    await tester.pumpAndSettle();


    //OKボタンを押す
    await tester.tap(find.byKey(opBtnKey));
    await tester.pumpAndSettle();


    //ローカル保存チャック
    expect(ApiKey.key, testKey);

    //サーバー保存チェック
    String? loadKey = await SecureStorage.storage.read(key: apiKeyStorageKey);
    expect(loadKey, testKey);
  });
}
