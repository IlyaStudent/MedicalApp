import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/services/consts.dart';

class MyAlertDialog extends StatelessWidget {
  final Function()? function;
  final String titleText;
  final String messageText;
  final String btnText;

  const MyAlertDialog(
      {super.key,
      this.function,
      required this.titleText,
      required this.messageText,
      this.btnText = "На главную"});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: gradeintColor),
            child: const Icon(
              size: 50,
              Icons.check,
              color: accentColor,
            ).animate().then(delay: 300.ms).scale().rotate(),
          ).animate().slide(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          Text(
            titleText,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: mainTextColor),
          ).animate().moveX(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              messageText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: hintColor),
            ),
          ).animate().moveX(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            child: Button(
                btnBackground: accentColor,
                btnColor: Colors.white,
                btnText: btnText,
                onTap: function),
          ).animate().moveX()
        ],
      ),
    ).animate().scale();
  }
}
