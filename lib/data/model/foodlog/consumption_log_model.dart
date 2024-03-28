class ConsumptionLog {
  int userId;
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

  ConsumptionLog({
    required this.userId,
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

  factory ConsumptionLog.fromJson(Map<String, dynamic> json)  {
    return ConsumptionLog(
        userId: json['userId'],
        foodId: json['foodId'],
        logId: json['logId'],
        quantity: json['quantity'],
        logDate: json['logDate'],
        foodName: json['foodName'],
        energyKal: json['energyKal'],
        proteinG: json['proteinG'],
        fatG: json['fatG'],
        carbsG: json['carbsG'],
        fiberG: json['fiberG'],
        calciumMg: json['calciumMg'],
        feMg: json['feMg'],
        natriumMg: json['natriumMg']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'userId': userId,
      'foodId': foodId,
      'logId': logId,
      'quantity': quantity,
      'logDate': logDate,
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
