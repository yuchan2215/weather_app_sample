import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app_sample/exceptions/item_is_exist.dart';
import 'package:weather_app_sample/exceptions/item_is_not_exist.dart';
import 'package:weather_app_sample/model/setting_state.dart';

class SettingNotifier extends StateNotifier<SettingState> {
  SettingNotifier({String? apiKey, List<String>? regions})
      : super(SettingState(regions: regions));
  
  /// [region]を地域一覧に追加します。
  /// すでに存在する場合には[ItemIsExistException]となります。
  void addRegion(String region) async {
    if (state.regions?.contains(region) ?? false == true) {
      //すでに含まれているなら
      throw ItemIsExistException(region);
    }
    //地域一覧に追加する。
    var regions = state.regions?.toList() ?? [];
    regions.add(region);

    state = state.copyWith(regions: regions);
  }

  ///[region]を地域一覧から削除します。
  ///存在しない場合には[ItemIsNotExistException]となります。
  void removeRegion(String region) async {
    if (state.regions?.contains(region) == false) {
      //含まれていないなら
      throw ItemIsNotExistException(region);
    }
    //地域一覧から削除する。
    var regions = state.regions?.toList() ?? [];
    regions.remove(region);

    state = state.copyWith(regions: regions);
  }
}

final settingProvider = StateNotifierProvider<SettingNotifier, SettingState>(
    (ref) => SettingNotifier());
