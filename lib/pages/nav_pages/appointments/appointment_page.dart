import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/components/my_alert_dialog.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/appoint_info.dart';
import 'package:medical_app/services/doctor.dart';

class AppointmentPage extends StatelessWidget {
  final Doctor doctor;
  final AppointInfo appointInfo;
  final Function()? onChangeClick;
  final Function()? onSubmitClick;
  static const Map<int, String> numOfMonth = {
    1: "Янв.",
    2: "Фев.",
    3: "Март",
    4: "Апр.",
    5: "Май",
    6: "Июнь",
    7: "Июль",
    8: "Авг.",
    9: "Сент.",
    10: "Окт.",
    11: "Нояб.",
    12: "Дек.",
  };
  static const Map<int, String> numOfWeekDay = {
    1: "ПН",
    2: "ВТ",
    3: "СР",
    4: "ЧТ",
    5: "ПТ",
    6: "СБ",
    7: "ВС",
  };

  const AppointmentPage(
      {super.key,
      this.onChangeClick,
      required this.doctor,
      required this.appointInfo,
      this.onSubmitClick});

  String getDateInfo() {
    String dateInfo =
        "${numOfWeekDay[appointInfo.date.weekday]}, ${numOfMonth[appointInfo.date.month]}, ${appointInfo.date.day.toString()}, ${appointInfo.date.year} | ${appointInfo.time}";
    return dateInfo;
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog(
          titleText: "Вы записаны!",
          messageText:
              "Запись создана, всю информацию вы можете просмотреть в разделе \"Записи\"",
          function: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Запись",
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
            children: [
              DoctorCard(doctor: doctor),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              // Date and change
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Дата",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Изменить",
                      style: TextStyle(color: searchIconColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              // date
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.calendar_month_rounded,
                        color: accentColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.03,
                  ),
                  Text(
                    getDateInfo(),
                    style: const TextStyle(
                      color: dateColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Divider(
                color: secondaryColor,
                thickness: 1.5,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              // problem desc comp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Жалобы",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: onChangeClick,
                    child: const Text(
                      "Изменить",
                      style: TextStyle(color: searchIconColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),

              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      onPressed: onChangeClick,
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: accentColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.03,
                  ),
                  Text(
                    appointInfo.problemDesc.isEmpty
                        ? appointInfo.problemFile.isEmpty
                            ? "Нет жалоб"
                            : "Файл прикреплен"
                        : (appointInfo.problemDesc.length > 20)
                            ? "${appointInfo.problemDesc.substring(0, 20)}..."
                            : appointInfo.problemDesc,
                    style: const TextStyle(
                      color: dateColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Divider(
                color: secondaryColor,
                thickness: 1.5,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),

              Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Общие рекомендации: ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      const Text(
                        "\t1. Не задерживайтесь",
                        style: TextStyle(color: hintColor),
                      ),
                      const Text(
                        "\t2. Говорите все, что беспокоит",
                        style: TextStyle(color: hintColor),
                      ),
                      const Text(
                        "\t3. Внимательно слушайте врача\n\tи задавайте вопросы",
                        style: TextStyle(color: hintColor),
                      ),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Divider(
                color: secondaryColor,
                thickness: 1.5,
              ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Оплата после консультации! \n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Дата: ",
                        style: TextStyle(color: hintColor),
                      ),
                      Text(
                        "${appointInfo.date.day}.${appointInfo.date.month}.${appointInfo.date.year}",
                        style: const TextStyle(
                            color: mainTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: Button(
                      btnBackground: accentColor,
                      btnColor: Colors.white,
                      btnText: "Записаться",
                      onTap: () {
                        onSubmitClick!();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (route) => false);
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const Home()),
                        // );
                        showConfirmationDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().then().scale(),
    );
  }
}
