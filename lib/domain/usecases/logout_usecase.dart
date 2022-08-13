import 'package:conecta2peju/data/auth_repository.dart';
import 'package:conecta2peju/data/stream_api_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this.streamApiRepository, this.authRepository);
  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;

  Future<void> logout() async {
    await streamApiRepository.logout();
    await authRepository.logout();
  }
}
