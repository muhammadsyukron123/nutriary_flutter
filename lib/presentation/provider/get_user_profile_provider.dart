import 'package:flutter/cupertino.dart';
import 'package:nutriary_flutter/data/model/user/user_with_profile_model.dart';

import '../../domain/usecases/get_user_profile_usecase.dart';

class GetUserProfileProvider extends ChangeNotifier {
  var _getUserProfileUseCase = GetUserProfileUseCase();

  UserWithProfile? _userWithProfile;
  UserWithProfile? get userWithProfile => _userWithProfile;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getUserProfile() async {
    try{
      _isLoading = true;
      _userWithProfile = await _getUserProfileUseCase.getUserWithProfileUseCase();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      notifyListeners();
      _userWithProfile = null;
      print(e);
    }

  }

  void refresh() {
    clear();
    _isLoading = true;
    getUserProfile();
    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _userWithProfile = null;
    notifyListeners();
  }
}