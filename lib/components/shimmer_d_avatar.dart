import 'package:flutter/material.dart';
import 'package:medical_app/components/doctor_avatar.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDoctorAvatar extends StatelessWidget {
  const ShimmerDoctorAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: DoctorAvatar(
        doctor: Doctor(
            doctorId: "1234",
            fullName: "Имя Фамилия",
            rating: 5.0,
            photo:
                "https://firebasestorage.googleapis.com/v0/b/medicalapp-ece20.appspot.com/o/doctors_images%2Fdoctor5.jpg?alt=media&token=82c30744-1433-4787-825a-169436f6be59",
            hospitalId: "",
            spec: "Специалзация",
            desc: "",
            hospitalName: "Филиал на улице"),
      ),
    );
  }
}
