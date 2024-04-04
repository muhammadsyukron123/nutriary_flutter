import '../../data/model/user/user_with_profile_model.dart';
import '../../data/repository/profile_repository.dart';

class GetUserProfileUseCase{
  var _profileRepository = ProfileRepository();

  Future<UserWithProfile> getUserWithProfileUseCase() async {
    try {
      final UserWithProfile userWithProfile = await _profileRepository.getUserWithProfile();
      return userWithProfile;
    } catch (e) {
      throw e;
    }
  }
}