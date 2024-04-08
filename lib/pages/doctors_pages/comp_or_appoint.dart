import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/doctors_pages/appoint_info.dart';
import 'package:medical_app/pages/doctors_pages/appointment_page.dart';
import 'package:medical_app/pages/doctors_pages/complaints_page.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';

class CompOrAppointPage extends StatefulWidget {
  final AppointInfo appointmentInfo;
  final Doctor doctor;
  const CompOrAppointPage(
      {super.key, required this.appointmentInfo, required this.doctor});

  @override
  State<CompOrAppointPage> createState() => _CompOrAppointPageState();
}

class _CompOrAppointPageState extends State<CompOrAppointPage> {
  bool showCompPage = true;

  void backToCompPage() async {
    setState(() {
      showCompPage = true;
    });
  }

  Future<void> confirmAppointmentInfo() async {
    if (await FireBaseDatabase()
        .deleteAppointment(widget.appointmentInfo.appointmentId)) {
      if (widget.appointmentInfo.problemFile.isNotEmpty) {
        File file = File(widget.appointmentInfo.problemFile);
        widget.appointmentInfo.problemFile =
            await FireBaseDatabase().uploadProblemFile(file);
      }

      FireBaseDatabase().makeNewAppointment(widget.appointmentInfo.toJson());
    }
  }

  void applyComplaints(String problemFile, String problemDesc) {
    widget.appointmentInfo.problemFile = problemFile;
    widget.appointmentInfo.problemDesc = problemDesc;
    setState(() {
      showCompPage = false;
    });
    widget.appointmentInfo.isFree = false;
  }

  @override
  Widget build(BuildContext context) {
    if (showCompPage) {
      return ComplaintsPage(
        onBtnClick: applyComplaints,
      );
    } else {
      return AppointmentPage(
        onChangeClick: backToCompPage,
        doctor: widget.doctor,
        appointInfo: widget.appointmentInfo,
        onSubmitClick: confirmAppointmentInfo,
      );
    }
  }
}
