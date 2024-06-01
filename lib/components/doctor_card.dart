import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/pages/nav_pages/doctors_pages/doctor_page.dart';
import 'package:medical_app/services/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final Color borderColor;
  const DoctorCard(
      {super.key, required this.doctor, this.borderColor = cardBorderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (borderColor == cardBorderColor)
          ? () {
              print(doctor.photo);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorPage(doctor: doctor);
              }));
            }
          : null,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor, width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    doctor.photo,
                    width: 120,
                    height: 120,
                    fit: BoxFit.scaleDown,
                  ).animate().fadeIn(delay: 500.ms),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.fullName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: mainTextColor),
                      ),
                      Text(
                        doctor.spec,
                        style: const TextStyle(
                            fontSize: 12, color: searchIconColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              size: 20,
                              Icons.star_rate_rounded,
                              color: accentColor,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              doctor.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: accentColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        const Icon(
                          size: 20,
                          Icons.place_rounded,
                          color: searchIconColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          doctor.hospitalName,
                          style: const TextStyle(
                              color: searchIconColor, fontSize: 10),
                        ),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
