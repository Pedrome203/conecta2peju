import 'package:flutter_bloc/flutter_bloc.dart';

enum LogInState {
  none,
  existingUser,
}

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInState.none);

  void signIn() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(LogInState.none);
  }
}
