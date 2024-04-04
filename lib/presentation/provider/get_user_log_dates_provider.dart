import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/summary/user_log_date_model.dart';
import 'package:nutriary_flutter/domain/usecases/get_user_log_dates_usecase.dart';

class GetUserlogDatesProvider extends ChangeNotifier {
  var _getUserLogDatesUseCase = GetUserLogDatesUseCase();

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  List<DateTime?> _userLogDates = [];
  List<DateTime?> get userLogDates => _userLogDates;


  DateTime _focusedDay = DateTime.now();

  DateTime get focusedDay => _focusedDay;

  List<DateTime> selectedDays = [];

  DateTime? randomSelectedDate;

  void setRandomSelectedDate(DateTime date) {
    randomSelectedDate = date;
    notifyListeners();
  }

  void setFocusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void addSelectedDay(DateTime day) {
    if (!selectedDays.contains(day)) {
      selectedDays.add(day);
      notifyListeners();
    }
  }


  Future<List<UserLogDate>> getUserLogDates(int userId) async {
    try {
      var result = await _getUserLogDatesUseCase.getUserLogDates(userId);
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchUserLogDates(int userId) async {
    try {
      var result = await _getUserLogDatesUseCase.getUserLogDates(userId);
      _userLogDates = result.map((logDate) => logDate.logDate).toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setUserLogDates(List<DateTime?> dates) {
    _userLogDates = dates;
    notifyListeners();
  }

  void clearUserLogDates() {
    _userLogDates = [];
    notifyListeners();
  }

  void clearSelectedDate() {
    _selectedDate = DateTime.now();
    notifyListeners();
  }

  void clearAll() {
    clearUserLogDates();
    clearSelectedDate();
  }

}