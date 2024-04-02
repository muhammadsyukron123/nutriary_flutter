class FoodNutritionInfo {
  String foodId;
  String foodName;
  double energyKal;
  double proteinG;
  double fatG;
  double carbsG;
  double fiberG;
  double calciumMg;
  double feMg;
  double natriumMg;

  FoodNutritionInfo({
    required this.foodId,
    required this.foodName,
    required this.energyKal,
    required this.proteinG,
    required this.fatG,
    required this.carbsG,
    required this.fiberG,
    required this.calciumMg,
    required this.feMg,
    required this.natriumMg,
  });

  factory FoodNutritionInfo.fromJson(Map<String, dynamic> json) {
    return FoodNutritionInfo(
      foodId: json['foodId'],
      foodName: json['foodName'],
      energyKal: json['energyKal'],
      proteinG: json['proteinG'],
      fatG: json['fatG'],
      carbsG: json['carbsG'],
      fiberG: json['fiberG'],
      calciumMg: json['calciumMg'],
      feMg: json['feMg'],
      natriumMg: json['natriumMg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'foodName': foodName,
      'energyKal': energyKal,
      'proteinG': proteinG,
      'fatG': fatG,
      'carbsG': carbsG,
      'fiberG': fiberG,
      'calciumMg': calciumMg,
      'feMg': feMg,
      'natriumMg': natriumMg,
    };
  } 
}
