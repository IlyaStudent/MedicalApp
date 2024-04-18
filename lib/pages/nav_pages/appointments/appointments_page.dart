import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/appointment_card.dart';
import 'package:medical_app/components/my_segment_controller.dart';
import 'package:medical_app/components/shimmer_appointment_card.dart';
import 'package:medical_app/components/shimmer_d_card.dart';
import 'package:medical_app/services/appoint_info.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/firebase_database.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  late Future<Map<String, dynamic>> upcomingData;
  Map<String, dynamic>? upcomingAppointments;
  int segmentSelected = 0;
  List<String>? upcomingKeys;

  void changeSegment(int newSegment) {
    setState(() {
      segmentSelected = newSegment;
    });
    upcomingData = FireBaseDatabase().getUpcomingAppointments(
        FirebaseAuth.instance.currentUser!.uid.toString(),
        (segmentSelected == 0) ? false : true);
  }

  @override
  void initState() {
    super.initState();
    upcomingData = FireBaseDatabase().getUpcomingAppointments(
        FirebaseAuth.instance.currentUser!.uid.toString(),
        (segmentSelected == 0) ? false : true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Записи",
          style: TextStyle(fontWeight: FontWeight.w500, color: mainTextColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        child: Column(children: [
          MySegmentedController(
            text: const ["Активные", "Завершенные"],
            onChange: changeSegment,
            selectedSegment: segmentSelected,
          ),
          FutureBuilder(
            future: upcomingData,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return const ListTile(title: ShimmerDoctorCard());
                  },
                );
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // Получаем данные из Future
              upcomingAppointments = snapshot.data;
              upcomingKeys = upcomingAppointments?.keys.toList();
              return (upcomingAppointments!.isEmpty)
                  ? _buildNoResults(context)
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: ListView.builder(
                          itemCount: upcomingAppointments!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: AppointmentCard(
                                isOver: (segmentSelected == 0) ? false : true,
                                appointmentInfo: AppointInfo.fromJson(
                                    json: upcomingAppointments?[
                                        upcomingKeys?[index]],
                                    appointmentId: upcomingKeys?[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    );
            }),
          )
        ]),
      ),
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.65,
      child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.search_off_outlined,
          color: mainTextColor,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.05,
        ),
        const Text(
          "У вас нет записей",
          style: TextStyle(fontSize: 20, color: mainTextColor),
        ),
      ])),
    );
  }
}
