import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireBaseDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getAllHospitals() async {
    Map<String, dynamic> hospitalsData = {};

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Hospitals').get();

      for (var doc in querySnapshot.docs) {
        hospitalsData[doc.id] = doc.data();
      }

      return hospitalsData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching hospitals: $e");
      }
      return {};
    }
  }

  Future<Map<String, dynamic>> getAllDoctors() async {
    Map<String, dynamic> doctorsData = {};

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Doctors').get();

      for (var doc in querySnapshot.docs) {
        doctorsData[doc.id] = doc.data();
      }

      return doctorsData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching doctors: $e");
      }
      return {};
    }
  }
}
