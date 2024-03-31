class AddConsumptionLog {
  int userId;
  String foodId;
  int quantity;
  DateTime logDate;

  AddConsumptionLog({
    required this.userId,
    required this.foodId,
    required this.quantity,
    required this.logDate,
  });

  factory AddConsumptionLog.fromJson(Map<String, dynamic> json) => AddConsumptionLog(
    userId: json["userId"],
    foodId: json["foodId"],
    quantity: json["quantity"],
    logDate: DateTime.parse(json["logDate"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "foodId": foodId,
    "quantity": quantity,
    "logDate": logDate.toIso8601String(),
  };
}
