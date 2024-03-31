import '../../data/model/profile/create_user_profile_model.dart';
import '../../data/model/user/user_with_profile_model.dart';
import '../../data/repository/profile_repository.dart';

class ProfileUseCase {
  var _profileRepository = ProfileRepository();

  Future<void> insertUserProfile(CreateUserProfile createUserProfile) async {
    try {
      await _profileRepository.insertUserProfile(createUserProfile);
    } catch (e) {
      throw e;
    }
  }

  Future<UserWithProfile> getUserWithProfile() async {
    try {
      final UserWithProfile userWithProfile = await _profileRepository.getUserWithProfile();
      return userWithProfile;
    } catch (e) {
      throw e;
    }
  }
}