import 'package:flutter/material.dart';
import 'package:nutriary_flutter/data/model/user/user_with_profile_model.dart';
import 'package:nutriary_flutter/domain/usecases/profile_usecase.dart';

import '../../data/model/profile/create_user_profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  var _profileUsecase = ProfileUseCase();

  Future<void> insertUserProfile(CreateUserProfile createUserProfile) async {
    try {
      await _profileUsecase.insertUserProfile(createUserProfile);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<UserWithProfile> getUserWithProfile() async {
    try {
      var result = await _profileUsecase.getUserWithProfile();
      notifyListeners();
      return result;
    } catch (e) {
      throw e;
    }
  }
}