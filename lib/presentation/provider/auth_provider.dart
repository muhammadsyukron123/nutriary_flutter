import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/repository/auth_repository.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';

import 'package:flutter/foundation.dart';
import 'package:nutriary_flutter/data/repository/auth_repository.dart';
import 'package:nutriary_flutter/data/model/user/user.dart';
import 'package:nutriary_flutter/presentation/screens/home_screen.dart';

import '../../data/model/auth/auth_reponse_model.dart';
import '../../data/model/user/auth_model.dart';

import 'package:flutter/material.dart';
import 'package:nutriary_flutter/data/model/user/auth_model.dart';
import 'package:nutriary_flutter/domain/usecases/login_usecase.dart';
import 'package:nutriary_flutter/presentation/screens/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:nutriary_flutter/data/model/user/auth_model.dart';
import 'package:nutriary_flutter/domain/usecases/login_usecase.dart';
import 'package:nutriary_flutter/presentation/screens/dashboard_screen.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase _loginUsecase;

  AuthProvider(this._loginUsecase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(BuildContext context, String email, String password) async {

    try {
      _isLoading = true;
      AuthModel authModel = await _loginUsecase.login(email, password);
      _isLoading = false;
      if (authModel.userId != null) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Get.offAll(() => HomeScreen());
          Get.snackbar('Welcome Back! 🙋‍♂️', 'Login successfull',backgroundColor: Colors.indigo, colorText: Colors.white);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect username or password')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Credentials')),
      );
    }
    notifyListeners();
  }
}