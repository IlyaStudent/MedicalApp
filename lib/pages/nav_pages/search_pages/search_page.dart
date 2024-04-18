import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/components/my_search_bar.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';

class SearchPage extends StatefulWidget {
  final bool isAll;
  const SearchPage({super.key, required this.isAll});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<Map<String, dynamic>> resFuture;
  int? selectedCheckBox;
  final searchController = TextEditingController();
  Map<String, dynamic>? searchData = {};
  Iterable<String>? keys;
  List<Doctor> docotrsSearch = [];

  @override
  void initState() {
    makeSearchResults();
    super.initState();
    resFuture = widget.isAll
        ? FireBaseDatabase().getAllDoctors()
        : FireBaseDatabase().getAllBranchDoctors();
  }

  void makeSearchResults() {
    docotrsSearch = [];
    setState(() {
      for (final info in data!.entries) {
        if (data![info.key]["full_name"].toString().toLowerCase().contains(
            searchController.text.isEmpty
                ? " "
                : searchController.text.toLowerCase())) {
          docotrsSearch.add(Doctor.fromJson(info.key, info.value));
        }
      }
      keys = searchData?.keys;
    });
  }

  Map<String, dynamic>? data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MySearchBar(
          hintText: "Введите ФИО врача",
          controller: searchController,
          funcOnChanged: makeSearchResults,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: resFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(accentColor),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Получаем данные из Future
          data = snapshot.data;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Material(
                    child: (docotrsSearch.isNotEmpty)
                        ? ListView.builder(
                            // searchData?[keys?.elementAt(index)]["full_name"],
                            itemCount: docotrsSearch.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: DoctorCard(
                                  doctor: docotrsSearch[index],
                                ).animate().slideX(),
                              );
                            },
                          )
                        : _buildNoSearchResults().animate().scale()),
              ),
            ],
          );
        },
      ),
    );
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
