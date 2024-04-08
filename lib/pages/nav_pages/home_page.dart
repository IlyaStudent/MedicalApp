import 'package:flutter/material.dart';
import 'package:medical_app/components/search_button.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String hospitalChosen = "";

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
                  hospitalChosen,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home(
                                    pageNum: 1,
                                  )));
                    }); // Возвращаемся на предыдущий экран
                  },
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),

            // find bar
            const SearchButton(),

            // filter buttons

            // fill medical card

            // Top doctors
          ],
        ),
      ),
    ));
  }
}
