import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/shimmer_hospital_info.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/firebase_database.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/preferences_service.dart';

class ListHospitals extends StatefulWidget {
  const ListHospitals({super.key});

  @override
  State<ListHospitals> createState() => _ListHospitalsState();
}

class _ListHospitalsState extends State<ListHospitals> {
  late Future<Map<String, dynamic>> resFuture;
  int? selectedCheckBox;

  @override
  void initState() {
    super.initState();
    resFuture = FireBaseDatabase().getAllHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: resFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(itemBuilder: (context, index) {
            return const ListTile(
              title: ShimmerHospitalInfo(),
            );
          });
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        Map<String, dynamic>? data = snapshot.data;
        Iterable<String> keys = data!.keys;

        return Stack(
          children: [
            ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Checkbox(
                    activeColor: accentColor,
                    value: selectedCheckBox == index,
                    onChanged: (bool? value) {
                      setState(() {
                        (value == true)
                            ? selectedCheckBox = index
                            : selectedCheckBox = null;
                      });
                    },
                  ),
                  title: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data[keys.elementAt(index)]["name"].toString(),
                          style: const TextStyle(
                              fontSize: 18, color: headingTextColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "г.${data[keys.elementAt(index)]["city"].toString()}, ${data[keys.elementAt(index)]["adress"].toString()}",
                          style: const TextStyle(
                              fontSize: 14, color: subheadingTextColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Часы работы: ${data[keys.elementAt(index)]["workHours"].toString()}",
                          style:
                              const TextStyle(fontSize: 12, color: hintColor),
                        ),
                        Text(
                          "Тел: ${data[keys.elementAt(index)]["phoneNumber"].toString()}",
                          style:
                              const TextStyle(fontSize: 12, color: hintColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 30,
              right: MediaQuery.sizeOf(context).width * 0.1,
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 60,
              child: (selectedCheckBox != null)
                  ? Button(
                      btnBackground: accentColor,
                      btnColor: Colors.white,
                      btnText: 'Выбрать',
                      onTap: () {
                        PreferncesServices().setPreference(
                            "HospitalBranch",
                            data[keys.elementAt(selectedCheckBox!)]["name"]
                                .toString());
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false);
                        });
                      },
                    )
                  : Button(
                      btnBackground: secondaryColor,
                      borderColor: secondaryColor,
                      btnColor: Colors.white,
                      btnText: 'Выбрать',
                      onTap: () {},
                    ),
            )
          ],
        );
      },
    );
  }
}
