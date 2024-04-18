import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/services/consts.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHospitalInfo extends StatelessWidget {
  const ShimmerHospitalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: Text(
                "",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: Text(
                "г.,",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: Text(
                "Часы работы: ",
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: Text(
                "",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
