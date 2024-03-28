class FoodNutritionInfoEntity {
  String foodId;
  String foodName;
  int energyKal;
  double proteinG;
  double fatG;
  double carbsG;
  double fiberG;
  double calciumMg;
  double feMg;
  double natriumMg;

  FoodNutritionInfoEntity({
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
}