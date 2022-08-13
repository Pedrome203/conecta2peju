import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState {
  none,
  existingUser,
}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.none);

  void signIn() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(SignInState.none);
  }
}
