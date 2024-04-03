import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/foodlog/daily_nutrition_log_model.dart';
import 'package:nutriary_flutter/data/model/summary/user_log_date_model.dart';

import '../../model/summary/consumption_summary_model.dart';
import '../../model/user/user.dart';

class ConsumptionSummaryRemoteDataSource{
  var baseUrl = 'https://app.actualsolusi.com/bsi/Nutriary/api/';

  Future<CalorieSummary> getConsumptionSummaryToday(int userId) async{
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'NutritionReport/GetTodayCalorieSummary?UserId=$userId'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        CalorieSummary consumptionSummary = CalorieSummary.fromJson(jsonData);
        return consumptionSummary;
      } else {
        throw Exception('Failed to load consumption summary');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<CalorieSummary> getCalorieSummaryByDate(int userId, DateTime date) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'NutritionReport/GetCalorieSummaryByDate?UserId=$userId&LogDate=${date.month}%2F${date.day}%2F${date.year}'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        CalorieSummary consumptionSummary = CalorieSummary.fromJson(jsonData);
        return consumptionSummary;
      } else {
        throw Exception('Failed to load consumption summary');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  // curl -X 'GET' \
  // 'https://app.actualsolusi.com/bsi/Nutriary/api/NutritionReport/GetUserLogDates?UserId=10' \
  // -H 'accept: */*' \
  // -H 'Authorization: Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
  Future<List<UserLogDate>> getUserLogDates(int userId) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'NutritionReport/GetUserLogDates?UserId=$userId'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<UserLogDate> userLogDates = [];
        for (var item in jsonData) {
          userLogDates.add(UserLogDate.fromJson(item));
        }
        print(response.body);
        return userLogDates;
      } else {
        throw Exception('Failed to load user log dates');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  // curl -X 'GET' \
  // 'https://app.actualsolusi.com/bsi/Nutriary/api/NutritionReport/GetDailyReports?UserId=10' \
  // -H 'accept: */*' \
  // -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6'

  Future<List<DailyNutritionLog>> getDailyReports(int userId) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'NutritionReport/GetDailyReports?UserId=$userId'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<DailyNutritionLog> dailyReports = [];
        for (var item in jsonData) {
          dailyReports.add(DailyNutritionLog.fromJson(item));
        }
        return dailyReports;
      } else {
        throw Exception('Failed to load daily reports');
      }
    } else {
      throw Exception('User not logged in');
    }
  }
}