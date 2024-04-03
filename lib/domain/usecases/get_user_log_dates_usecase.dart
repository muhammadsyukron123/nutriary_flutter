import 'package:nutriary_flutter/data/model/summary/user_log_date_model.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';
import 'package:nutriary_flutter/data/repository/summary_repository.dart';

class GetUserLogDatesUseCase {
  var _summaryRepository = SummaryRepository();

  Future<List<UserLogDate>> getUserLogDates(int userId) async {
    try {
      var result = await _summaryRepository.getUserLogDates(userId);
      return result;
    } catch (e) {
      throw e;
    }
  }
}