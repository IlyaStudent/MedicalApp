import 'package:flutter/material.dart';
import 'package:medical_app/services/consts.dart';

class AccountBtn extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function() function;
  final Color iconColor;
  final Color textColor;
  const AccountBtn(
      {super.key,
      required this.iconData,
      required this.text,
      required this.function,
      this.iconColor = accentColor,
      this.textColor = mainTextColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    iconData,
                    color: iconColor,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: mainTextColor,
              size: 30,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * 0.01),
          child: const Divider(
            color: secondaryColor,
            thickness: 1.5,
          ),
        )
      ]),
    );
  }
}
