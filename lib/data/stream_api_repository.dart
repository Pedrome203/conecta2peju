import 'package:conecta2peju/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

abstract class StreamApiRepository {
  Future<List<ChatUser>> getChatUsers(List<String> friends);
  Future<String> getToken(String userId);
  Future<bool> connectIfExist(String userId);
  Future<ChatUser> connectUser(ChatUser user, String token);
  Future<Channel> createGroupChat(
      String channelId, String name, List<String> members,
      {String image});
  Future<Channel> createSimpleChat(String firendId);
  Future<void> logout();
}
