import 'dart:io';

import 'package:conecta2peju/data/auth_repository.dart';
import 'package:conecta2peju/data/stream_api_repository.dart';
import 'package:conecta2peju/data/upload_storage_repository.dart';
import 'package:conecta2peju/domain/models/chat_user.dart';

class ProfileInput {
  ProfileInput({this.imageFile, this.name});
  final File? imageFile;
  final String? name;
}

class ProfileSignInUseCase {
  ProfileSignInUseCase(this._authRepository, this._uploadStorageRepository,
      this._streamApiRepository);
  final AuthRepository _authRepository;
  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  Future<void> verify(ProfileInput input, String username) async {
    final auth = await _authRepository.getAuthUser(username);
    final token = await _streamApiRepository.getToken(auth.id!);
    final image = await _uploadStorageRepository.uploadPhoto(
        input.imageFile!, 'users/${auth.id}');

    await _streamApiRepository.connectUser(
        ChatUser(name: input.name, id: auth.id, image: image), token);
  }
}
