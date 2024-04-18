import 'package:flutter/cupertino.dart';
import 'package:medical_app/pages/auth/login_page.dart';
import 'package:medical_app/pages/auth/reg_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  final bool showLoginPage;
  const LoginOrRegisterPage({super.key, required this.showLoginPage});

  @override
  State<LoginOrRegisterPage> createState() =>
      _LoginOrRegisterPageState(showLoginPage: showLoginPage);
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage;
  _LoginOrRegisterPageState({required this.showLoginPage});

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegPage(onTap: togglePages);
    }
  }
}
