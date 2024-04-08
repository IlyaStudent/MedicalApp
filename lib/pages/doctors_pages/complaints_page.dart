import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/components/my_text_field.dart';
import 'package:medical_app/services/consts.dart';

class ComplaintsPage extends StatefulWidget {
  final Function(String, String)? onBtnClick;
  const ComplaintsPage({super.key, this.onBtnClick});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  TextEditingController problemDescController = TextEditingController();
  String problemAttached = "Файл не выбран";
  String problemFile = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Жалобы на здоровье"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.1,
            vertical: MediaQuery.sizeOf(context).height * 0.05,
          ),
          child: Column(
            children: [
              MyTextField(
                prefixIcon: Icons.edit_note_rounded,
                hintText: "Опишите свою проблему",
                controller: problemDescController,
                maxLines: 10,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null && result.files.single.path != null) {
                    File file = File(result.files.single.path!);
                    problemFile = file.path;

                    setState(() {
                      problemAttached = result.files.first.name;
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      size: 40,
                      Icons.upload_file_outlined,
                      color: accentColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      problemAttached,
                      style: const TextStyle(
                          color: subheadingTextColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              Button(
                  btnBackground: accentColor,
                  btnColor: Colors.white,
                  btnText: "Продолжить",
                  onTap: () async {
                    await widget.onBtnClick!(
                        problemFile, problemDescController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
