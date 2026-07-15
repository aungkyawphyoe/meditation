import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/daos/user_info_dao.dart';
import '../database/providers/app_database_providers.dart';

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final dao = ref.watch(userInfoDaoProvider);
  return ThemeModeNotifier(dao);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final UserInfoDao _dao;

  ThemeModeNotifier(this._dao) : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    final user = await _dao.getUser();
    if (user != null && user.themeMode != null) {
      state = _parseThemeMode(user.themeMode!);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _dao.updateThemeMode(_serializeThemeMode(mode));
  }

  static ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static String? _serializeThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return null;
    }
  }
}
