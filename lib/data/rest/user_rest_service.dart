import 'dart:convert';

import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/domain/models/user.dart';
import 'package:conecta2peju/utils/helpers.dart';
import 'package:http/http.dart' as http;

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
