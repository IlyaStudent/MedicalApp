import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/my_text_field.dart';
import 'package:medical_app/components/sign_with_button.dart';
import 'package:medical_app/pages/auth/forget_passw_page.dart';
import 'package:medical_app/services/auth_service.dart';
import 'package:medical_app/services/consts.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  String errorMessage = "";

  String getErrorDescription(String errorCode) {
    switch (errorCode) {
      case 'too-many-requests':
        return '*Превышено количество запросов.';
      case 'wrong-password':
        return '*Неправильный пароль.';
      case 'network-request-failed':
        return '*Ошибка сети.';
      case 'invalid-email':
        return '*Неправильный адрес электронной почты.';
      case 'user-disabled':
        return '*Пользователь заблокирован.';
      case 'user-not-found':
        return '*Пользователь не найден.';
      case 'channel-error':
        return '*Есть незаполненные поля';
      case 'invalid-credential':
        return '*Данные введены неверно';
      default:
        return '*Неизвестная ошибка.';
    }
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: accentColor,
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = getErrorDescription(e.code);
      });
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Авторизация",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height / 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: alertColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 200,
              ),
              // email
              MyTextField(
                prefixIcon: Icons.mail_outline_rounded,
                hintText: "Введите email",
                controller: emailController,
                obscureText: false,
                visibilityState: false,
                onChanged: 'checkEmail',
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 200,
              ),

              // password
              MyTextField(
                prefixIcon: Icons.lock_outline_rounded,
                hintText: "Введите пароль",
                controller: passwordController,
                obscureText: true,
                visibilityState: true,
                errorDesc: errorMessage,
                onChanged: 'checkPassword',
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 200,
              ),

              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage(),
                      )),
                  child: const Text(
                    "Забыли пароль?",
                    style: TextStyle(
                        color: accentColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),

              SizedBox(
                height: MediaQuery.sizeOf(context).height / 100,
              ),

              // login button
              Button(
                  btnBackground: accentColor,
                  btnColor: Colors.white,
                  btnText: "Войти",
                  onTap: signUserIn),

              SizedBox(
                height: MediaQuery.sizeOf(context).height / 30,
              ),
              // reg button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Еще нет аккаунта?",
                    style: TextStyle(color: bodyTextColor),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "  Зарегистрируйтесь!",
                      style: TextStyle(color: accentColor),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),

              // or text

              Row(children: [
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: bodyTextColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).height / 100),
                  child: const Text(
                    "ИЛИ",
                    style: TextStyle(color: bodyTextColor),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: bodyTextColor,
                  ),
                ),
              ]),

              SizedBox(
                height: MediaQuery.sizeOf(context).height / 20,
              ),

              // sign with buttons
              SignWithButton(
                btnText: "Войти через Google",
                imagePath: 'lib/assets/img/google.png',
                func: AuthService().signInWithGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
