import 'package:nutriary_flutter/data/datasource/remote/nutrition_remote_datasource.dart';

import '../model/nutrition/food_nutrition_info_model.dart';

class NutritionRepository {
  var remoteDataSource = NutritionRemoteDataSource();

  Future<List<FoodNutritionInfo>> getAllFoodNutrition() async {
    try {
      final List<FoodNutritionInfo> foodNutritionList =
          await remoteDataSource.getAllFoodNutrition();
      return foodNutritionList;
    } catch (e) {
      throw e;
    }
  }
}
