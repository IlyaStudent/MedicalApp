import 'package:equatable/equatable.dart';

class MapPoint extends Equatable {
  const MapPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.adress,
    required this.phoneNumber,
    required this.workHours,
  });
  final String name;
  final String city;
  final double latitude;
  final double longitude;
  final String adress;
  final String phoneNumber;
  final String workHours;

  @override
  List<Object?> get props =>
      [city, latitude, longitude, adress, phoneNumber, workHours];
}
