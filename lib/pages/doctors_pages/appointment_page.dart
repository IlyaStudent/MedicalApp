import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  final Function()? onChangeClick;
  const AppointmentPage({super.key, this.onChangeClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Запись"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Appointment"),
          GestureDetector(
            onTap: onChangeClick,
            child: Text("Change"),
          )
        ],
      ),
    );
  }
}
