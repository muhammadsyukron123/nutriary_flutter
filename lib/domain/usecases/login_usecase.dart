import 'package:nutriary_flutter/data/model/auth/auth_reponse_model.dart';
import 'package:nutriary_flutter/data/model/user/auth_model.dart';

import '../../data/repository/auth_repository.dart';

class LoginUsecase{
  var authRepository = AuthRepository();

  Future<AuthModel> login(String email, String password) async {
    return authRepository.login(email, password);
  }
}