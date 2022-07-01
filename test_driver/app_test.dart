import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;
  late VMServiceFlutterDriver vmDriver;
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  tearDownAll(() async {
    await driver.close();
  });

  test('hoge', () async {
    expect(1, 1);
  });
}
