import 'package:flutter/material.dart';
import 'package:medical_app/pages/nav_pages/doctors_pages/doctor_page.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';

class DoctorAvatar extends StatelessWidget {
  final Doctor doctor;
  const DoctorAvatar({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    print(doctor.photo);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DoctorPage(doctor: doctor);
        }));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              doctor.photo,
              width: 75,
              height: 75,
              fit: BoxFit.scaleDown,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              doctor.fullName,
              style: const TextStyle(fontSize: 10, color: mainTextColor),
            ),
          )
        ],
      ),
    );
  }
}
