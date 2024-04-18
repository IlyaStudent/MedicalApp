import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/category_btn.dart';
import 'package:medical_app/components/search_button.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/consts.dart';
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDataFromPreferences();
  }

  final Map<String, IconData> categories = {
    "Доктора": Icons.medical_services_outlined,
    "Больницы": Icons.location_on_outlined,
    "Записи": Icons.calendar_month_outlined,
    "Профиль": Icons.account_box_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "",
            style: TextStyle(fontWeight: FontWeight.w500, color: mainTextColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.1),
            child: Column(
              children: [
                // hospital chosen + arrow
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Home(
                                    pageNum: 1,
                                  )),
                          (route) => false);
                    }); // Возвращаемся на предыдущий экран
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(
                          Icons.place_rounded,
                          color: mainTextColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          hospitalChosen,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: mainTextColor,
                          ),
                        ),
                      ]),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: mainTextColor,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                ),

                // find bar
                const SearchButton(
                  isAll: false,
                ),

                // filter buttons
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.from(categories.keys).map((key) {
                        int index = categories.keys.toList().indexOf(key);
                        return CategoryBtn(
                          catName: key,
                          func: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                          pageNum:
                                              (index > 1) ? index + 1 : index,
                                        )),
                                (route) => false);
                          },
                          image: false,
                          icon: Icon(
                            categories[key],
                            color: accentColor,
                          ),
                        );
                      }).toList()),
                ),

                // fill medical card
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.03),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: secondaryColor),
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Узнайте больше\nо своем здоровье",
                              style: TextStyle(
                                  color: mainTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.03,
                            ),
                            const Button(
                                borderRadius: 10,
                                btnBackground: accentColor,
                                btnColor: Colors.white,
                                btnText: "Пройти тест",
                                onTap: null)
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).width * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 20,
                                      color:
                                          Color.fromARGB(255, 243, 255, 253))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Image.asset("lib/assets/img/doctor2.png"),
                            ),
                          ],
                        )

                        // Padding(
                        //   padding: EdgeInsets.all(5),
                        //   child: Image.asset("lib/assets/img/doctor1.png"),
                        // )
                      ],
                    ),
                  ),
                )

                // Top doctors
              ],
            ),
          ),
        ));
  }
}
