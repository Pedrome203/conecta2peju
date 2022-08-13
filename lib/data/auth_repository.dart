import 'package:conecta2peju/domain/models/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> getAuthUser();
  Future<AuthUser> signIn();
  Future<void> logout();
}
