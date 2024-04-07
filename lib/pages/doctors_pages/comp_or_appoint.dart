import 'package:flutter/material.dart';
import 'package:medical_app/pages/doctors_pages/appoint_info.dart';
import 'package:medical_app/pages/doctors_pages/appointment_page.dart';
import 'package:medical_app/pages/doctors_pages/complaints_page.dart';

class CompOrAppointPage extends StatefulWidget {
  final AppointInfo appointmentInfo;
  const CompOrAppointPage({super.key, required this.appointmentInfo});

  @override
  State<CompOrAppointPage> createState() => _CompOrAppointPageState();
}

class _CompOrAppointPageState extends State<CompOrAppointPage> {
  bool showCompPage = true;

  void backToCompPage() {
    print(widget.appointmentInfo.toJson());
    setState(() {
      showCompPage = true;
    });
  }

  void applyComplaints(String problemFile, String problemDesc) {
    widget.appointmentInfo.problemFile = problemFile;
    widget.appointmentInfo.problemDesc = problemDesc;
    setState(() {
      showCompPage = false;
    });

    print(widget.appointmentInfo.toJson());
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
      );
    }
  }
}
