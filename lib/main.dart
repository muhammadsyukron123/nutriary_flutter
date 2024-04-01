import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/datasource/local/summary_today_hive_datasource.dart';
import 'package:nutriary_flutter/presentation/provider/auth_provider.dart';
import 'package:nutriary_flutter/presentation/provider/food_nutrition_provider.dart';
import 'package:nutriary_flutter/presentation/provider/profile_provider.dart';
import 'package:nutriary_flutter/presentation/provider/summary_provider.dart';
import 'package:nutriary_flutter/presentation/provider/user_register_provider.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:nutriary_flutter/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/local/user_hive_datasource.dart';
import 'data/model/user/user.dart';
import 'domain/usecases/login_usecase.dart';

void main() async{
  UserHiveDataSource hiveDataSource = UserHiveDataSource();
  SummaryHiveDataSource summaryHiveDataSource = SummaryHiveDataSource();
  await hiveDataSource.init();
  await summaryHiveDataSource.init();

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
      ],
          child: GetMaterialApp(
          title: 'Nutriary',
          theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
          ),
        home: SplashScreen(),
      )
    );
  }
}
