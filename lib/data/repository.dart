import 'package:nutriary_flutter/data/datasource/remote_datasource.dart';

import 'model/food_nutrition_info_model.dart';

class Repository{

  var remoteDataSource = RemoteDataSource();

  Future<List<FoodNutritionInfo>> getAllFoodNutrition() async {
    try {
      final List<FoodNutritionInfo> foodNutritionList = await remoteDataSource.getAllFoodNutrition();
      return foodNutritionList;
    } catch (e) {
      throw e;
    }
  }
}