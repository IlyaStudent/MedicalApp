import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/verify_stream.dart';
import 'package:medical_app/services/consts.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({super.key});

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  Future<void> _checkVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const VerifyStream()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: accentColor,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: _checkVerified,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: null,
          title: const Text(
            "Подтверждение",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: MediaQuery.sizeOf(context).height * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Подтвердите email",
                  style: TextStyle(
                      color: mainTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "На вашу почту было отправлено письмо подтверждения.\nПерейдите по ссылке в письме, чтобы получить доступ к аккаунту",
                  style: TextStyle(color: bodyTextColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: bodyTextColor,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Не пришло письмо?",
                      style: TextStyle(color: bodyTextColor, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();
                      },
                      child: const Text(
                        "Отправить еще раз",
                        style: TextStyle(color: accentColor, fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
