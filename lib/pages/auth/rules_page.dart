import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cоглашение",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
            softWrap: true,
            "Здесь описаны все правила пользовательского соглашения. Все нюансы об использовании приложения, хранения и обработки персональных данных."),
      ),
    );
  }
}
