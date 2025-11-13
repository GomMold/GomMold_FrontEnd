/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final _baseUrl = dotenv.env['BACKEND_BASE'] ?? '';

  // Sign up user
  Future<bool> signUp(String email, String password) async {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    return response.statusCode == 200;
  }  
}
  // Login user
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'token', value: data['token']);
      return true;
    }
    return false;
  }

  // Get stored token
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Logout
  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final _baseUrl = dotenv.env['BACKEND_BASE'] ?? '';

  // Sign up user
  Future<bool> signUp(String email, String password) async {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    return response.statusCode == 200;
  }

  // Login user
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'token', value: data['token']);
      return true;
    }
    return false;
  }

  // Get stored token
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Logout
  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}

