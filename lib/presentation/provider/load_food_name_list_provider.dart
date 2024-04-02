import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/domain/usecases/get_food_name_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadFoodNameListProvider extends ChangeNotifier {
  var _getFoodNameListUseCase = GetFoodNameList();

  void loadFoodNameList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    await _getFoodNameListUseCase.execute();
    notifyListeners();
    // if (isFirstTime) {
    //   await _getFoodNameListUseCase.execute();
    //   await prefs.setBool('isFirstTime', false);
    //   notifyListeners();
    // }
  }
}