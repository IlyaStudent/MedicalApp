import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAppointmentCard extends StatelessWidget {
  const ShimmerAppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade400,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Имя Фамилия",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Специализация",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/medicalapp-ece20.appspot.com/o/doctors_images%2Fdoctor5.jpg?alt=media&token=82c30744-1433-4787-825a-169436f6be59",
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      height: MediaQuery.sizeOf(context).width * 0.15,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ],
              ),
              const Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 15,
                  ),
                  Text(
                    "2024-12-12",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.access_time_rounded,
                    size: 15,
                  ),
                  Text(
                    "00:00",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  Text(
                    "Статус",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                  borderColor: Colors.grey.shade400,
                  btnBackground: Colors.grey.shade400,
                  btnColor: Colors.grey.shade400,
                  btnText: "Нажать",
                  borderRadius: 10,
                  onTap: null),
            ],
          ),
        ));
  }
}
