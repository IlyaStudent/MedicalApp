import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/pages/nav_pages/account_page.dart';
import 'package:medical_app/pages/nav_pages/appointments_page.dart';
import 'package:medical_app/pages/doctors_pages/doctors_page.dart';
import 'package:medical_app/pages/nav_pages/home_page.dart';
import 'package:medical_app/pages/nav_pages/hospitals/hospitals_page.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class Home extends StatefulWidget {
  final int pageNum;
  const Home({super.key, this.pageNum = 2});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: widget.pageNum,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final List<String> _pagesTitles = [
    "Доктора",
    "Больницы",
    "Главная",
    "Записи",
    "Аккаунт"
  ];

  final List<IconData> _navbarIcons = [
    Icons.medical_services_rounded,
    Icons.location_on_rounded,
    Icons.home_rounded,
    Icons.calendar_month_rounded,
    Icons.account_box_rounded
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Главная",
        useSafeArea: true,
        labels: _pagesTitles,
        icons: _navbarIcons,
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(fontSize: 12, color: mainTextColor),
        tabIconColor: bodyTextColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: accentColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      appBar: AppBar(
        title: Text(
          _pagesTitles[_motionTabBarController!.index],
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: mainTextColor),
        ),
        centerTitle: true,
        actions: _motionTabBarController?.index == 4
            ? [
                IconButton(
                    onPressed: signUserOut, icon: const Icon(Icons.logout)),
              ]
            : null,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: const [
          DoctorsPage(),
          HospitalsPage(),
          HomePage(),
          AppointmentsPage(),
          AccountPage(),
        ],
      ),
    );
  }
}
