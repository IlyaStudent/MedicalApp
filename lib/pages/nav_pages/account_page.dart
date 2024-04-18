import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/components/account_btn.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/pages/auth/login_or_register.dart';
import 'package:medical_app/pages/auth/stream_pade.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/nav_pages/doctors_pages/last_doctors_page.dart';
import 'package:medical_app/services/consts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/img/bg_img.png"),
                      alignment: Alignment(9, 0.7),
                      fit: BoxFit.none,
                      scale: 1)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.1),
                    child: const Icon(
                      Icons.account_circle_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  Text(
                    (FirebaseAuth.instance.currentUser!.displayName != null &&
                            FirebaseAuth
                                .instance.currentUser!.displayName!.isNotEmpty)
                        ? FirebaseAuth.instance.currentUser!.displayName!
                        : "User-${FirebaseAuth.instance.currentUser!.uid.substring(0, 10)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                ],
              ),
            ),

            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                child: Column(
                  children: [
                    AccountBtn(
                      iconData: Icons.calendar_month_outlined,
                      text: "Записи",
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home(
                                      pageNum: 0,
                                    )),
                            (route) => false);
                      },
                    ),
                    AccountBtn(
                      iconData: Icons.place_outlined,
                      text: "Выбор филилала",
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home(
                                      pageNum: 1,
                                    )),
                            (route) => false);
                      },
                    ),
                    AccountBtn(
                      iconData: Icons.calendar_month_outlined,
                      text: "Записи",
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home(
                                      pageNum: 0,
                                    )),
                            (route) => false);
                      },
                    ),
                    AccountBtn(
                      iconData: Icons.medical_services_outlined,
                      text: "Последние врачи",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LastDoctorsPage()));
                      },
                    ),
                    AccountBtn(
                        iconData: Icons.logout,
                        iconColor: alertColor,
                        textColor: alertColor,
                        text: "Выйти",
                        function: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const StreamPage(showLoginPage: true)),
                              (route) => false);
                        }),
                  ],
                ),
              ),
            )

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: Button(
            //       btnBackground: accentColor,
            //       btnColor: Colors.white,
            //       btnText: "Log out",
            //       onTap: () {
            //         FirebaseAuth.instance.signOut();
            //         Navigator.pushAndRemoveUntil(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (builder) =>
            //                     const StreamPage(showLoginPage: true)),
            //             (route) => false);
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
