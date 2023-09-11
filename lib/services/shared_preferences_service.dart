import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SPService {
  static void addString(String chiave, String valore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(chiave, valore);
  }

  static void removeString(String chiave) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(chiave);
  }

  static Future<String?> getString(String chiave) async {
    final prefs = await SharedPreferences.getInstance();
    final stringa = prefs.getString(chiave);
    return stringa;
  }
}
