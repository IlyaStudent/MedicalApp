import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/consts.dart';
import 'package:medical_app/pages/auth/stream_pade.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            // logo + text
            Column(
              children: [
                // logo
                Image.asset(
                  'lib/assets/img/dna_green.png',
                  width: MediaQuery.sizeOf(context).height * 0.1,
                ),
                // logo text
                const Text(
                  "МедОазис",
                  style: TextStyle(
                    fontSize: 34,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 30,
            ),
            Column(
              children: [
                const Text(
                  "Давайте начнем!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: headingTextColor),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 100,
                ),
                const Text(
                  "Войдите в аккаунт, чтобы  уже сегодня \nначать заботиться о своем здоровье!",
                  style: TextStyle(color: bodyTextColor, fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width / 8),
              child: Column(
                children: [
                  Button(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const StreamPage(showLoginPage: true);
                      }));
                    },
                    btnBackground: accentColor,
                    btnColor: Colors.white,
                    btnText: "Войти",
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 50,
                  ),
                  // reg button
                  Button(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const StreamPage(showLoginPage: false);
                      }));
                    },
                    btnBackground: Colors.transparent,
                    btnColor: accentColor,
                    btnText: "Зарегистрироваться",
                  ),
                ],
              ),
            ),

            // login button
          ],
        ),
      )),
    );
  }
}
