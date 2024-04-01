import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nutriary_flutter/data/model/summary/summary_today_hive_model.dart';

class SummaryHiveDataSource{
 Future<void> init() async {
   await Hive.initFlutter();
   Hive.registerAdapter(SummaryHiveModelAdapter());
   await Hive.openBox<SummaryHiveModel>('summaryBox');
 }
}