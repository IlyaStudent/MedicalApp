import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/consts.dart';

class MyTextField extends StatefulWidget {
  final String? onChanged;
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool visibilityState;
  final String? errorDesc;
  final bool searchBar;
  const MyTextField(
      {super.key,
      required this.prefixIcon,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      this.visibilityState = false,
      this.searchBar = false,
      this.onChanged,
      this.errorDesc});

  @override
  State<MyTextField> createState() =>
      // ignore: no_logic_in_create_state
      _MyTextFieldState(obscureText: obscureText, errorDesc: errorDesc);
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscureText;
  Color prefixColor = hintColor;
  Color borderColor = inputBorder;
  String? errorDesc;

  _MyTextFieldState({required this.obscureText, String? errorDesc})
      : errorDesc = errorDesc ?? "";

  void checkUsername(String text) {
    setState(() {
      if (text.isEmpty) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Имя не должно быть пустым';
      } else if (text.length < 5 || text.length > 25) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Имя должно быть от 5 до 25 символов';
      } else if (text.contains(' ')) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Имя не может состоять из пробелов';
      } else {
        prefixColor = accentColor;
        borderColor = accentColor;
        errorDesc = "";
      }
    });
  }

  void checkEmail(text) {
    setState(() {
      if (text.isEmpty) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Поле не должно быть пустым';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Введите корректный адрес электронной почты';
      } else {
        prefixColor = accentColor;
        borderColor = accentColor;
        errorDesc = "";
      }
    });
  }

  void checkPassword(text) {
    setState(() {
      if (text.isEmpty) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Пароль не должен быть пустым';
      } else if (text.length < 6 || text.length > 25) {
        prefixColor = alertColor;
        borderColor = alertColor;
        errorDesc = '*Пароль должен быть от 6 до 25 символов';
      } else {
        prefixColor = accentColor;
        borderColor = accentColor;
        errorDesc = "";
      }
    });
  }

  void updateErrorDescription(String error) {
    setState(() {
      errorDesc = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        controller: widget.controller,
        obscureText: obscureText,
        cursorColor: accentColor,
        decoration: InputDecoration(
          errorText: errorDesc,
          errorMaxLines: 1,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(color: borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(color: borderColor),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 25, right: 10),
            child: Icon(
              widget.prefixIcon,
              color: prefixColor,
            ),
          ),
          suffixIcon: (widget.visibilityState == true)
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: obscureText
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                    color: hintColor,
                  ),
                )
              : null,
          fillColor: inputBG,
          filled: true,
          hintText: widget.hintText,
          hintStyle:
              const TextStyle(color: hintColor, fontWeight: FontWeight.w200),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
        onChanged: widget.onChanged != null
            ? (text) {
                if (widget.onChanged == 'checkEmail') {
                  setState(() {
                    checkEmail(text);
                  });
                } else if (widget.onChanged == 'checkUsername') {
                  setState(() {
                    checkUsername(text);
                  });
                } else if (widget.onChanged == 'checkPassword') {
                  setState(() {
                    checkPassword(text);
                  });
                }
              }
            : (text) {},
      ),
    );
  }
}
