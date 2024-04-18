import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/my_alert_dialog.dart';
import 'package:medical_app/components/shimmer_appointment_card.dart';
import 'package:medical_app/pages/nav_pages/appointments/appoint_res_page.dart';
import 'package:medical_app/services/appoint_info.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';

class AppointmentCard extends StatefulWidget {
  final AppointInfo appointmentInfo;
  final bool isOver;

  const AppointmentCard(
      {super.key, required this.appointmentInfo, required this.isOver});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late Future<Map<String, dynamic>> doctorInfo;
  Doctor? doctor;

  @override
  void initState() {
    super.initState();
    doctorInfo =
        FireBaseDatabase().getDoctorInfo(widget.appointmentInfo.doctorId);
  }

  void cancelAppointment() {
    FireBaseDatabase().deleteAppointment(widget.appointmentInfo.appointmentId);
    widget.appointmentInfo.isFree = true;
    widget.appointmentInfo.problemDesc = "";
    widget.appointmentInfo.problemFile = "";
    widget.appointmentInfo.clientId = "";
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const Home(
                  pageNum: 3,
                )),
        (route) => false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog(
          titleText: "Запись отменена",
          messageText: "Запись успешно отменена",
          btnText: "Продолжить",
          function: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    FireBaseDatabase().makeNewAppointment(widget.appointmentInfo.toJson());
  }

  void showDetails() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AppointResPage(
                  appointInfo: widget.appointmentInfo,
                  doctor: doctor!,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: doctorInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerAppointmentCard();
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          var data = snapshot.data;

          doctor = Doctor.fromJson(widget.appointmentInfo.doctorId,
              data![widget.appointmentInfo.doctorId]);

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: cardBorderColor,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          doctor!.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainTextColor,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          doctor!.spec,
                          style: const TextStyle(
                              color: searchIconColor, fontSize: 12),
                        )
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        doctor!.photo,
                        width: MediaQuery.sizeOf(context).width * 0.15,
                        height: MediaQuery.sizeOf(context).width * 0.15,
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 15,
                      color: subheadingTextColor,
                    ),
                    Text(
                      "${widget.appointmentInfo.date.day}-${widget.appointmentInfo.date.month}-${widget.appointmentInfo.date.year}",
                      style: const TextStyle(
                          color: subheadingTextColor, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: subheadingTextColor,
                    ),
                    Text(
                      widget.appointmentInfo.time,
                      style: const TextStyle(
                          color: subheadingTextColor, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: widget.isOver ? accentColor : confirmColor,
                    ),
                    Text(
                      widget.isOver ? " Завершена" : " Вы записаны",
                      style: const TextStyle(
                          color: subheadingTextColor, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                    borderColor: secondaryColor,
                    btnBackground: secondaryColor,
                    btnColor: subheadingTextColor,
                    btnText: widget.isOver ? "Подробнее" : "Отменить запись",
                    borderRadius: 10,
                    onTap: widget.isOver ? showDetails : cancelAppointment),
              ],
            ),
          );
        });
  }
}
