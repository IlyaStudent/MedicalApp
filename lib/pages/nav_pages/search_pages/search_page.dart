import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/components/my_search_bar.dart';
import 'package:medical_app/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

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
  final storageRef = FirebaseStorage.instance.ref();
  final gsReference = FirebaseStorage.instance
      .refFromURL(
          "gs://medicalapp-ece20.appspot.com/doctors_images/doctor1.jpg")
      .fullPath;
  late final imageUrl = storageRef.child(gsReference).getDownloadURL();

  @override
  void initState() {
    makeSearchResults();
    super.initState();
    resFuture = FireBaseDatabase().getAllDoctors();
  }

  void updateImageUrl() async {
    for (final info in data!.entries) {
      print(data?[info.key]["photo"]);
      String photoReference = FirebaseStorage.instance
          .refFromURL(data?[info.key]["photo"])
          .fullPath;
      String imageUrl = await storageRef.child(photoReference).getDownloadURL();
      data?[info.key]["photo"] = imageUrl;
    }
  }

  void makeSearchResults() {
    docotrsSearch = [];
    setState(() {
      for (final info in data!.entries) {
        if (data![info.key]["full_name"]
            .toString()
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
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
          updateImageUrl();
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Material(
                    child: (docotrsSearch.isNotEmpty)
                        ? ListView.builder(
                            // searchData?[keys?.elementAt(index)]["full_name"],
                            itemCount: docotrsSearch.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: DoctorCard(
                                  doctor: docotrsSearch[index],
                                ),
                              );
                            },
                          )
                        : _buildNoSearchResults()),
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
