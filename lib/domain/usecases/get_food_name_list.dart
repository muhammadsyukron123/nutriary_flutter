import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/model/foods/food_name_hive_model.dart';
import 'package:nutriary_flutter/data/model/nutrition/food_nutrition_info_model.dart';
import 'package:nutriary_flutter/data/repository/nutrition_repository.dart';

import '../entities/food_name_entity.dart';

class GetFoodNameList{
  var nutritionRepository = NutritionRepository();

  Future<void> execute() async {
    try {
      final List<FoodNutritionInfo> foodNameList = await nutritionRepository.getAllFoodNutrition();
      var box = Hive.box<FoodNameHiveModel>('foodNameBox');
      await box.clear();

      for (var foodNutritionInfo in foodNameList) {
        var foodNameHiveModel = FoodNameHiveModel(
          foodId: foodNutritionInfo.foodId,
          foodName: foodNutritionInfo.foodName,
        );

        await box.add(foodNameHiveModel);
      }
      print(box.length);
    } catch (e) {
      throw e;
    }
  }



}