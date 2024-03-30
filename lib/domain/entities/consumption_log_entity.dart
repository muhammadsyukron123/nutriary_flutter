class ConsumptionLogEntity{
  String foodId;
  int logId;
  int quantity;
  DateTime logDate;
  String foodName;
  int energyKal;
  double proteinG;
  double fatG;
  double carbsG;
  double fiberG;
  int calciumMg;
  double feMg;
  int natriumMg;

  ConsumptionLogEntity({
    required this.foodId,
    required this.logId,
    required this.quantity,
    required this.logDate,
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