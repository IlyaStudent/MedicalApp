import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/components/button.dart';
import 'package:medical_app/consts.dart';
import 'package:medical_app/services/firebase_database.dart';
import 'package:medical_app/services/geo_files/app_lat_long.dart';
import 'package:medical_app/services/geo_files/location_service.dart';
import 'package:medical_app/services/geo_files/map_point.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapHospitals extends StatefulWidget {
  const MapHospitals({super.key});

  @override
  State<MapHospitals> createState() => _MapHospitalsState();
}

class _MapHospitalsState extends State<MapHospitals> {
  final mapControllerCompleter = Completer<YandexMapController>();
  late Future<Map<String, dynamic>> resFuture;

  FutureOr<YandexMapController>? get controller => null;

  Future<List<MapPoint>> _getMapPointsData() async {
    List<MapPoint> mapPoints = [];
    Map<String, dynamic> hospitalsData = await resFuture;

    hospitalsData.forEach((key, value) {
      mapPoints.add(MapPoint(
        name: value["name"],
        latitude: value["latitude"],
        longitude: value["longitude"],
        city: value["city"],
        adress: value["adress"],
        phoneNumber: value["phoneNumber"],
        workHours: value["workHours"],
      ));
    });

    return mapPoints;
  }

  Future<List<PlacemarkMapObject>> _getPlacemarkObjects(
      BuildContext context) async {
    List<MapPoint> mapPoints = await _getMapPointsData();

    List<PlacemarkMapObject> placemarks = mapPoints.map((point) {
      return PlacemarkMapObject(
        mapId: MapObjectId('MapObject $point'),
        point: Point(latitude: point.latitude, longitude: point.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            anchor: Offset(0.5, 1),
            image: BitmapDescriptor.fromAssetImage(
              'lib/assets/img/hospital_loc.png',
            ),
            scale: 0.5,
          ),
        ),
        onTap: (_, __) => showModalBottomSheet(
          context: context,
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          barrierColor: Colors.transparent,
          builder: (context) => _ModalBodyView(
            point: point,
          ),
        ),
      );
    }).toList();

    return placemarks;
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 13,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
    resFuture = FireBaseDatabase().getAllHospitals();
  }

  void _initMapController(YandexMapController controller) {
    if (!mapControllerCompleter.isCompleted) {
      mapControllerCompleter.complete(controller);
    } else {
      print('Completer is already completed');
    }
  }

  Widget _buildMapObjects(BuildContext context) {
    return FutureBuilder(
      future: _getPlacemarkObjects(context),
      builder: (BuildContext context,
          AsyncSnapshot<List<PlacemarkMapObject>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<MapObject<dynamic>> mapObjects =
                snapshot.data!.cast<MapObject<dynamic>>();
            return YandexMap(
              onMapCreated: (controller) {
                _initMapController(controller);
              },
              mapObjects: mapObjects,
            );
          } else {
            return Center(child: Text("Error fetching map objects"));
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(accentColor),
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMapObjects(context),
    );
  }
}

class _ModalBodyView extends StatefulWidget {
  const _ModalBodyView({required this.point});

  final MapPoint point;

  @override
  State<_ModalBodyView> createState() => _ModalBodyViewState();
}

class _ModalBodyViewState extends State<_ModalBodyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.point.name,
                style: const TextStyle(fontSize: 24, color: headingTextColor),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              Text(
                'г.${widget.point.city}, ${widget.point.adress}',
                style: const TextStyle(
                  fontSize: 16,
                  color: subheadingTextColor,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              Text(
                "Часы работы: ${widget.point.workHours}",
                style: TextStyle(
                  fontSize: 14,
                  color: hintColor,
                ),
              ),
              Text(
                "Тел: ${widget.point.phoneNumber}",
                style: TextStyle(
                  fontSize: 14,
                  color: hintColor,
                ),
              ),
              const SizedBox(height: 20),
              Button(
                  btnBackground: accentColor,
                  btnColor: Colors.white,
                  btnText: "Выбрать",
                  onTap: () {
                    PreferncesServices()
                        .setPreference("HospitalBranch", widget.point.name);
                    setState(() {
                      Home.updateVisit(2);
                      Navigator.pushReplacementNamed(context, "/homepage");
                    });
                  })
            ]),
      ),
    );
  }
}
