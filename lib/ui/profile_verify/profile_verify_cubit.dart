/*import 'dart:io';

import 'package:conecta2peju/data/image_picker_repository.dart';
import 'package:conecta2peju/data/stream_api_repository.dart';
import 'package:conecta2peju/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ProfileState {
  // Positional optional parameters
  ProfileState(this.file, {this.success = false});
  final File? file;
  final bool? success;
}

class ProfileVerifyCubit extends Cubit<ProfileState> {
  ProfileVerifyCubit(this._imagePickerRepository, this._profileSignInUseCase)
      : super(ProfileState(null));
  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting(String username) async {
    final file = state.file;
    final name = nameController.text;
    await _profileSignInUseCase.verify(
        ProfileInput(imageFile: file, name: name), username);
    emit(ProfileState(file, success: true));
  }

  void pickImage() async {
    //TODO: call services
    final file = await _imagePickerRepository.pickImage();
    emit(ProfileState(file));
  }
}*/
