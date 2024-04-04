import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/user/user_with_profile_model.dart';

import '../../domain/usecases/get_user_profile_usecase.dart';

class GetUserProfileProvider extends ChangeNotifier {
  var _getUserProfileUseCase = GetUserProfileUseCase();

  UserWithProfile? _userWithProfile;
  UserWithProfile? get userWithProfile => _userWithProfile;

  Future<void> getUserProfile() async {
    try{
      _userWithProfile = await _getUserProfileUseCase.getUserWithProfileUseCase();
      notifyListeners();
    } catch (e) {
      notifyListeners();
      _userWithProfile = null;
      print(e);
    }

  }

  void refresh() {
    clear();
    getUserProfile();
    notifyListeners();
  }

  void clear() {
    _userWithProfile = null;
    notifyListeners();
  }
}