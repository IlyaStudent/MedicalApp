import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/components/shimmer_d_card.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';

class LastDoctorsPage extends StatefulWidget {
  const LastDoctorsPage({super.key});

  @override
  State<LastDoctorsPage> createState() => _LastDoctorsPageState();
}

class _LastDoctorsPageState extends State<LastDoctorsPage> {
  late Future<List<Map<String, dynamic>>> lastDoctors;
  List<Map<String, dynamic>>? lastDoctorsList;

  @override
  void initState() {
    super.initState();
    lastDoctors = FireBaseDatabase()
        .getLastDoctors(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Последние врачи"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: lastDoctors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: List.generate(7, (index) => ShimmerDoctorCard()),
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: DoctorCard(
                              doctor: Doctor.fromJson(
                                  lastDoctorsList![indexRow].keys.toList()[0],
                                  lastDoctorsList![indexRow][
                                      lastDoctorsList![indexRow]
                                          .keys
                                          .toList()[0]])),
                        );
                      });

                return Column(
                  children: lastDoctorsWidget,
                );
              }),
        ));
  }
}
