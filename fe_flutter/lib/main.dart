import 'package:flutter/material.dart';
import 'package:flutter_proyect1/login_page.dart';
import 'dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Program UTS',
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return const Dashboard();
    } else {
      return const LoginPage();
    }
  }
}
