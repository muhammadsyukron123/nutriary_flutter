class DailyNutritionLog {
  DateTime logDate;
  double energyKcal;
  double proteinG;
  double fatG;
  double carbsG;
  double fiberG;
  double calciumMg;
  double feMg;
  double natriumMg;

  DailyNutritionLog({
    required this.logDate,
    required this.energyKcal,
    required this.proteinG,
    required this.fatG,
    required this.carbsG,
    required this.fiberG,
    required this.calciumMg,
    required this.feMg,
    required this.natriumMg,
  });

  factory DailyNutritionLog.fromJson(Map<String, dynamic> json) => DailyNutritionLog(
    logDate: DateTime.parse(json["log_date"]),
    energyKcal: json["energy_kcal"],
    proteinG: json["protein_g"]?.toDouble(),
    fatG: json["fat_g"]?.toDouble(),
    carbsG: json["carbs_g"]?.toDouble(),
    fiberG: json["fiber_g"]?.toDouble(),
    calciumMg: json["calcium_mg"]?.toDouble(),
    feMg: json["fe_mg"]?.toDouble(),
    natriumMg: json["natrium_mg"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "log_date": logDate.toIso8601String(),
    "energy_kcal": energyKcal,
    "protein_g": proteinG,
    "fat_g": fatG,
    "carbs_g": carbsG,
    "fiber_g": fiberG,
    "calcium_mg": calciumMg,
    "fe_mg": feMg,
    "natrium_mg": natriumMg,
  };
}
