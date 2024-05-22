import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/my_text_field.dart';
import 'package:medical_app/pages/auth/rules_page.dart';
import 'package:medical_app/services/consts.dart';

class RegPage extends StatefulWidget {
  final Function()? onTap;
  const RegPage({super.key, this.onTap});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool? isChecked = false;
  String errorMessage = "";

  String getErrorDescription(String errorCode) {
    switch (errorCode) {
      case 'too-many-requests':
        return '*Превышено количество запросов.';
      case 'email-already-in-use':
        return '*Уже зарегистрированный email';
      case 'network-request-failed':
        return '*Ошибка сети.';
      case 'invalid-email':
        return '*Неправильный адрес электронной почты.';
      case 'weak-password':
        return '*Слабый пароль.';
      case 'channel-error':
        return '*Есть незаполненные поля';
      case 'invalid-credential':
        return '*Данные введены неверно';
      default:
        return '*Неизвестная ошибка.';
    }
  }

  void signUserUp() async {
    if (isChecked == false) {
      setState(() {
        errorMessage = "Примите условия использования";
      });

      return;
    }
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(nameController.text);
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
            "Регистрация",
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
                // name enter
                MyTextField(
                  prefixIcon: Icons.person_outline,
                  hintText: "Введите имя",
                  controller: nameController,
                  obscureText: false,
                  visibilityState: false,
                  onChanged: 'checkUsername',
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 200,
                ),

                // email enter
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

                // password enter
                MyTextField(
                  prefixIcon: Icons.lock_outline_rounded,
                  hintText: "Введите пароль",
                  controller: passwordController,
                  obscureText: true,
                  visibilityState: true,
                  onChanged: 'checkPassword',
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 200,
                ),

                // agreement
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // checkbox
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                          activeColor: accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                                color: primaryColor, width: 5.0),
                          ),
                          value: isChecked,
                          onChanged: (newBool) {
                            setState(() {
                              isChecked = newBool;
                            });
                          }),
                    ),

                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 30,
                    ),

                    //text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text(
                              style: TextStyle(color: mainTextColor),
                              "Я принимаю "),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RulesPage())),
                            child: const Text(
                                style: TextStyle(color: accentColor),
                                "правила использования"),
                          ),
                          const Text(
                              style: TextStyle(color: mainTextColor), " и "),
                        ]),
                        GestureDetector(
                          child: const Text(
                              style: TextStyle(color: accentColor),
                              "обработки персональных данных"),
                        ),
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 30,
                ),

                // sign up button
                Button(
                    btnBackground: accentColor,
                    btnColor: Colors.white,
                    btnText: "Зарегистрироваться",
                    onTap: signUserUp),

                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 40,
                ),

                // Sign in text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Уже есть аккаунт?",
                      style: TextStyle(color: bodyTextColor),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "  Войдите!",
                        style: TextStyle(color: accentColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
