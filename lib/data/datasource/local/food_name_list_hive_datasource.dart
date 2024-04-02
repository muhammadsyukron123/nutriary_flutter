import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nutriary_flutter/data/model/foods/food_name_hive_model.dart';

class FoodNameListHiveDatasource {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FoodNameHiveModelAdapter());
    await Hive.openBox<FoodNameHiveModel>('foodNameBox');
  }
}
