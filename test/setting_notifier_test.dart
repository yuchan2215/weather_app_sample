import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:weather_app_sample/exceptions/item_is_exist.dart';
import 'package:weather_app_sample/exceptions/item_is_not_exist.dart';
import 'package:weather_app_sample/viewmodel/setting_notifier.dart';

void main() {
  late SettingNotifier target;

  setUp(() {
    final container = ProviderContainer();
    target = container.read(settingProvider.notifier);
  });
  test("エラーのテスト",(){
    ItemIsNotExistException("").toString();
    ItemIsExistException("").toString();
  });
  test("APIキー関連動作のテスト", () {
    expect(target.debugState.apiKey, null);
    var testApiKey = "TestTest";
    target.updateApiKey(testApiKey);
    expect(target.debugState.apiKey, testApiKey);
  });
  test("地域動作のテスト", () {
    expect(target.debugState.regions, null);
    var testRegion1 = "Tokyo";
    var testRegion2 = "Osaka";

    // 足してみる
    target.addRegion(testRegion1);
    expect(target.debugState.regions![0], testRegion1);

    target.addRegion(testRegion2);
    expect(target.debugState.regions![1], testRegion2);

    // もう一度足してみるとエラーになる。
    expect(() => target.addRegion(testRegion1),
        throwsA(isA<ItemIsExistException>()));

    // 消してみる
    target.removeRegion(testRegion1);
    // 残っているのは地域2のはず
    expect(target.debugState.regions!.first, testRegion2);

    // もう消せないはず
    expect(() => target.removeRegion(testRegion1),
        throwsA(isA<ItemIsNotExistException>()));
  });
}
