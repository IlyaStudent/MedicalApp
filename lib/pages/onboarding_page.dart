import 'package:flutter/material.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/pages/intro_pages/intro_page.dart';
import 'package:medical_app/pages/auth/start_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          // skip button

          // page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage(
                imagePath: "lib/assets/img/doctor1.png",
                imageText: "Консультируйся у проверенных врачей",
              ),
              IntroPage(
                imagePath: "lib/assets/img/doctor2.png",
                imageText: "Все специлиасты в одном месте",
              ),
              IntroPage(
                imagePath: "lib/assets/img/doctor3.png",
                imageText: "Выбирай удобное тебе время",
              ),
            ],
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StartPage();
              }));
            },
            child: Container(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).height / 30),
              alignment: Alignment.topRight,
              child: const Text(
                "Далее",
                style: TextStyle(fontSize: 16, color: bodyTextColor),
              ),
            ),
          ),

          // dot indicator
          Container(
              alignment: const Alignment(0.0, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      dotColor: secondaryColor,
                      activeDotColor: accentColor,
                      dotWidth: 30,
                    ),
                  ),

                  // next button
                  GestureDetector(
                    onTap: () {
                      print(onLastPage);
                      if (onLastPage) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return StartPage();
                        }));
                      }
                      _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.all(MediaQuery.sizeOf(context).width / 20),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
