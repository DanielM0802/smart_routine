import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final Rx<Color> _color = Colors.white.obs;
  final _box = GetStorage();
  final _key = 'isDarkMode';

  Color get color => _color.value;

  @override
  void onInit() {
    super.onInit();
    _color.value = Colors.white;
  }

  ThemeMode get theme => ThemeMode.dark;
  bool get _loadThemeFromBox => _box.read(_key) ?? false;

  switchTheme() async {
    Get.changeThemeMode(theme);
    _color.value = Colors.white;
    await _box.write(_key, !_loadThemeFromBox);
  }
}
