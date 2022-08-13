import 'dart:io';

import 'package:conecta2peju/data/local/image_picker_impl.dart';
import 'package:conecta2peju/data/stream_api_repository.dart';
import 'package:conecta2peju/data/upload_storage_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateGroupInput {
  CreateGroupInput({this.imageFile, this.name, this.members});
  final File? imageFile;
  final String? name;
  final List<String>? members;
}

class CreateGroupUseCase {
  CreateGroupUseCase(this._streamApiRepository, this._uploadStorageRepository);

  final StreamApiRepository _streamApiRepository;
  final UploadStorageRepository _uploadStorageRepository;

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = Uuid().v4();
    final ImageResult = await _uploadStorageRepository.uploadPhoto(
        input.imageFile!, 'channels');
    final channel = await _streamApiRepository.createGroupChat(
        channelId, input.name!, input.members!,
        image: ImageResult);
    return channel;
  }
}
