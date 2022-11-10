import 'package:conecta2peju/domain/exceptions/auth_exception.dart';
import 'package:conecta2peju/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState { none, existingUser, newUser }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._loginUseCase) : super(SplashState.none);
  final LoginUseCase _loginUseCase;

  void init(String username) async {
    try {
      final result = await _loginUseCase.validateLogin(username);
      if (result) {
        emit(SplashState.existingUser);
      }
    } on AuthException catch (ex) {
      if (ex.error == AuthErrorCode.notAuth) {
        emit(SplashState.none);
      } else {
        emit(SplashState.existingUser);
      }
    }
  }
}
