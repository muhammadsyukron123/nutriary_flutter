import 'dart:ffi';

import 'package:nutriary_flutter/data/datasource/remote/consumption_log_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/foodlog/consumption_log_model.dart';

class ConsumptionLogRepository {
  var _consumptionLogDataSource = ConsumptionLogRemoteDataSource();



  Future<List<ConsumptionLog>> getConsumptionLogsByID(Int id, DateTime logDate) async {
    return _consumptionLogDataSource.getFoodLogByID(id, logDate);
  }

  // Future<List<ConsumptionLog>> getConsumptionLogs() async {
  //   return _consumptionLogDataSource.();
  // }

  // Future<void> addConsumptionLog(ConsumptionLog consumptionLog) async {
  //   return _consumptionLogDataSource.addConsumptionLog(consumptionLog);
  // }
}
