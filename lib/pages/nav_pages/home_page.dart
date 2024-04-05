import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/components/my_text_field.dart';
import 'package:medical_app/components/search_button.dart';
import 'package:medical_app/services/firebase_database.dart';
import 'package:medical_app/services/geo_files/map_point.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/nav_pages/hospitals/hospitals_page.dart';
import 'package:medical_app/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String hospitalChosen = "";
  final _searchController = TextEditingController();

  void _getDataFromPreferences() async {
    hospitalChosen = await PreferncesServices().getPreference("HospitalBranch");
    setState(() {}); // Обновляем состояние виджета после получения данных
  }

  @override
  void initState() {
    super.initState();
    _getDataFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.1),
        child: Column(
          children: [
            // hospital chosen + arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$hospitalChosen",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      Home.updateVisit(1);
                      Navigator.of(context).pushNamed('/homepage');
                    }); // Возвращаемся на предыдущий экран
                  },
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),

            // find bar
            SearchButton(),

            // filter buttons

            // fill medical card

            // Top doctors
          ],
        ),
      ),
    ));
  }
}
