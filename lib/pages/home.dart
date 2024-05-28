import 'package:flutter/material.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/pages/nav_pages/account_page.dart';
import 'package:medical_app/pages/nav_pages/appointments/appointments_page.dart';
import 'package:medical_app/pages/nav_pages/doctors_pages/doctors_page.dart';
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
        initialSelectedTab: _pagesTitles[_motionTabBarController!.index],
        useSafeArea: true,
        labels: _pagesTitles,
        icons: _navbarIcons,
        tabSize: 50,
        tabBarHeight: 60,
        textStyle: const TextStyle(
            fontSize: 12, color: bodyTextColor, fontWeight: FontWeight.w500),
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
