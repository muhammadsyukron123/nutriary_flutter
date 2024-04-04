import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/model/profile/create_user_profile_model.dart';

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

  /**
   * curl -X 'GET' \
      'https://app.actualsolusi.com/bsi/Nutriary/api/Users/GetWithProfile?UserId=10' \
      -H 'accept: application/json'
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImpvaG5fZG9lMiIsIm5hbWVpZCI6IjEwIiwibmJmIjoxNzEyMTk4MDc2LCJleHAiOjE3MTQ3OTAwNzYsImlhdCI6MTcxMjE5ODA3Nn0.G5FCc-girKyv1PN74VA15stC7wH_Ll7jKIZKMNVMrKU'
   * This method is used to get user profile by userid that stored in hive userBox
   */







}