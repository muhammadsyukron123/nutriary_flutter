import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';

import '../../model/user/user.dart';

class ConsumptionLogRemoteDataSource{
  final String baseUrl =
      'https://app.actualsolusi.com/bsi/Nutriary/api/';

  // get food log by id
  Future<List<ConsumptionLog>> getFoodLogByID(int id, DateTime logDate) async {
    print('this is from foodlogremote ${logDate.day}');
    print('this is from foodlogremote ${logDate.month}');
    print('this is from foodlogremote ${logDate.year}');
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(
        Uri.parse(baseUrl +
            'ConsumptionLog/GetAllConsumptionLogsById?UserId=$id&LogDate=${logDate.month}%2F${logDate.day}%2F${logDate.year}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(response.statusCode);
        print(response.body);
        List<ConsumptionLog> consumptionLogList = [];
        for (var item in jsonData) {
          consumptionLogList.add(ConsumptionLog.fromJson(item));
          print(item);
        }

        return consumptionLogList;
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Failed to load food log');
      }
    } else {
      throw Exception('User not logged in');
    }
  }


}