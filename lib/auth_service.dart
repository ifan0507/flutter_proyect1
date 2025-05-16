import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://192.168.1.9:8080';

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return null; // null berarti berhasil
      } else if (response.statusCode == 401) {
        return 'Email atau password salah.';
      } else {
        return 'Terjadi kesalahan server: ${response.statusCode}';
      }
    } catch (e) {
       print('Error saat koneksi ke server: $e');
      return 'Gagal koneksi ke server.';
    }
  }

  Future<String?> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
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
