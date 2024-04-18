import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/appoint_info.dart';
import 'package:medical_app/pages/nav_pages/appointments/comp_or_appoint.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/services/firebase_database.dart';
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
  String? daySelected;
  String? hourSelected;
  late Future<Map<String, dynamic>> doctorWorkDays;
  Map<String, dynamic>? workDaysdata = {};
  List<List<String>> workHours = [
    [
      "10:00",
      "11:00",
      "12:00",
    ],
    [
      "13:00",
      "14:00",
      "15:00",
    ],
    [
      "16:00",
      "17:00",
      "18:00",
    ],
  ];

  @override
  void initState() {
    super.initState();
    doctorWorkDays = FireBaseDatabase().getWorkDays(widget.doctor.doctorId);
  }

  bool checkDate(String date) {
    for (final info in workDaysdata!.entries) {
      if (info.value["date"] == date) {
        return true;
      }
    }
    return false;
  }

  bool checkTime(String hour) {
    for (final info in workDaysdata!.entries) {
      if (info.value["date"] == daySelected) {
        if (info.value["time"] == hour) {
          return true;
        }
      }
    }
    return false;
  }

  Map<String, String> getFutureDay(int days) {
    DateTime futureDate = now.add(Duration(days: days));

    String futureDay = DateFormat('EEEE').format(futureDate);
    String futureDayNumber = futureDate.day.toString();
    switch (futureDay) {
      case "Monday":
        futureDay = "ПН";
      case "Tuesday":
        futureDay = "ВТ";
      case "Wednesday":
        futureDay = "СР";
      case "Thursday":
        futureDay = "ЧТ";
      case "Friday":
        futureDay = "ПТ";
      case "Saturday":
        futureDay = "СБ";
      case "Sunday":
        futureDay = "ВС";
    }
    ;

    return {
      'dayNumber': futureDayNumber,
      'dayOfWeek': futureDay,
      'fullDate': futureDate.toString().split(" ")[0],
      //"${futureDayNumber}-${futureDate.month}-${futureDate.year}"
    };
  }

  Map<String, dynamic> getAppointmentInfo() {
    for (final info in workDaysdata!.entries) {
      if (info.value["date"] == daySelected &&
          info.value["time"] == hourSelected) {
        info.value["client_id"] = FirebaseAuth.instance.currentUser?.uid;
        info.value["appointment_id"] = info.key;
        return info.value;
      }
    }
    return {};
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
              horizontal: MediaQuery.sizeOf(context).width * 0.06),
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
              _buildDates(context),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              const Divider(
                color: cardBorderColor,
                thickness: 2,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              (daySelected != null)
                  ? _buildTimes(context).animate().scale()
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              (hourSelected != null)
                  ? Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: Button(
                            btnBackground: accentColor,
                            btnColor: Colors.white,
                            btnText: "Забронировать",
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CompOrAppointPage(
                                  doctor: widget.doctor,
                                  appointmentInfo: AppointInfo.fromJson(
                                    json: getAppointmentInfo(),
                                  ),
                                );
                              }));
                            }).animate().scale(),
                      ),
                    )
                  : const SizedBox(),
            ],
          ).animate().scale(),
        ),
      ),
    );
  }

  Widget _buildDates(BuildContext context) {
    final List<Widget> dateContainers = List.generate(11, (index) {
      Map<String, String> dayInfo = getFutureDay(index);
      return FutureBuilder(
        future: doctorWorkDays,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center();
          }

          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }

          workDaysdata = snapshot.data;

          return _buildDateContainer(
              context, dayInfo, (checkDate(dayInfo["fullDate"]!)));
        },
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: dateContainers),
    );
  }

  Widget _buildTimes(BuildContext context) {
    final List<Widget> timeRowContainers = List.generate(3, (indexCol) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (indexRow) {
          return _buildTimeContainer(context, workHours[indexCol][indexRow],
              checkTime(workHours[indexCol][indexRow]));
        }),
      );
    });

    return Column(
      children: timeRowContainers,
    );
  }

  Widget _buildTimeContainer(
      BuildContext context, String workHour, bool available) {
    return GestureDetector(
      onTap: available
          ? () {
              setState(() {
                hourSelected = workHour;
              });
            }
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.01),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: MediaQuery.sizeOf(context).width * 0.085),
          decoration: BoxDecoration(
              color: (hourSelected != null)
                  ? (hourSelected == workHour)
                      ? accentColor
                      : Colors.white
                  : Colors.white,
              border: Border.all(
                color: available
                    ? (hourSelected != null)
                        ? (hourSelected == workHour)
                            ? accentColor
                            : availabaleTimeColor
                        : availabaleTimeColor
                    : notAvailableTimeColor,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            workHour,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: available
                  ? (hourSelected != null)
                      ? (hourSelected == workHour)
                          ? Colors.white
                          : mainTextColor
                      : mainTextColor
                  : notAvailableTimeColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateContainer(
      BuildContext context, Map<String, String> dayInfo, bool available) {
    return GestureDetector(
      onTap: available
          ? () {
              setState(() {
                daySelected = dayInfo["fullDate"];
                hourSelected = null;
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: (daySelected != null)
                  ? (daySelected! == dayInfo["fullDate"]!)
                      ? accentColor
                      : Colors.transparent
                  : Colors.transparent,
              border: Border.all(
                  color: available ? availabaleTimeColor : cardBorderColor),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Text(
                dayInfo["dayOfWeek"]!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: (daySelected != null)
                        ? (daySelected! == dayInfo["fullDate"]!)
                            ? Colors.white
                            : available
                                ? bodyTextColor
                                : cardBorderColor
                        : available
                            ? bodyTextColor
                            : cardBorderColor,
                    fontSize: 12),
              ),
              Text(
                dayInfo["dayNumber"]!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: (daySelected != null)
                      ? (daySelected! == dayInfo["fullDate"]!)
                          ? Colors.white
                          : available
                              ? mainTextColor
                              : cardBorderColor
                      : available
                          ? mainTextColor
                          : cardBorderColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
