import 'package:flutter/material.dart';

class RecoverPasswPage extends StatelessWidget {
  const RecoverPasswPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Сброс пароля",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: null,
      ),
      body: Column(),
    );
  }
}
