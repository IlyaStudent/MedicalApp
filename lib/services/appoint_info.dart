class AppointInfo {
  DateTime date;
  String doctorId;
  bool isFree;
  String problemDesc;
  String time;
  String clientId;
  String problemFile;
  String appointmentId;
  bool isOver;
  String resultDesc;
  String resultFile;

  AppointInfo(
      {required this.date,
      required this.doctorId,
      required this.isFree,
      required this.problemDesc,
      required this.time,
      required this.clientId,
      required this.problemFile,
      required this.appointmentId,
      required this.isOver,
      required this.resultDesc,
      required this.resultFile});

  AppointInfo copyWith({
    DateTime? date,
    String? doctorId,
    bool? isFree,
    String? problemDesc,
    String? time,
    String? clientId,
    String? problemFile,
    String? appointmentId,
    bool? isOver,
    String? resultDesc,
    String? resultFile,
  }) =>
      AppointInfo(
        date: date ?? this.date,
        doctorId: doctorId ?? this.doctorId,
        isFree: isFree ?? this.isFree,
        problemDesc: problemDesc ?? this.problemDesc,
        time: time ?? this.time,
        clientId: clientId ?? this.clientId,
        problemFile: problemFile ?? this.problemFile,
        appointmentId: appointmentId ?? this.appointmentId,
        isOver: isOver ?? this.isOver,
        resultDesc: resultDesc ?? this.resultDesc,
        resultFile: resultFile ?? this.resultFile,
      );

  factory AppointInfo.fromJson(
          {required Map<String, dynamic> json, String? appointmentId}) =>
      json.isNotEmpty
          ? AppointInfo(
              date: DateTime.parse(json["date"]),
              doctorId: json["doctor_id"],
              isFree: json["isFree"],
              problemDesc: json["problem_desc"],
              time: json["time"],
              clientId: json["client_id"],
              problemFile: json["problem_file"],
              appointmentId: (json["appointment_id"] != null)
                  ? json["appointment_id"]
                  : appointmentId,
              isOver: json["is_overed"],
              resultDesc: json["result_desc"],
              resultFile: json["result_file"],
            )
          : AppointInfo(
              date: DateTime.now(),
              doctorId: "",
              isFree: true,
              problemDesc: "",
              time: "",
              clientId: "",
              problemFile: "",
              appointmentId: "",
              isOver: true,
              resultDesc: "",
              resultFile: "");

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "doctor_id": doctorId,
        "isFree": isFree,
        "problem_desc": problemDesc,
        "time": time,
        "client_id": clientId,
        "problem_file": problemFile,
        "is_overed": isOver,
        "result_desc": resultDesc,
        "result_file": resultFile,
      };
}
