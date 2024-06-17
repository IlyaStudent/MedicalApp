import 'package:flutter/material.dart';
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
              child: const Text(
                "",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: const Text(
                "г.,",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: const Text(
                "Часы работы: ",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              child: const Text(
                "",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
