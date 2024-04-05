import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/consts.dart';

class IntroPage extends StatelessWidget {
  final String imagePath;
  final String imageText;
  const IntroPage(
      {super.key, required this.imagePath, required this.imageText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              Image.asset(
                imagePath,
                width: MediaQuery.sizeOf(context).width * 0.75,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.85,
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1.2],
                      colors: [gradeintColor, Colors.white],
                    )),
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 30,
                  ),
                  Text(
                    imageText,
                    style: const TextStyle(
                        color: headingTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
