class NutritionReport {
  int userId;
  DateTime logDate;
  double totalEnergyKal;
  double totalProteinG;
  double totalFatG;
  double totalCarbsG;
  double totalFiberG;
  double totalCalciumMg;
  double totalFeMg;
  double totalNatriumMg;
  double totalBmr;
  double remainingBmr;

  NutritionReport({
    required this.userId,
    required this.logDate,
    required this.totalEnergyKal,
    required this.totalProteinG,
    required this.totalFatG,
    required this.totalCarbsG,
    required this.totalFiberG,
    required this.totalCalciumMg,
    required this.totalFeMg,
    required this.totalNatriumMg,
    required this.totalBmr,
    required this.remainingBmr,
  });

  factory NutritionReport.fromJson(Map<String, dynamic> json) => NutritionReport(
    userId: json["userId"],
    logDate: DateTime.parse(json["logDate"]),
    totalEnergyKal: json["totalEnergyKal"],
    totalProteinG: json["totalProteinG"]?.toDouble(),
    totalFatG: json["totalFatG"]?.toDouble(),
    totalCarbsG: json["totalCarbsG"]?.toDouble(),
    totalFiberG: json["totalFiberG"]?.toDouble(),
    totalCalciumMg: json["totalCalciumMg"]?.toDouble(),
    totalFeMg: json["totalFeMg"]?.toDouble(),
    totalNatriumMg: json["totalNatriumMg"]?.toDouble(),
    totalBmr: json["totalBmr"]?.toDouble(),
    remainingBmr: json["remainingBmr"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "logDate": logDate.toIso8601String(),
    "totalEnergyKal": totalEnergyKal,
    "totalProteinG": totalProteinG,
    "totalFatG": totalFatG,
    "totalCarbsG": totalCarbsG,
    "totalFiberG": totalFiberG,
    "totalCalciumMg": totalCalciumMg,
    "totalFeMg": totalFeMg,
    "totalNatriumMg": totalNatriumMg,
    "totalBmr": totalBmr,
    "remainingBmr": remainingBmr,
  };
}