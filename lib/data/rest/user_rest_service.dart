import 'dart:convert';

import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/domain/models/list_requests.dart';
import 'package:conecta2peju/domain/models/list_users.dart';
import 'package:conecta2peju/domain/models/user.dart';
import 'package:conecta2peju/utils/helpers.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/auth.dart';

Future<User> getUser() async {
  final url = Uri.parse(baseUrl! + 'cards/2');
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  return User.fromJson(responseJson);
}

Future<dynamic> getAllCardsCreate() async {
  final url = Uri.parse(baseUrl! + 'all_create_card/2');
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<dynamic> getUserData(int idUser, int idStalker) async {
  final url = Uri.parse(
      baseUrl! + 'users/' + idUser.toString() + '/' + idStalker.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [
      true,
      ListCards.fromJson(responseJson),
      ListUsers.fromJson(responseJson),
      User.fromJson(responseJson['user']),
      responseJson['status']
    ];
  }
}

Future<dynamic> getFriendRequests(int idUser) async {
  final url = Uri.parse(baseUrl! + 'friend_requests/' + idUser.toString());
  final response = await http.get(url);

  if (response.statusCode != 200) {
    return [false];
  } else {
    final responseJson = json.decode(response.body);
    return [
      true,
      ListRequests.fromJson(responseJson),
    ];
  }
}

Future<bool> postFriendRequest(int idUserS, int idUserR, int status) async {
  final url = Uri.parse(baseUrl! + 'friend_requests/');

  final response = await http.post(url,
      body:
          jsonEncode({"user_s": idUserS, "user_r": idUserR, "status": status}));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<dynamic>> authUserEmail(String email, String password) async {
  final url = Uri.parse(baseUrl! + 'api-token-auth/');
  print(email);
  print(password);
  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          {"email": email, "username": email, "password": password}));
  print(response.body);
  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    return [
      true,
      Auth.fromJson(responseJson),
    ];
  } else {
    return [false];
  }
}
