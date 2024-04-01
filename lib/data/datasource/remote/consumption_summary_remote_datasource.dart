import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../model/summary/consumption_summary_model.dart';
import '../../model/user/user.dart';

class ConsumptionSummaryRemoteDataSource{
  var baseUrl = 'https://app.actualsolusi.com/bsi/Nutriary/api/';

  Future<ConsumptionSummary> getConsumptionSummaryToday(int userId) async{
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
        ConsumptionSummary consumptionSummary = ConsumptionSummary.fromJson(jsonData);
        return consumptionSummary;
      } else {
        throw Exception('Failed to load consumption summary');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<ConsumptionSummary> getConsumptionSummaryByDate(int userId, DateTime date) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'NutritionReport/GetCalorieSummaryByDate?UserId=$userId&LogDate=${date.toString()}'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ConsumptionSummary consumptionSummary = ConsumptionSummary.fromJson(jsonData);
        return consumptionSummary;
      } else {
        throw Exception('Failed to load consumption summary');
      }
    } else {
      throw Exception('User not logged in');
    }
  }
}