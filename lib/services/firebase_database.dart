import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<Map<String, dynamic>> getWorkDays(String doctorId) async {
    Map<String, dynamic> workDays = {};

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Appointments')
          .where("doctor_id", isEqualTo: doctorId)
          .where("isFree", isEqualTo: true)
          //.orderBy("date", descending: true)
          .get();

      for (var doc in querySnapshot.docs) {
        workDays[doc.id] = doc.data();
      }

      return workDays;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching work days: $e");
      }
      return {};
    }
  }

  Future<bool> checkAppointementExist(appointemtnId) async {
    try {
      DocumentSnapshot ref =
          await _firestore.collection("Appointments").doc(appointemtnId).get();
      return ref.data().toString() != "null";
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAppointment(appointmentId) async {
    final checkExist = checkAppointementExist(appointmentId);
    if (await checkExist) {
      try {
        await _firestore.collection("Appointments").doc(appointmentId).delete();

        return true;
      } catch (error) {
        return false;
      }
    }
    return false;
  }

  void makeNewAppointment(data) async {
    try {
      await _firestore
          .collection("Appointments")
          .add(data)
          .then((documentId) => print("added data with $documentId"));
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadProblemFile(File file) async {
    late String pathString;
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = file.path.split("/").last;
      final currTime = DateTime.now().microsecondsSinceEpoch;
      final uploadFile =
          storageRef.child("user_files/$userId/$currTime-$fileName");

      await uploadFile.putFile(file).whenComplete(
          () async => pathString = await uploadFile.getDownloadURL());

      return pathString;
    } catch (e) {
      return pathString;
    }
  }
}
