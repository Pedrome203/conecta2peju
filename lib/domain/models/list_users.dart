import 'package:conecta2peju/domain/models/user.dart';

class ListUsers {
  final List<User>? users;

  ListUsers({this.users});

  factory ListUsers.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['friends'] as List;

    List<User> dataList = list.map((i) => User.fromJson(i)).toList();

    return ListUsers(users: dataList);
  }
}
