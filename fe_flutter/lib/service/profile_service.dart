import 'dart:convert';
import 'package:flutter_proyect1/auth_service.dart';
import 'package:http/http.dart' as http;
import '../utils/api.dart';

class ProfileService {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>?> fetchProfile() async {
    final token = await _authService.getToken();

    if (token == null) {
      return null;
    }

    try {
      final response = await http.get(Uri.parse('${Api.baseUrl}/profile'),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal memuat profil');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> changePassword(String oldPassword, String newPassword) async {
    final token = await _authService.getToken();

    if (token == null) {
      return null;
    }
    try {
      final response = await http.put(
        Uri.parse('${Api.baseUrl}/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        if (response.body.isNotEmpty) {
          try {
            final error = jsonDecode(response.body);
            print("Error from BE: ${error['message']}");
            return error['message'];
          } catch (e) {
            print("Gagal decode JSON: $e");
            return 'Terjadi kesalahan: ${response.body}';
          }
        } else {
          print(
              "Response kosong dari server dengan status ${response.statusCode}");
          return 'Terjadi kesalahan: Response kosong dari server.';
        }
      }
    } catch (e) {
      return 'Gagal koneksi ke server.';
    }
  }
}
