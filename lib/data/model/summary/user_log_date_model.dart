class UserLogDate {
  DateTime logDate;

  UserLogDate({
    required this.logDate,
  });

  factory UserLogDate.fromJson(Map<String, dynamic> json) => UserLogDate(
    logDate: DateTime.parse(json["log_date"]),
  );

  Map<String, dynamic> toJson() => {
    "log_date": logDate.toIso8601String(),
  };
}