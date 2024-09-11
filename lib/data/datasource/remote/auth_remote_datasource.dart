import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:nutriary_flutter/data/datasource/remote/consumption_summary_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/user/auth_model.dart';

import '../../model/auth/auth_reponse_model.dart';
import '../../model/user/user.dart';
import '../local/user_hive_datasource.dart';

class AuthRemoteDataSource {
  UserHiveDataSource hiveDataSource = UserHiveDataSource();
  ConsumptionSummaryRemoteDataSource consumptionSummaryRemoteDataSource =
  ConsumptionSummaryRemoteDataSource();

  final String baseUrl = 'https://192.168.1.165:7158/api/';

  Future<AuthModel> login(String username, String password) async {
    final client = HttpClient();

    try {
      final request =
      await client.postUrl(Uri.parse(baseUrl + 'Users/Login'));

      // Add headers
      request.headers.set('accept', 'application/json');
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Access-Control-Allow-Origin', '*');

      // Add body
      request.add(utf8.encode(jsonEncode({
        'username': username,
        'password': password,
      })));

      final response = await request.close();

      if (response.statusCode == HttpStatus.movedTemporarily ||
          response.statusCode == HttpStatus.permanentRedirect) {
        // Handle redirect manually
        final location = response.headers.value(HttpHeaders.locationHeader);
        print('Redirecting to: $location');

        // Follow the redirect manually
        final newRequest = await client.postUrl(Uri.parse(location!));
        newRequest.headers.set('accept', 'application/json');
        newRequest.headers.set('Content-Type', 'application/json');
        newRequest.add(utf8.encode(jsonEncode({
          'username': username,
          'password': password,
        })));

        final newResponse = await newRequest.close();

        // Handle the new response
        if (newResponse.statusCode == HttpStatus.ok) {
          final data = await utf8.decodeStream(newResponse);
          AuthModel authModel = AuthModel.fromJson(json.decode(data));

          // Store the user login information in Hive
          final box = Hive.box<User>('userBox');
          User user = User(
            userId: authModel.userId,
            username: authModel.username,
            firstName: authModel.firstName,
            lastName: authModel.lastName,
            token: authModel.token,
          );
          await box.put('user', user);
          Get.snackbar('Welcome Back! 🙋‍♂️', 'Login successful',
              backgroundColor: Colors.indigo, colorText: Colors.white);

          return authModel;
        } else {
          throw Exception('Failed after redirect: ${newResponse.statusCode}');
        }
      } else if (response.statusCode == HttpStatus.ok) {
        final data = await utf8.decodeStream(response);
        AuthModel authModel = AuthModel.fromJson(json.decode(data));

        // Store the user login information in Hive
        final box = Hive.box<User>('userBox');
        User user = User(
          userId: authModel.userId,
          username: authModel.username,
          firstName: authModel.firstName,
          lastName: authModel.lastName,
          token: authModel.token,
        );
        await box.put('user', user);
        Get.snackbar('Welcome Back! 🙋‍♂️', 'Login successful',
            backgroundColor: Colors.indigo, colorText: Colors.white);

        return authModel;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        throw Exception('Incorrect username or password');
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Connection error: $e');
    } finally {
      client.close();
    }
  }
}