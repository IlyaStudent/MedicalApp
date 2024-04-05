import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/login_or_register.dart';
import 'package:medical_app/pages/home.dart';

class StreamPage extends StatelessWidget {
  final bool showLoginPage;
  const StreamPage({super.key, required this.showLoginPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return LoginOrRegisterPage(showLoginPage: showLoginPage);
          }
        },
      ),
    );
  }
}
