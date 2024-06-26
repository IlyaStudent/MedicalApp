import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/nav_pages/search_pages/search_page.dart';
import 'package:medical_app/services/consts.dart';

class SearchButton extends StatelessWidget {
  final bool isAll;
  const SearchButton({super.key, required this.isAll});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: searchBG,
            border: Border.all(color: inputBorder)),
        child: const Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Icon(
              Icons.search,
              color: searchIconColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Поиск",
              style: TextStyle(color: hintColor),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPage(isAll: isAll);
        }));
      },
    );
  }
}
