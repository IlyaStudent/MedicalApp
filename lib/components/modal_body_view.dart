import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/geo_files/map_point.dart';
import 'package:medical_app/services/preferences_service.dart';

class ModalBodyView extends StatefulWidget {
  const ModalBodyView({required this.point});

  final MapPoint point;

  @override
  State<ModalBodyView> createState() => _ModalBodyViewState();
}

class _ModalBodyViewState extends State<ModalBodyView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.point.name,
                style: const TextStyle(fontSize: 24, color: headingTextColor),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              Text(
                'г.${widget.point.city}, ${widget.point.adress}',
                style: const TextStyle(
                  fontSize: 16,
                  color: subheadingTextColor,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              Text(
                "Часы работы: ${widget.point.workHours}",
                style: const TextStyle(
                  fontSize: 14,
                  color: hintColor,
                ),
              ),
              Text(
                "Тел: ${widget.point.phoneNumber}",
                style: const TextStyle(
                  fontSize: 14,
                  color: hintColor,
                ),
              ),
              const SizedBox(height: 20),
              Button(
                  btnBackground: accentColor,
                  btnColor: Colors.white,
                  btnText: "Выбрать",
                  onTap: () {
                    PreferncesServices()
                        .setPreference("HospitalBranch", widget.point.name);
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    });
                  })
            ]),
      ),
    );
  }
}
