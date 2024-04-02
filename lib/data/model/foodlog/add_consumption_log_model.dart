class AddConsumptionLog {
  String foodId;
  double quantity;
  DateTime logDate;

  AddConsumptionLog({
    required this.foodId,
    required this.quantity,
    required this.logDate,
  });

  factory AddConsumptionLog.fromJson(Map<String, dynamic> json) => AddConsumptionLog(
    foodId: json["foodId"],
    quantity: json["quantity"],
    logDate: DateTime.parse(json["logDate"]),
  );

  Map<String, dynamic> toJson() => {
    "foodId": foodId,
    "quantity": quantity,
    "logDate": logDate.toIso8601String(),
  };
}
