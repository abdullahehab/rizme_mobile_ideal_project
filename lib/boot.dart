import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_ideal_project/config/helpers/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Override>> getOverrides() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  return [
    prefsProvider.overrideWithValue(prefs),
  ];
}
