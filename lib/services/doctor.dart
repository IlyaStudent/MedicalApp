import 'package:medical_app/services/firebase_database.dart';

class Doctor {
  String doctorId;
  String fullName;
  double rating;
  String photo;
  String hospitalId;
  String spec;
  String desc;
  String hospitalName;

  Doctor({
    required this.doctorId,
    required this.fullName,
    required this.rating,
    required this.photo,
    required this.hospitalId,
    required this.spec,
    required this.desc,
    required this.hospitalName,
  });

  Future<void> updateImageUrl() async {
    String imageUrl = await FireBaseDatabase().updateOneImageUrl(this.photo);
    this.photo = imageUrl;
  }

  Doctor copyWith({
    String? doctorId,
    String? fullName,
    double? rating,
    String? photo,
    String? hospitalId,
    String? spec,
    String? desc,
    String? hospitalName,
  }) =>
      Doctor(
        doctorId: doctorId ?? this.doctorId,
        fullName: fullName ?? this.fullName,
        rating: rating ?? this.rating,
        photo: photo ?? this.photo,
        hospitalId: hospitalId ?? this.hospitalId,
        spec: spec ?? this.spec,
        desc: desc ?? this.desc,
        hospitalName: hospitalName ?? this.hospitalName,
      );

  factory Doctor.fromJson(String doctorId, Map<String, dynamic> json) => Doctor(
        doctorId: doctorId,
        fullName: json["full_name"],
        rating: json["rating"]?.toDouble(),
        photo: json["photo"],
        hospitalId: json["hospital_id"],
        spec: json["spec"],
        desc: json["desc"],
        hospitalName: json["hospital_name"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "rating": rating,
        "photo": photo,
        "hospital_id": hospitalId,
        "spec": spec,
        "desc": desc,
        "hospital_name": hospitalName,
      };
}
