import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/stream_pade.dart';
import 'package:medical_app/pages/onboarding_page.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified == false) {
      FirebaseAuth.instance.currentUser!.delete();

      return const OnBoardingPage();
    } else if (FirebaseAuth.instance.currentUser != null) {
      return const StreamPage(showLoginPage: true);
    } else {
      return const OnBoardingPage();
    }
  }
}
