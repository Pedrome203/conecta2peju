import 'package:conecta2peju/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDataCubit extends Cubit<void> {
  ProfileDataCubit(this._logoutUseCase) : super(null);
  final LogoutUseCase _logoutUseCase;
  void logOut() async {
    await _logoutUseCase.logout();
  }
}
