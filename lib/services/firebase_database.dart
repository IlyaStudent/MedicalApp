import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_app/services/preferences_service.dart';

class FireBaseDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

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
        doctorsData[doc.id]["photo"] =
            await updateOneImageUrl(doctorsData[doc.id]["photo"]);
      }

      return doctorsData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching doctors: $e");
      }
      return {};
    }
  }

  Future<Map<String, dynamic>> getAllBranchDoctors() async {
    Map<String, dynamic> doctorsData = {};

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Doctors')
          .where("hospital_name",
              isEqualTo:
                  await PreferncesServices().getPreference("HospitalBranch"))
          .get();

      for (var doc in querySnapshot.docs) {
        doctorsData[doc.id] = doc.data();
        doctorsData[doc.id]["photo"] =
            await updateOneImageUrl(doctorsData[doc.id]["photo"]);
      }

      return doctorsData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching doctors: $e");
      }
      return {};
    }
  }

  Future<Map<String, dynamic>> getDoctorsByCat(String category) async {
    Map<String, dynamic> doctorsData = {};

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Doctors')
          .where("spec", isEqualTo: category)
          .get();

      for (var doc in querySnapshot.docs) {
        doctorsData[doc.id] = doc.data();
        doctorsData[doc.id]["photo"] =
            await updateOneImageUrl(doctorsData[doc.id]["photo"]);
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

  void updateImageUrl(Map<String, dynamic>? data) async {
    for (final info in data!.entries) {
      String photoReference =
          FirebaseStorage.instance.refFromURL(data[info.key]["photo"]).fullPath;
      String imageUrl = await storageRef.child(photoReference).getDownloadURL();
      data[info.key]["photo"] = imageUrl;
    }
  }

  Future<String> updateOneImageUrl(String photo) async {
    String photoReference = FirebaseStorage.instance.refFromURL(photo).fullPath;
    String imageUrl = await storageRef.child(photoReference).getDownloadURL();
    return imageUrl;
  }

  void makeNewAppointment(Map<String, dynamic> data) async {
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

  Future<Map<String, dynamic>> getUpcomingAppointments(
      String userId, bool isOver) async {
    Map<String, dynamic> upcomingAppointments = {};

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Appointments')
          .where("client_id", isEqualTo: userId)
          .where("isFree", isEqualTo: false)
          .where("is_overed", isEqualTo: isOver)
          .get();

      for (var doc in querySnapshot.docs) {
        upcomingAppointments[doc.id] = doc.data();
        if (upcomingAppointments[doc.id]["result_file"].toString().isNotEmpty) {
          upcomingAppointments[doc.id]["result_file"] = await updateOneImageUrl(
              upcomingAppointments[doc.id]["result_file"]);
        }
      }

      return upcomingAppointments;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching work days: $e");
      }
      return {};
    }
  }

  Future<Map<String, dynamic>> getDoctorInfo(String doctorId) async {
    Map<String, dynamic> doctorInfo = {};

    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('Doctors').doc(doctorId).get();

      doctorInfo[querySnapshot.id] = querySnapshot.data();
      doctorInfo[querySnapshot.id]["photo"] =
          await updateOneImageUrl(doctorInfo[querySnapshot.id]["photo"]);

      return doctorInfo;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching work days: $e");
      }
      return {};
    }
  }

  Future<List<String>> _getLastDoctorsIds(String userId) async {
    List<String> lastDoctors = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Appointments')
          .orderBy("date", descending: true)
          .limit(3)
          .where("client_id", isEqualTo: userId)
          .where("is_overed", isEqualTo: true)
          .get();

      for (var doc in querySnapshot.docs) {
        lastDoctors.add(doc["doctor_id"].toString());
      }

      return lastDoctors;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching work days: $e");
      }
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getLastDoctors(String userId) async {
    List<Map<String, dynamic>> lastDoctors = [];
    try {
      List<String> lastDoctorIds = await _getLastDoctorsIds(userId);
      for (var id in lastDoctorIds) {
        Map<String, dynamic> newData = await getDoctorInfo(id);
        lastDoctors.add(newData);
      }

      return lastDoctors;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching work days: $e");
      }
      return [];
    }
  }
}
