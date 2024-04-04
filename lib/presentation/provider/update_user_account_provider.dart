import 'package:flutter/material.dart';
import 'package:nutriary_flutter/data/model/user/update_user_account_model.dart';

import '../../domain/usecases/update_user_account_usecase.dart';

class UpdateUserAccountProvider extends ChangeNotifier {
  var _updateUserAccountUseCase = UpdateUserAccountUseCase();

  Future<void> updateUserAccount(UpdateUser updateUser) async {
    try {
      await _updateUserAccountUseCase.updateUserAccount(updateUser);
      notifyListeners();
    } catch (e) {
      notifyListeners();
      print(e);
    }
  }

  void refresh() {
    notifyListeners();
  }
}