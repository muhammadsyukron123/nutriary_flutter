import '../datasource/remote/profile_remote_datasource.dart';
import '../model/profile/create_user_profile_model.dart';
import '../model/user/user_with_profile_model.dart';

class ProfileRepository {
  var _profileRemoteDataSource = ProfileRemoteDataSource();

  Future<void> insertUserProfile(CreateUserProfile createUserProfile) async {
    try {
      await _profileRemoteDataSource.insertUserProfile(createUserProfile);
    } catch (e) {
      throw e;
    }
  }

  Future<UserWithProfile> getUserWithProfile() async {
    try {
      final UserWithProfile userWithProfile = await _profileRemoteDataSource.getUserWithProfile();
      return userWithProfile;
    } catch (e) {
      throw e;
    }
  }
}