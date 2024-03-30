import '../user/auth_model.dart';

class AuthResponse {
  final int statusCode;
  final List<AuthModel> authModelList;

  AuthResponse({
    required this.statusCode,
    required this.authModelList,
  });
}