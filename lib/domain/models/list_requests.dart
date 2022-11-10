import 'package:conecta2peju/domain/models/user.dart';

class ListRequests {
  final List<User>? requests;

  ListRequests({this.requests});

  factory ListRequests.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['friend_request'] as List;

    List<User> dataList = list.map((i) => User.fromJson(i)).toList();

    return ListRequests(requests: dataList);
  }
}
