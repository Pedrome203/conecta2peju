import 'package:conecta2peju/data/auth_repository.dart';
import 'package:conecta2peju/domain/models/auth_user.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<AuthUser> getAuthUser(String username) async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser(username);
  }

  @override
  Future<AuthUser> signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('pedrome203');
  }

  @override
  Future<void> logout() async {
    return;
  }
}
