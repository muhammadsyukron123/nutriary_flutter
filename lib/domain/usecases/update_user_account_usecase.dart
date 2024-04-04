import '../../data/model/user/update_user_account_model.dart';
import '../../data/repository/profile_repository.dart';

class UpdateUserAccountUseCase {
  var _profileRepository = ProfileRepository();

  Future<void> updateUserAccount(UpdateUser updateUser) async {
    try {
      await _profileRepository.updateUserAccountRepository(updateUser);
    } catch (e) {
      throw e;
    }
  }
}