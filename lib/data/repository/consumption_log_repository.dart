

import 'package:nutriary_flutter/data/datasource/remote/consumption_log_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/foodlog/add_consumption_log_model.dart';
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';

class ConsumptionLogRepository {
  var _consumptionLogDataSource = ConsumptionLogRemoteDataSource();



  Future<List<ConsumptionLog>> getConsumptionLogsByID(int id, DateTime logDate) async {
    return _consumptionLogDataSource.getFoodLogByID(id, logDate);
  }

  Future<AddConsumptionLog> addConsumptionLog(AddConsumptionLog consumptionLog) async {
    return _consumptionLogDataSource.addFoodLog(consumptionLog);
  }

  Future<void> deleteConsumptionLog(int id) async {
    return _consumptionLogDataSource.deleteFoodLog(id);
  }

  Future<void> updateConsumptionLog(int logId, double quantity) async {
    return _consumptionLogDataSource.updateFoodLog(logId, quantity);
  }

  // Future<List<ConsumptionLog>> getConsumptionLogs() async {
  //   return _consumptionLogDataSource.();
  // }

  // Future<void> addConsumptionLog(ConsumptionLog consumptionLog) async {
  //   return _consumptionLogDataSource.addConsumptionLog(consumptionLog);
  // }
}
