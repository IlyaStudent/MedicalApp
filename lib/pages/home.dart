import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/consts.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:medical_app/pages/nav_pages/account_page.dart';
import 'package:medical_app/pages/nav_pages/appointments_page.dart';
import 'package:medical_app/pages/doctors_pages/doctors_page.dart';
import 'package:medical_app/pages/nav_pages/home_page.dart';
import 'package:medical_app/pages/nav_pages/hospitals/hospitals_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
  static int visit = 2;

  static void updateVisit(int newValue) {
    visit = newValue;
  }
}

class _HomeState extends State<Home> {
  int visit = Home.visit;
  void updateVisitValue(int newValue) {
    Home.updateVisit(newValue);
    setState(() {
      // Вызов метода setState() для обновления отображения на экране
    });
  }

  List<TabItem> items = [
    const TabItem(
      icon: Icons.medical_services_rounded,
      title: 'Доктора',
    ),
    const TabItem(
      icon: Icons.location_on_rounded,
      title: 'Больница',
    ),
    const TabItem(
      icon: Icons.home_rounded,
      title: 'Главная',
    ),
    const TabItem(
      icon: Icons.calendar_month_rounded,
      title: 'Записи',
    ),
    const TabItem(
      icon: Icons.account_box_rounded,
      title: 'Аккаунт',
    ),
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final List<String> _pagesTitles = [
    "Доктора",
    "Больницы",
    "",
    "Записи",
    "Аккаунт"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarInspiredOutside(
        isAnimated: true,
        duration: Durations.extralong3,
        items: items,
        backgroundColor: Colors.white,
        color: bodyTextColor,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
        }),
        top: -28,
        animated: false,
        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(
            notchSmoothness: NotchSmoothness.softEdge, background: accentColor),
      ),
      appBar: AppBar(
        title: Text(
          _pagesTitles[visit],
          style: TextStyle(fontWeight: FontWeight.w500, color: mainTextColor),
        ),
        centerTitle: true,
        actions: visit == 4
            ? [
                IconButton(
                    onPressed: signUserOut, icon: const Icon(Icons.logout)),
              ]
            : null,
      ),
      body: IndexedStack(
        index: visit,
        children: [
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
