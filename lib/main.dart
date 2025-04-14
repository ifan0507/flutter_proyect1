import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import './halaman_utama.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Program UTS',
    home: HalamanUtama(),
    debugShowCheckedModeBanner: false,
  ));
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  bool visibilityPass = false;

  final String myUser = 'admin';
  final String myPass = '123';

  TextEditingController cUser = TextEditingController();
  TextEditingController cPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 7, 6, 60),
              Color.fromARGB(255, 237, 239, 239)
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 15,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: cUser,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Input Username Anda',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: cPass,
                      obscureText: !visibilityPass,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Input Password Anda',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibilityPass = !visibilityPass;
                            });
                          },
                          icon: Icon(
                            visibilityPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color.fromARGB(255, 7, 6, 60),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Login(BuildContext context) {
    if (cUser.text == myUser && cPass.text == myPass) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Login Berhasil',
        desc: 'Selamat datang, $myUser!',
        btnOkOnPress: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        },
      ).show();
    } else if (cUser.text.isEmpty) {
      showAlert(
          context, 'Oops!', 'Username tidak boleh kosong', DialogType.warning);
    } else if (cPass.text.isEmpty) {
      showAlert(
          context, 'Oops!', 'Password tidak boleh kosong', DialogType.warning);
    } else {
      showAlert(context, 'Login Gagal', 'Username atau Password salah',
          DialogType.error);
    }
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
