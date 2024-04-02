import '../../data/model/summary/consumption_summary_model.dart';
import '../../data/repository/summary_repository.dart';

class CalorieSummaryUsecase{
  var _consumptionSummaryRepository = SummaryRepository();

  Future<CalorieSummary> getCalorieSummaryToday(int UserId) async{
    try {
      return _consumptionSummaryRepository.getCalorieSummaryToday(UserId);
    } catch (e) {
      throw e;
    }
  }

  Future<CalorieSummary> getCalorieSummaryByDate(int UserId, DateTime date) async{
    try {
      return _consumptionSummaryRepository.getCalorieSummaryByDate(UserId, date);
    } catch (e) {
      throw e;
    }
  }
}