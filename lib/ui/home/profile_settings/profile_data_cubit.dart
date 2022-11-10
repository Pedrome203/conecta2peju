import 'package:conecta2peju/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDataCubit extends Cubit<void> {
  ProfileDataCubit(this._logoutUseCase) : super(null);
  final LogoutUseCase _logoutUseCase;
  Future<void> logOut() async {
    print('HOLA');
    await _logoutUseCase.logout();
  }

  void test() {
    print('HOLA');
  }
}
