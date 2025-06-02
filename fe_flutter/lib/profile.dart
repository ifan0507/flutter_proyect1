import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyect1/dashboard.dart';
import 'package:flutter_proyect1/service/profile_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ProfileService _profileService = ProfileService();
  Map<String, dynamic>? _profile;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await _profileService.fetchProfile();
      setState(() => _profile = data);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat profil')),
      );
    }
  }

  Future<void> _changePassword() async {
    final newPassword = _newPasswordController.text;
    final oldPassword = _oldPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (oldPassword.isEmpty) {
      showAlert(
          context, 'ERROR', 'Old password is required!', DialogType.error);
    } else if (newPassword.isNotEmpty && confirmPassword.isEmpty) {
      showAlert(context, 'ERROR', 'confirmation password is required!',
          DialogType.error);
    } else if (confirmPassword.isNotEmpty && oldPassword.isEmpty) {
      showAlert(
          context, 'ERROR', 'old password is required!', DialogType.error);
    } else if (newPassword != confirmPassword) {
      showAlert(
          context,
          'ERROR',
          'Confirmation password incorrect with new password',
          DialogType.error);
      return;
    }

    final result =
        await _profileService.changePassword(oldPassword, newPassword);
    if (result == null) {
      showAlert(context, 'Success', 'Change password success fully',
          DialogType.success);
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } else {
      showAlert(context, 'ERROR', result, DialogType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 38, 101),
      ),
      body: _profile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromARGB(255, 2, 38, 101),
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.badge),
                      title: const Text('Nama'),
                      subtitle: Text("${_profile!['name']}"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text("${_profile!['email']}"),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Change Password',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _oldPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'old password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'new password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'confirmation password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _changePassword,
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Simpan Perubahan',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 2, 38, 101),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void showAlert(
      BuildContext context, String title, String desc, DialogType type) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
    ).show();
  }
}
