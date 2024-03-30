import 'package:nutriary_flutter/data/model/auth/auth_reponse_model.dart';
import 'package:nutriary_flutter/data/model/user/auth_model.dart';

import '../datasource/remote/auth_remote_datasource.dart';

class AuthRepository{
  var authRemoteDataSource = AuthRemoteDataSource();

  Future<AuthModel> login(String email, String password) async {
    try {
      return authRemoteDataSource.login(email, password);
    } catch (e) {
      throw e;
    }
  }
}