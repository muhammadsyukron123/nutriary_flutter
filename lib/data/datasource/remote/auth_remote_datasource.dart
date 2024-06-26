import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/datasource/remote/consumption_summary_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/user/auth_model.dart';

import '../../model/auth/auth_reponse_model.dart';
import '../../model/user/user.dart';
import '../local/user_hive_datasource.dart';


class AuthRemoteDataSource{
  UserHiveDataSource hiveDataSource = UserHiveDataSource();
  ConsumptionSummaryRemoteDataSource consumptionSummaryRemoteDataSource = ConsumptionSummaryRemoteDataSource();

  final String baseUrl = 'https://app.actualsolusi.com/bsi/Nutriary/api/';

  Future<AuthModel> login(String username, String password) async {
    var response = await http.post(Uri.parse(baseUrl + 'Users/Login'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({
          'username': username,
          'password': password
        })
    );

    print('this is from authremote ${response.statusCode}');
    print('this is from authremote ${response.body}');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      AuthModel authModel = AuthModel.fromJson(data);
      // Store the user login information in the Hive box
      final box = Hive.box<User>('userBox');
      User user = User(
        userId: authModel.userId,
        username: authModel.username,
        firstName: authModel.firstName,
        lastName: authModel.lastName,
        token: authModel.token,
      );
      await box.put('user', user);
      Get.snackbar('Welcome Back! 🙋‍♂️', 'Login successfull',backgroundColor: Colors.indigo, colorText: Colors.white);

      return authModel;
    }
    else if(response.statusCode == 401){
      throw Exception('Incorrect username or password');
    }

    else {
      throw Exception('Failed to login');
    }
  }
}