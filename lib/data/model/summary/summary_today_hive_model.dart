

import 'package:hive/hive.dart';
part 'summary_today_hive_model.g.dart';

@HiveType(typeId: 1)
class SummaryHiveModel{
  @HiveField(0)
  final int? userId;

  @HiveField(1)
  final DateTime logDate;

  @HiveField(2)
  final double bmr;

  @HiveField(3)
  final double consumedCalories;

  @HiveField(4)
  final double remainingCalories;

  SummaryHiveModel({
    required this.userId,
    required this.logDate,
    required this.bmr,
    required this.consumedCalories,
    required this.remainingCalories,
  });

  // Add fromJson method
  factory SummaryHiveModel.fromJson(Map<String, dynamic> json) {
    return SummaryHiveModel(
      userId: json['userId'],
      logDate: DateTime.parse(json['logDate']),
      bmr: json['bmr'],
      consumedCalories: json['consumedCalories'],
      remainingCalories: json['remainingCalories'],
    );
  }
}