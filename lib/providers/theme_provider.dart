import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  late Box _settingsBox;
  ThemeMode _themeMode;

  ThemeProvider() : _themeMode = ThemeMode.system {
    _settingsBox = Hive.box('settings');
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  void _loadThemeMode() {
    final savedMode = _settingsBox.get('themeMode', defaultValue: 'system');
    _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedMode,
      orElse: () => ThemeMode.system,
    );
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _settingsBox.put('themeMode', mode.toString());
    notifyListeners();
  }
}