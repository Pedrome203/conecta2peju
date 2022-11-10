import 'package:conecta2peju/data/stream_api_repository.dart';
import 'package:conecta2peju/domain/models/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState {
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser? chatUser;
  final bool? selected;
}

class FriendSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendSelectionCubit(this._streamApiRepository) : super([]);
  final StreamApiRepository _streamApiRepository;

  List<ChatUserState> get selectedUsers =>
      state.where((element) => element.selected!).toList();

  Future<void> init(List<String> friends) async {
    final chatUsers = (await _streamApiRepository.getChatUsers(friends))
        .map((e) => ChatUserState(e));
    emit(chatUsers.toList());
  }

  void selectUser(ChatUserState chatUser) {
    final index = state
        .indexWhere((element) => element.chatUser!.id == chatUser.chatUser!.id);
    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUser.selected!);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async {
    final channel = await _streamApiRepository
        .createSimpleChat(chatUserState.chatUser!.id!);
    return channel;
  }
}

class FriendsGroupCubit extends Cubit<bool> {
  FriendsGroupCubit() : super(false);
  void changeToGroup() => emit(!state);
}
