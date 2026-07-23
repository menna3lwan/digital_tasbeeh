import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

abstract interface class TasbeehLocalDataSource {
  Future<int> getCount();

  Future<void> saveCount(int count);
}

final class TasbeehLocalDataSourceImpl implements TasbeehLocalDataSource {
  TasbeehLocalDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<int> getCount() async {
    return _preferences.getInt(AppConstants.tasbeehCountKey) ?? 0;
  }

  @override
  Future<void> saveCount(int count) async {
    await _preferences.setInt(AppConstants.tasbeehCountKey, count);
  }
}
