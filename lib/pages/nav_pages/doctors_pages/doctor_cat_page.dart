import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/components/shimmer_d_card.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';

class DoctorsCategoriesPage extends StatefulWidget {
  final String category;
  const DoctorsCategoriesPage({super.key, required this.category});

  @override
  State<DoctorsCategoriesPage> createState() => _DoctorsCategoriesPageState();
}

class _DoctorsCategoriesPageState extends State<DoctorsCategoriesPage> {
  late Future<Map<String, dynamic>> doctorsMap;

  Map<String, dynamic>? data;
  List<String> keys = [];
  @override
  void initState() {
    super.initState();
    doctorsMap = FireBaseDatabase().getDoctorsByCat(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: doctorsMap,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ListTile(title: ShimmerDoctorCard());
                  },
                );
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // Получаем данные из Future
              data = snapshot.data;
              keys = data!.keys.toList();

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Material(
                        child: (data!.isNotEmpty)
                            ? ListView.builder(
                                // searchData?[keys?.elementAt(index)]["full_name"],
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: DoctorCard(
                                      doctor: Doctor.fromJson(
                                          keys[index], data![keys[index]]),
                                    ),
                                  );
                                },
                              )
                            : _buildNoSearchResults().animate().scale()),
                  ),
                ],
              );
            }));
  }

  Widget _buildNoSearchResults() {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(
        Icons.search_off_outlined,
        color: mainTextColor,
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.05,
      ),
      const Text(
        "Нет совпадений",
        style: TextStyle(fontSize: 20, color: mainTextColor),
      ),
    ]));
  }
}
