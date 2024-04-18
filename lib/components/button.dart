import 'package:flutter/cupertino.dart';
import 'package:medical_app/services/consts.dart';

class Button extends StatelessWidget {
  final Color btnBackground;
  final Color btnColor;
  final String btnText;
  final Color? borderColor;
  final double borderRadius;
  final Function()? onTap;

  const Button(
      {super.key,
      required this.btnBackground,
      required this.btnColor,
      required this.btnText,
      required this.onTap,
      this.borderColor,
      this.borderRadius = 70});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: btnBackground,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
                color: (borderColor != null) ? borderColor! : accentColor,
                width: 1.0)),
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).height / 50),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
                color: btnColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
