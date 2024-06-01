import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/my_alert_dialog.dart';
import 'package:medical_app/components/my_text_field.dart';
import 'package:medical_app/pages/auth/login_or_register.dart';
import 'package:medical_app/services/consts.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();

  void sendRecoverEmail() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const LoginOrRegisterPage(
                  showLoginPage: true,
                )),
        (route) => false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog(
          titleText: "Письмо отправлено",
          messageText: "Проверьте свой почтовый ящик",
          btnText: "Далее",
          function: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Забыли пароль"),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * 0.1,
              horizontal: MediaQuery.sizeOf(context).height / 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Забыли пароль?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                    "Введите свой email, мы отправим на него дальнейшие инструкции по восстановлению пароля"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: MyTextField(
                    prefixIcon: Icons.email_outlined,
                    hintText: "Введите email",
                    onChanged: 'checkEmail',
                    controller: emailController),
              ),
              Button(
                  btnBackground: accentColor,
                  btnColor: Colors.white,
                  btnText: "Отправить",
                  onTap: sendRecoverEmail)
            ],
          ),
        ),
      ),
    );
  }
}
