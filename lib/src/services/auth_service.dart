import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = "auth_token";
  static const String _userKey = "auth_user";

  /// ---------------------------------------------------
  /// SAVE TOKEN
  /// ---------------------------------------------------
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// ---------------------------------------------------
  /// GET TOKEN
  /// ---------------------------------------------------
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ---------------------------------------------------
  /// SAVE USER MAP
  /// ---------------------------------------------------
  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  /// ---------------------------------------------------
  /// GET USER MAP (SAFE)
  /// ---------------------------------------------------
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);

    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw);
      return Map<String, dynamic>.from(decoded);
    } catch (e) {
      // corrupted JSON → clear it
      await prefs.remove(_userKey);
      return null;
    }
  }

  /// ---------------------------------------------------
  /// DELETE TOKEN + USER
  /// ---------------------------------------------------
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  /// ---------------------------------------------------
  /// SIMPLE LOGOUT HELPER
  /// ---------------------------------------------------
  Future<void> logout() async {
    await deleteToken();
  }

  /// ---------------------------------------------------
  /// CHECK IF LOGGED IN
  /// ---------------------------------------------------
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
