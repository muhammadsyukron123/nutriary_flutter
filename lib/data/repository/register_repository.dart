import 'package:nutriary_flutter/data/model/user/user_register_model.dart';
import 'package:nutriary_flutter/data/model/user/user_register_response_model.dart';

import '../datasource/remote/register_remote_datasource.dart';

class RegisterRepository{
  var _registerRemoteDataSource = RegisterRemoteDataSource();

  Future<UserRegisterReponse> register(UserRegister userRegister) async {
    try {
      return _registerRemoteDataSource.register(userRegister);
    } catch (e) {
      throw e;
    }
  }
}