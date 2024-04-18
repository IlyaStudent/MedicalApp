import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/services/consts.dart';

class SignWithButton extends StatelessWidget {
  final String btnText;
  final String imagePath;
  final Function()? func;
  const SignWithButton(
      {super.key, required this.btnText, required this.imagePath, this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: func,
        child: Container(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).height / 50),
          decoration: BoxDecoration(
              border: Border.all(color: inputBorder),
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: MediaQuery.sizeOf(context).height / 40,
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  btnText,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ));
  }
}
