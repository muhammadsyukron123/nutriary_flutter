import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/datasource/local/food_name_list_hive_datasource.dart';
import 'package:nutriary_flutter/data/datasource/local/summary_today_hive_datasource.dart';
import 'package:nutriary_flutter/presentation/provider/add_food_log_provider.dart';
import 'package:nutriary_flutter/presentation/provider/auth_provider.dart';
import 'package:nutriary_flutter/presentation/provider/bottom_navbar_provider.dart';
import 'package:nutriary_flutter/presentation/provider/consumption_log_provider.dart';
import 'package:nutriary_flutter/presentation/provider/delete_food_log_provider.dart';
import 'package:nutriary_flutter/presentation/provider/food_nutrition_by_date_provider.dart';
import 'package:nutriary_flutter/presentation/provider/food_nutrition_provider.dart';
import 'package:nutriary_flutter/presentation/provider/load_food_name_list_provider.dart';
import 'package:nutriary_flutter/presentation/provider/profile_provider.dart';
import 'package:nutriary_flutter/presentation/provider/summary_provider.dart';
import 'package:nutriary_flutter/presentation/provider/update_food_log_provider.dart';
import 'package:nutriary_flutter/presentation/provider/user_register_provider.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:nutriary_flutter/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/local/user_hive_datasource.dart';
import 'data/model/user/user.dart';
import 'domain/usecases/login_usecase.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthProvider>(AuthProvider(LoginUsecase()));
}

void main() async{
  setup();
  UserHiveDataSource hiveDataSource = UserHiveDataSource();
  SummaryHiveDataSource summaryHiveDataSource = SummaryHiveDataSource();
  FoodNameListHiveDatasource foodNameListHiveDatasource = FoodNameListHiveDatasource();
  await hiveDataSource.init();
  await summaryHiveDataSource.init();
  await foodNameListHiveDatasource.init();

  LoadFoodNameListProvider loadFoodNameListProvider = LoadFoodNameListProvider();
  loadFoodNameListProvider.loadFoodNameList();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetAllFoodNutritionProvider()),
        ChangeNotifierProvider(create: (_) => UserRegisterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider(LoginUsecase())),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SummaryProvider()),
        ChangeNotifierProvider(create: (_) => ConsumptionLogProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => LoadFoodNameListProvider()),
        ChangeNotifierProvider(create: (_) => AddFoodLogProvider()),
        ChangeNotifierProvider(create: (_) => DeleteFoodLogProvider()),
        ChangeNotifierProvider(create: (_) => UpdateFoodLogProvider()),
        ChangeNotifierProvider(create: (_) => FoodNutritionReportByDateProvider()),
      ],
          child: GetMaterialApp(
          title: 'Nutriary',
          theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, secondary: Colors.indigoAccent, primary: Colors.indigo),
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
          ),
        home: SplashScreen(),
      )
    );
  }
}
