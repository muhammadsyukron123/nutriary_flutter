class ConsumptionSummary {
  int userId;
  DateTime logDate;
  double bmr;
  double consumedCalories;
  double remainingCalories;

  ConsumptionSummary({
    required this.userId,
    required this.logDate,
    required this.bmr,
    required this.consumedCalories,
    required this.remainingCalories,
  });

  factory ConsumptionSummary.fromJson(Map<String, dynamic> json) => ConsumptionSummary(
    userId: json["user_id"],
    logDate: DateTime.parse(json["log_date"]),
    bmr: json["bmr"]?.toDouble(),
    consumedCalories: json["consumed_calories"],
    remainingCalories: json["remaining_calories"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "log_date": logDate.toIso8601String(),
    "bmr": bmr,
    "consumed_calories": consumedCalories,
    "remaining_calories": remainingCalories,
  };
}
