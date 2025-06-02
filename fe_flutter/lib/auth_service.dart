import 'dart:convert';

import 'package:flutter_proyect1/utils/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // final String baseUrl = 'http://192.168.3.90:8080';
  final _storage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('${Api.baseUrl}/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _storage.write(key: 'token', value: token);
        return null;
      } else {
        return jsonDecode(response.body)['message'] ?? 'Login gagal';
      }
    } catch (e) {
      return 'Gagal terhubung ke server';
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<String?> register(String email, String password) async {
    final url = Uri.parse('${Api.baseUrl}/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return null; // sukses
      } else {
        // Bisa cek response.body untuk pesan error lebih detail dari server
        return 'Gagal registrasi: ${response.statusCode}';
      }
    } catch (e) {
      return 'Gagal koneksi ke server.';
    }
  }
}
