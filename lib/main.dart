import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_proyect1/login_page.dart';
import 'package:provider/provider.dart';
import 'dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBzqthadSkovivdccCiok8KwgCHXn95WpM",
          appId: "1:91967834875:android:573ea32cc72fe0a8ed7e5e",
          messagingSenderId: "91967834875",
          projectId: "authfirebase-febb4"));

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'Program UTS',
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (auth.currentUser != null) {
        return const Dashboard();
      } else {
        return const LoginPage();
      }
    } catch (e) {
      return const LoginPage();
    }
  }
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Email tidak ditemukan.';
      } else if (e.code == 'wrong-password') {
        return 'Password salah.';
      } else if (e.code == 'invalid-email') {
        return 'Format email tidak valid.';
      } else if (e.code == 'user-disabled') {
        return 'Akun ini telah dinonaktifkan.';
      } else {
        return 'Terjadi kesalahan: ${e.message}';
      }
    } catch (e) {
      return 'Terjadi kesalahan. Coba lagi.';
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email sudah digunakan.';
      } else if (e.code == 'weak-password') {
        return 'Password terlalu lemah (minimal 6 karakter).';
      } else if (e.code == 'invalid-email') {
        return 'Format email tidak valid.';
      } else {
        return 'Terjadi kesalahan: ${e.message}';
      }
    } catch (e) {
      return "Terjadi kesalahan. Coba lagi.";
    }
  }
}
