import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/profile/create_user_profile_model.dart';
import 'package:nutriary_flutter/data/model/user/update_user_account_model.dart';

import '../../model/user/user.dart';
import '../../model/user/user_with_profile_model.dart';

class ProfileRemoteDataSource{
  var baseUrl = 'https://app.actualsolusi.com/bsi/Nutriary/api/';

  Future<void> insertUserProfile(CreateUserProfile createUserProfile) async {
    print('this is from insertprofile $createUserProfile');
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      print('this is from insertprofile $token');
      var response = await http.post(Uri.parse(baseUrl + 'UserProfile/InsertUserProfile'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            'userId' : user.userId,
            'gender' : createUserProfile.gender,
            'age' : createUserProfile.age,
            'height' : createUserProfile.height,
            'weight' : createUserProfile.weight,
            'activityLevelId' : createUserProfile.activityLevelId,
            'targetGoalId' : createUserProfile.targetGoalId,

          })
      );
      if (response.statusCode == 200) {
        print('this is from updateprofile ${response.statusCode}');
        print('this is from updateprofile ${response.body}');
      } else {
        print('this is from updateprofile ${response.statusCode}');
        print('this is from updateprofile ${response.body}');
        throw Exception('Failed to update profile');
      }
    }
    else {
      throw Exception('User not logged in');
    }
  }

  Future<UserWithProfile> getUserWithProfile() async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.get(Uri.parse(baseUrl + 'Users/GetWithProfile?UserId=${user?.userId}'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
        );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('this is from getuserprofile ${response.statusCode}');
        print('this is from getuserprofile ${response.body}');
        UserWithProfile userWithProfile = UserWithProfile.fromJson(data);
        return userWithProfile;
      } else {
        throw Exception('Failed to get user profile');
      }
    }
    else {
      throw Exception('User not logged in');
    }
  }
  
  Future<void> updateUserAccount(UpdateUser updateUser) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    if (user != null) {
      var token = user.token;
      var response = await http.put(Uri.parse(baseUrl + 'Users/UpdateUser'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            'userId' : user.userId,
            'username' : updateUser.username,
            'email' : updateUser.email,
            'firstname' : updateUser.firstname,
            'lastname' : updateUser.lastname,
          })
      );
      if (response.statusCode == 200) {
        print('this is from updateprofile ${response.statusCode}');
        print('this is from updateprofile ${response.body}');
      } else {
        print('this is from updateprofile ${response.statusCode}');
        print('this is from updateprofile ${response.body}');
        throw Exception('Failed to update profile');
      }
    }
    else {
      throw Exception('User not logged in');
    }
  }







}