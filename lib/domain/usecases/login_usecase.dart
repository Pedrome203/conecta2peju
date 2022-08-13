import 'package:conecta2peju/data/auth_repository.dart';
import 'package:conecta2peju/data/stream_api_repository.dart';
import 'package:conecta2peju/domain/exceptions/auth_exception.dart';

class LoginUseCase {
  LoginUseCase(this.authRepository, this.streamApiRepository);
  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  Future<bool> validateLogin() async {
    final user = await authRepository.getAuthUser();
    if (user != null) {
      final result = await streamApiRepository.connectIfExist(user.id!);
      if (result) {
        return true;
      } else {
        throw AuthException(AuthErrorCode.notChatUser);
      }
    } else {
      throw AuthException(AuthErrorCode.notAuth);
    }
  }
}
