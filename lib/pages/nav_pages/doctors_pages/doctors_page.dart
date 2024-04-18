import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/category_btn.dart';
import 'package:medical_app/components/doctor_avatar.dart';
import 'package:medical_app/components/search_button.dart';
import 'package:medical_app/components/shimmer_d_avatar.dart';
import 'package:medical_app/pages/nav_pages/doctors_pages/doctor_cat_page.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';
import 'package:medical_app/services/preferences_service.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  Map<String, String> doctorsCategories = {
    "Хирург": "lib/assets/img/categories/surgeon.png",
    "Невролог": "lib/assets/img/categories/neurologist.png",
    "Терапевт": "lib/assets/img/categories/stethoscope.png",
    "Офтальмолог": "lib/assets/img/categories/oftalm.png",
  };
  List<String> catNames = ["Хирург", "Невролог", "Терапевт", "Окулист"];
  List<String> catAssests = [
    "lib/assets/img/categories/surgeon.png",
    "lib/assets/img/categories/neurologist.png",
    "lib/assets/img/categories/stethoscope.png",
    "lib/assets/img/categories/oftalm.png",
  ];
  String hospitalChosen = "";
  late Future<List<Map<String, dynamic>>> lastDoctors;
  List<Map<String, dynamic>>? lastDoctorsList;

  void _getDataFromPreferences() async {
    lastDoctors = FireBaseDatabase()
        .getLastDoctors(FirebaseAuth.instance.currentUser!.uid);
    hospitalChosen = await PreferncesServices().getPreference("HospitalBranch");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDataFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Доктора",
            style: TextStyle(fontWeight: FontWeight.w500, color: mainTextColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.1,
                vertical: MediaQuery.sizeOf(context).height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchButton(
                  isAll: true,
                ),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(
                            Icons.place_rounded,
                            color: subheadingTextColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            hospitalChosen,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: subheadingTextColor,
                            ),
                          ),
                        ]),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: subheadingTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: secondaryColor,
                  thickness: 1.5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.02),
                  child: const Text(
                    "Категории",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return CategoryBtn(
                      catName: catNames[index],
                      imagePath: catAssests[index],
                      func: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DoctorsCategoriesPage(
                                category: catNames[index]);
                          },
                        ));
                      },
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.03),
                  child: const Text(
                    "Последние визиты",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                _buildLastDoctors(context),
              ],
            ),
          ),
        ));
  }

  Widget _buildLastDoctors(BuildContext context) {
    return FutureBuilder(
        future: lastDoctors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerDoctorAvatar(),
                ShimmerDoctorAvatar(),
                ShimmerDoctorAvatar(),
              ],
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Получаем данные из Future
          lastDoctorsList = snapshot.data;
          List<Widget> lastDoctorsWidget = lastDoctorsList!.isEmpty
              ? []
              : List.generate(lastDoctorsList!.length, (indexRow) {
                  return DoctorAvatar(
                      doctor: Doctor.fromJson(
                          lastDoctorsList![indexRow].keys.toList()[0],
                          lastDoctorsList![indexRow]
                              [lastDoctorsList![indexRow].keys.toList()[0]]));
                });

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: lastDoctorsWidget,
          );

          // return Container(
          //   height: 150,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       shrinkWrap: true,
          //       itemCount: lastDoctorsList?.length,
          //       itemBuilder: (context, index) {
          //         return (lastDoctorsList != null &&
          //                 lastDoctorsList!.isNotEmpty)
          //             ? DoctorAvatar(
          //                 doctor: Doctor.fromJson(
          //                     lastDoctorsList![index].keys.toList()[0],
          //                     lastDoctorsList![index]
          //                         [lastDoctorsList![index].keys.toList()[0]]))
          //             : Text("Пусто");
          //       }),
          // );
        });
  }
}
