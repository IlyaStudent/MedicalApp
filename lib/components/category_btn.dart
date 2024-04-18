import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/services/consts.dart';

class CategoryBtn extends StatefulWidget {
  final String imagePath;
  final String catName;
  final Function() func;
  final bool image;
  final Icon? icon;
  const CategoryBtn(
      {super.key,
      required this.catName,
      this.imagePath = "",
      required this.func,
      this.image = true,
      this.icon});

  @override
  State<CategoryBtn> createState() => _CategoryBtnState();
}

class _CategoryBtnState extends State<CategoryBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.func,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor)),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: widget.image
                  ? Image.asset(
                      widget.imagePath,
                      width: 30,
                    )
                  : widget.icon),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.catName,
              style: TextStyle(color: hintColor),
            ),
          )
        ],
      ),
    );
  }
}
