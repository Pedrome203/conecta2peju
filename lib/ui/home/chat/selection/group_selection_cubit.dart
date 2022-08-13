import 'dart:io';

import 'package:conecta2peju/data/image_picker_repository.dart';
import 'package:conecta2peju/domain/usecases/create_group_usecase.dart';
import 'package:conecta2peju/ui/home/chat/selection/friend_selection_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionState {
  const GroupSelectionState(this.file, {this.channel});
  final File? file;
  final Channel? channel;
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(
    this.members,
    this._createGroupUseCase,
    this._imagePickerRepository,
  ) : super(const GroupSelectionState(null));

  final nameTextController = TextEditingController();
  final List<ChatUserState>? members;
  final CreateGroupUseCase _createGroupUseCase;
  final ImagePickerRepository _imagePickerRepository;

  void createGroup() async {
    final channel = await _createGroupUseCase.createGroup(CreateGroupInput(
        imageFile: state.file,
        members: members!.map((e) => e.chatUser!.id!).toList(),
        name: nameTextController.text));
    emit(GroupSelectionState(state.file, channel: channel));
  }

  void pickImage() async {
    final image = await _imagePickerRepository.pickImage();
    emit(GroupSelectionState(image));
  }
}
