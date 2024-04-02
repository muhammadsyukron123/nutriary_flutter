
import 'package:hive/hive.dart';
part 'food_name_hive_model.g.dart';

@HiveType(typeId: 2)
class FoodNameHiveModel{
 @HiveField(0)
  late final String? foodId;

 @HiveField(1)
  final String? foodName;

  FoodNameHiveModel({
    required this.foodId,
    required this.foodName,
  });

  // Add fromJson method
  factory FoodNameHiveModel.fromJson(Map<String, dynamic> json) {
    return FoodNameHiveModel(
      foodId: json['foodId'],
      foodName: json['foodName'],
    );
  }

 @override
 String toString() {
   return '$foodName : $foodId';
 }
}