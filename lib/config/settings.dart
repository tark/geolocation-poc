import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

const _themeMode = 'theme_mode';
const _locale = 'locale';
const _notificationsOn = 'notifications_on';

class Settings {
  factory Settings() => _singleton;

  Settings._internal();

  ///
  static final Settings _singleton = Settings._internal();

  Future<bool> setThemeMode(ThemeMode mode) async {
    return _setString(_themeMode, mode.name);
  }

  Future<ThemeMode> getThemeMode() async {
    final value = await _getString(_themeMode) ?? '';
    return ThemeMode.values.firstWhereOrNull((v) => v.name == value) ??
        ThemeMode.system;
  }

  Future<bool> setLocale(Locale locale) async {
    return _setString(_locale, locale.toLanguageTag());
  }

  Future<Locale> getLocale() async {
    final languageTag = await _getString(_locale) ?? '';
    if (languageTag.isEmpty) {
      return defaultLocale;
    }
    final codes = languageTag.split('-');
    return codes.length != 2 ? defaultLocale : Locale(codes[0], codes[1]);
  }

  Future<bool> setNotificationsOn(bool isOn) async {
    return _setBool(_notificationsOn, isOn);
  }

  Future<bool> getNotificationsOn() async {
    return await _getBool(_notificationsOn) ?? true;
  }

  //
  Future<String?> _getString(String key) async {
    return (await _prefs()).getString(key);
  }

  Future<bool> _setString(String key, String value) async {
    final saved = await (await _prefs()).setString(key, value);
    return saved;
  }

  Future<bool?> _getBool(String key) async {
    return (await _prefs()).getBool(key);
  }

  Future<bool> _setBool(String key, bool value) async {
    return await (await _prefs()).setBool(key, value);
  }

  Future<int?> _getInt(String key) async {
    return (await _prefs()).getInt(key);
  }

  Future<bool> _setInt(String key, int value) async {
    return await (await _prefs()).setInt(key, value);
  }

  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }
}
