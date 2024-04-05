import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class DoctorPage extends StatefulWidget {
  final Doctor doctor;
  const DoctorPage({super.key, required this.doctor});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool showAllText = false;
  DateTime now = DateTime.now();

  Map<String, String> getFutureDay(int days) {
    DateTime now = DateTime.now();
    DateTime futureDate = now.add(Duration(days: days));

    String futureDay = DateFormat('EEEE').format(futureDate);
    String futureDayNumber = futureDate.day.toString();
    switch (futureDay) {
      case "Monday":
        futureDay = 'ПН';
      case "Tuesday":
        futureDay = 'ВТ';
      case "Wednesday":
        futureDay = 'СР';
      case "Thursday":
        futureDay = 'ЧТ';
      case "Friday":
        futureDay = 'ПТ';
      case "Saturday":
        futureDay = 'СБ';
      case "Sunday":
        futureDay = 'ВС';
    }
    ;

    return {
      'dayNumber': futureDayNumber,
      'dayOfWeek': futureDay,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Доп информация",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.03,
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorCard(
                  doctor: widget.doctor,
                  borderColor: Colors.transparent,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                const Text(
                  "О враче",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainTextColor),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                ReadMoreText(
                  widget.doctor.desc,
                  textAlign: TextAlign.justify,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "Показать",
                  trimExpandedText: "Скрыть",
                  style: const TextStyle(color: subheadingTextColor),
                  moreStyle: const TextStyle(color: accentColor),
                  lessStyle: const TextStyle(color: accentColor),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                _buildDates(context)
              ],
            ),
          ),
        ));
  }

  Widget _buildDates(BuildContext context) {
    final List<Widget> dateContainers = List.generate(11, (index) {
      return _buildDateContainer(context, getFutureDay(index));
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: dateContainers),
    );
  }

  Widget _buildDateContainer(
      BuildContext context, Map<String, String> dayInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: cardBorderColor),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          child: Column(
            children: [
              Text(
                dayInfo["dayOfWeek"]!,
                style: const TextStyle(color: bodyTextColor, fontSize: 12),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                dayInfo["dayNumber"]!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
