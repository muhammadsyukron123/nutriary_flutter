import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';

class FoodLogRemoteDataSource{
  final String baseUrl =
      'https://app.actualsolusi.com/bsi/Nutriary/api/';

  // get food log by id
  Future<List<ConsumptionLog>> getFoodLogByID(Int id, DateTime logDate) async {
    var response = await http.get(Uri.parse(baseUrl + 'ConsumptionLog/GetAllConsumptionLogsById?UserId=$id&LogDate=${logDate.toString()}'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<ConsumptionLog> consumptionLogList = [];
      for (var item in jsonData) {
        consumptionLogList.add(ConsumptionLog.fromJson(item));
      }
      return consumptionLogList;
    } else {
        throw Exception('Failed to load food log');
    }
  }


}