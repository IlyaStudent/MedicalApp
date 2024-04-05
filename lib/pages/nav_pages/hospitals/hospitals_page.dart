import 'package:flutter/material.dart';
import 'package:medical_app/consts.dart';
import 'package:medical_app/pages/nav_pages/hospitals/list_hospitals.dart';
import 'package:medical_app/pages/nav_pages/hospitals/map_hospitals.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HospitalsPage extends StatefulWidget {
  const HospitalsPage({super.key});

  @override
  State<HospitalsPage> createState() => _HospitalsPageState();
}

class _HospitalsPageState extends State<HospitalsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            labelColor: accentColor,
            unselectedLabelColor: hintColor,
            indicatorColor: accentColor,
            controller: _tabController,
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.list),
                    SizedBox(width: 5), // Add some spacing
                    Text('Списком'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                    ),
                    SizedBox(width: 5), // Add some spacing
                    Text('На карте'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [ListHospitals(), MapHospitals()],
        ));
  }
}
