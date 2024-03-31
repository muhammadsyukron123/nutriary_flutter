import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutriary_flutter/data/datasource/remote/auth_remote_datasource.dart';
import 'package:nutriary_flutter/data/model/user/user_register_model.dart';
import 'package:nutriary_flutter/data/model/user/user_register_response_model.dart';

class RegisterRemoteDataSource {
  var _authRemoteDataSource = AuthRemoteDataSource();
  var baseUrl = 'https://app.actualsolusi.com/bsi/Nutriary/api/';

  Future<UserRegisterReponse> register(UserRegister userRegister) async {
    var response = await http.post(Uri.parse(baseUrl + 'Users/Register'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'username': userRegister.username,
          'email' : userRegister.email,
          'password': userRegister.password,
          'confirmPassword': userRegister.confirmPassword,
          'firstName': userRegister.firstname,
          'lastName': userRegister.lastname
        })
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('this is from registerremote ${response.statusCode}');
      print('this is from registerremote ${response.body}');
      UserRegisterReponse userRegisterReponse = UserRegisterReponse.fromJson(data);
      await _authRemoteDataSource.login(userRegister.username, userRegister.password);
      return userRegisterReponse;
    } else {
      throw Exception('Failed to register');
    }
  }
}