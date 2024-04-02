import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/foodlog/add_consumption_log_model.dart';
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';
import 'package:nutriary_flutter/presentation/screens/add_food_log.dart';

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

//   curl -X 'POST' \
//   'https://app.actualsolusi.com/bsi/Nutriary/api/ConsumptionLog/InsertConsumptionLog' \
//   -H 'accept: */*' \
//   -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImpvaG5fZG9lMiIsIm5hbWVpZCI6IjEwIiwibmJmIjoxNzEyMDI5NzkxLCJleHAiOjE3MTQ2MjE3OTEsImlhdCI6MTcxMjAyOTc5MX0.uumQOG-20Kn2OAODY8f8Skz3SkSMZXS_yjdE2Z3i1nE' \
//   -H 'Content-Type: application/json' \
//   -d '{
//   "userId": 10,
//   "foodId": "FP011",
//   "quantity": 100,
//   "logDate": "2024-04-02"
// }'

  Future<AddConsumptionLog> addFoodLog(AddConsumptionLog addConsumptionLog) async{
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.post(
        Uri.parse(baseUrl + 'ConsumptionLog/InsertConsumptionLog'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': user.userId,
          'foodId': addConsumptionLog.foodId,
          'quantity': addConsumptionLog.quantity,
          'logDate': addConsumptionLog.logDate.toIso8601String(),
        }),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(response.statusCode);
        print(response.body);
        return AddConsumptionLog.fromJson(jsonData);
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Failed to add food log');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<void> deleteFoodLog(int logId) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.delete(
        Uri.parse(baseUrl + 'ConsumptionLog/DeleteConsumptionLog?LogId=$logId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Failed to delete food log');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<void> updateFoodLog(int logId, double quantity) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.put(
        Uri.parse(baseUrl + 'ConsumptionLog/UpdateConsumptionQuantity'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'logId': logId,
          'quantity': quantity,
        }),
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Failed to update food log');
      }
    } else {
      throw Exception('User not logged in');
    }
  }


}