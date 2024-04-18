import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:medical_app/components/doctor_card.dart';
import 'package:medical_app/services/appoint_info.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/services/doctor.dart';
import 'package:medical_app/services/firebase_database.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:readmore/readmore.dart';

class AppointResPage extends StatefulWidget {
  final AppointInfo appointInfo;
  final Doctor doctor;
  const AppointResPage(
      {super.key, required this.appointInfo, required this.doctor});

  @override
  State<AppointResPage> createState() => _AppointResPageState();
}

class _AppointResPageState extends State<AppointResPage> {
  String downloadText = "Скачать файл";
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

  String getDateInfo() {
    String dateInfo =
        "${numOfWeekDay[widget.appointInfo.date.weekday]}, ${numOfMonth[widget.appointInfo.date.month]}, ${widget.appointInfo.date.day.toString()}, ${widget.appointInfo.date.year} | ${widget.appointInfo.time}";
    return dateInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Результаты",
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
                  borderColor: Colors.white,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                const Text(
                  "Дата",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor,
                  ),
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
                        onPressed: () {},
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.01),
                  child: const Divider(
                    color: secondaryColor,
                    thickness: 1.5,
                  ),
                ),
                const Text(
                  "Жалоба",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor,
                  ),
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
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          color: accentColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.03,
                    ),
                    Text(
                      widget.appointInfo.problemDesc,
                      style: const TextStyle(
                        color: dateColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.01),
                  child: const Divider(
                    color: secondaryColor,
                    thickness: 1.5,
                  ),
                ),
                const Text(
                  "Результаты обследования",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                ReadMoreText(
                  widget.appointInfo.resultDesc,
                  textAlign: TextAlign.justify,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "Показать",
                  trimExpandedText: "Скрыть",
                  style: const TextStyle(color: subheadingTextColor),
                  moreStyle: const TextStyle(color: accentColor),
                  lessStyle: const TextStyle(color: accentColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.01),
                  child: const Divider(
                    color: secondaryColor,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.01),
                  child: const Text(
                    "Прикрепленный файл",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FileDownloader.downloadFile(
                        url: widget.appointInfo.resultFile,
                        name: "Results_${widget.appointInfo.clientId}",
                        onDownloadCompleted: (path) async {
                          setState(() {
                            downloadText = "Скачать файл";
                            OpenFile.open(path);
                          });

                          print(path);
                        },
                        onProgress: (res, progress) {
                          setState(() {
                            downloadText = " ${progress} %";
                          });
                        });
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.upload_file_outlined,
                            color: accentColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          downloadText,
                          style: const TextStyle(
                              color: subheadingTextColor,
                              decoration: TextDecoration.underline,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
