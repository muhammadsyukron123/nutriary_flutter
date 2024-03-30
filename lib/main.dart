import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/presentation/provider/auth_provider.dart';
import 'package:nutriary_flutter/presentation/provider/food_nutrition_provider.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';
import 'package:nutriary_flutter/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/local/hive_datasource.dart';
import 'data/model/user/user.dart';
import 'domain/usecases/login_usecase.dart';

void main() async{
  HiveDataSource hiveDataSource = HiveDataSource();
  await hiveDataSource.init();

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
        ChangeNotifierProvider(create: (_) => AuthProvider(LoginUsecase())),
      ],
          child: MaterialApp(
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
