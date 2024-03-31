import 'package:nutriary_flutter/data/model/user/user_register_model.dart';
import 'package:nutriary_flutter/data/model/user/user_register_response_model.dart';
import 'package:nutriary_flutter/data/repository/register_repository.dart';
import 'package:nutriary_flutter/domain/entities/user_register_entity.dart';

class UserRegisterUsecase{
  var _userRegisterRepository = RegisterRepository();

  Future<UserRegisterReponse> register(UserRegisterEntity userRegisterEntity) async {
    try {
      var userRegisterModel = UserRegister(
        email: userRegisterEntity.email,
        username: userRegisterEntity.username,
        password: userRegisterEntity.password,
        confirmPassword: userRegisterEntity.confirmPassword,
        firstname: userRegisterEntity.firstname,
        lastname: userRegisterEntity.lastname
      );
      return _userRegisterRepository.register(userRegisterModel);
    } catch (e) {
      throw e;
    }
  }
}