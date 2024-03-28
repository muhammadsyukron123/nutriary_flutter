import 'package:nutriary_flutter/domain/entities/food_nutrition_info_entity.dart';

import '../../data/Repository.dart';
import '../../data/datasource/remote_datasource.dart';
import '../../data/model/food_nutrition_info_model.dart';

class GetAllFoodNutritionInfo{
  var repository = Repository();

  Future<List<FoodNutritionInfo>> execute({required lastItem}) async {
    try {
      final List<FoodNutritionInfo> foodNutritionList = await repository.getAllFoodNutrition();
      return foodNutritionList;
    } catch (e) {
      throw e;
    }
  }

  FoodNutritionInfoEntity mapToEntity(FoodNutritionInfo foodNutritionInfo) {
    return FoodNutritionInfoEntity(
      foodId: foodNutritionInfo.foodId,
      foodName: foodNutritionInfo.foodName,
      energyKal: foodNutritionInfo.energyKal,
      proteinG: foodNutritionInfo.proteinG,
      fatG: foodNutritionInfo.fatG,
      carbsG: foodNutritionInfo.carbsG,
      fiberG: foodNutritionInfo.fiberG,
      calciumMg: foodNutritionInfo.calciumMg,
      feMg: foodNutritionInfo.feMg,
      natriumMg: foodNutritionInfo.natriumMg
    );
  }
}