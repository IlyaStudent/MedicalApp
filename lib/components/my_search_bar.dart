import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/consts.dart';

class MySearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function funcOnChanged;

  const MySearchBar({
    super.key,
    required this.hintText,
    required this.controller,
    required this.funcOnChanged,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  bool showSearchIcon = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: MediaQuery.sizeOf(context).width,
      child: TextField(
        controller: widget.controller,
        cursorColor: accentColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: inputBorder)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: inputBorder)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: inputBorder)),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: hintColor, fontSize: 14),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Icon(
              Icons.search_rounded,
              color: searchIconColor,
            ),
          ),
          suffixIcon: (showSearchIcon == true)
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controller.clear();
                      showSearchIcon = false;
                      widget.funcOnChanged();
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: searchIconColor,
                  ),
                )
              : null,
        ),
        onChanged: (text) {
          setState(() {
            if (text.isNotEmpty) {
              showSearchIcon = true;
            } else {
              showSearchIcon = false;
            }
            widget.funcOnChanged();
          });
        },
      ),
    );
  }
}
