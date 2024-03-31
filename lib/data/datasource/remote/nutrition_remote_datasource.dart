import 'dart:convert';

import 'package:nutriary_flutter/data/model/nutrition/food_nutrition_info_model.dart';
import 'package:http/http.dart' as http;

class NutritionRemoteDataSource {
  final String baseUrl =
      'https://app.actualsolusi.com/bsi/Nutriary/api/';

  Future<List<FoodNutritionInfo>> getAllFoodNutrition() async {
    var response = await http.get(Uri.parse(baseUrl + 'FoodNutrition/GetAllFoodNutritionInfo/'));
    //print response.statusCode in console
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<FoodNutritionInfo> foodNutritionList = [];
      for (var item in jsonData) {
        foodNutritionList.add(FoodNutritionInfo.fromJson(item));
      }
      return foodNutritionList;
    } else {
      throw Exception('Failed to load food nutrition');
    }
  }
}