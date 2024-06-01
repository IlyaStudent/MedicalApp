import 'dart:async';

import 'package:flutter/material.dart';

import 'package:medical_app/services/consts.dart';
import 'package:medical_app/components/modal_body_view.dart';
import 'package:medical_app/services/firebase_database.dart';
import 'package:medical_app/services/geo_files/app_lat_long.dart';
import 'package:medical_app/services/geo_files/location_service.dart';
import 'package:medical_app/services/geo_files/map_point.dart';

import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class MapHospitals extends StatefulWidget {
  const MapHospitals({super.key});

  @override
  State<MapHospitals> createState() => _MapHospitalsState();
}

class _MapHospitalsState extends State<MapHospitals> {
  final mapControllerCompleter = Completer<YandexMapController>();
  late Future<Map<String, dynamic>> resFuture;

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
            anchor: const Offset(0.5, 1),
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
          builder: (context) => ModalBodyView(
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
            print(mapObjects);
            return YandexMap(
              onMapCreated: (controller) {
                _initMapController(controller);
              },
              mapObjects: mapObjects,
            );
          } else {
            return const Center(child: Text("Error fetching map objects"));
          }
        } else {
          return const Center(
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
