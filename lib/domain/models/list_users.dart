import 'package:conecta2peju/domain/models/user.dart';

class ListUsers {
  final List<User>? cards;

  ListUsers({this.cards});

  factory ListUsers.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['friends'] as List;

    List<User> dataList = list.map((i) => User.fromJson(i)).toList();

    return ListUsers(cards: dataList);
  }
}
