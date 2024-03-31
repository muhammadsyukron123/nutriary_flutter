import 'package:flutter/material.dart';
import 'package:nutriary_flutter/domain/usecases/user_register_usecase.dart';

import '../../data/model/user/user_register_response_model.dart';
import '../../domain/entities/user_register_entity.dart';

class UserRegisterProvider extends ChangeNotifier{
  final _userRegisterUsecase = UserRegisterUsecase();


  Future<UserRegisterReponse> register(UserRegisterEntity userRegisterEntity) async {
    try {
      var response = await _userRegisterUsecase.register(userRegisterEntity);
      notifyListeners();
      return response;
    } catch (e) {
      throw e;
    }
  }

}