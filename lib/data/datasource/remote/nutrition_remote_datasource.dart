import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/model/nutrition/food_nutrition_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/nutrition/nutrition_report_model.dart';

import '../../model/user/user.dart';

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

  // curl -X 'GET' \
  // 'https://app.actualsolusi.com/bsi/Nutriary/api/NutritionReport/GetConsumptionReportByDate?UserId=10&LogDate=4%2F3%2F2024' \
  // -H 'accept: */*' \
  // -H 'Authorization: Bearer $token

  Future<NutritionReport> getFoodNutritionReportByDate(int userId, DateTime date) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'NutritionReport/GetConsumptionReportByDate?UserId=$userId&LogDate=${date.month}%2F${date.day}%2F${date.year}'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        NutritionReport nutritionReport = NutritionReport.fromJson(jsonData);
        return nutritionReport;
      } else {
        throw Exception('Failed to load food nutrition report');
      }
    } else {
      throw Exception('User not logged in');
    }
  }
}
