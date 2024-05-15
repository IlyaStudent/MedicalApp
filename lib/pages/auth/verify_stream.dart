import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/email_verify_page.dart';
import 'package:medical_app/pages/home.dart';

class VerifyStream extends StatefulWidget {
  const VerifyStream({Key? key}) : super(key: key);

  @override
  _VerifyStreamState createState() => _VerifyStreamState();
}

class _VerifyStreamState extends State<VerifyStream> {
  late Stream<bool> _emailVerifiedStream;

  @override
  void initState() {
    super.initState();

    _emailVerifiedStream =
        FirebaseAuth.instance.authStateChanges().asyncMap((User? user) async {
      if (user != null) {
        await user.reload();
        return user.emailVerified;
      } else {
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: _emailVerifiedStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          FirebaseAuth.instance.currentUser?.reload();

          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            return const Home();
          } else {
            return const EmailVerifyPage();
          }
        },
      ),
    );
  }
}
