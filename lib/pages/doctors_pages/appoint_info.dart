class AppointInfo {
  DateTime date;
  String doctorId;
  bool isFree;
  String problemDesc;
  String time;
  String clientId;
  String problemFile;
  String appointmentId;

  AppointInfo({
    required this.date,
    required this.doctorId,
    required this.isFree,
    required this.problemDesc,
    required this.time,
    required this.clientId,
    required this.problemFile,
    required this.appointmentId,
  });

  AppointInfo copyWith(
          {DateTime? date,
          String? doctorId,
          bool? isFree,
          String? problemDesc,
          String? time,
          String? clientId,
          String? problemFile,
          String? appointmentId}) =>
      AppointInfo(
        date: date ?? this.date,
        doctorId: doctorId ?? this.doctorId,
        isFree: isFree ?? this.isFree,
        problemDesc: problemDesc ?? this.problemDesc,
        time: time ?? this.time,
        clientId: clientId ?? this.clientId,
        problemFile: problemFile ?? this.problemFile,
        appointmentId: appointmentId ?? this.appointmentId,
      );

  factory AppointInfo.fromJson(Map<String, dynamic> json) => AppointInfo(
        date: DateTime.parse(json["date"]),
        doctorId: json["doctor_id"],
        isFree: json["isFree"],
        problemDesc: json["problem_desc"],
        time: json["time"],
        clientId: json["client_id"],
        problemFile: json["problem_file"],
        appointmentId: json["appointment_id"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "doctor_id": doctorId,
        "isFree": isFree,
        "problem_desc": problemDesc,
        "time": time,
        "client_id": clientId,
        "problem_file": problemFile,
      };
}
