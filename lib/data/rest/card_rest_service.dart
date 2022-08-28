import 'dart:convert';

import 'package:conecta2peju/domain/models/card.dart';
import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/domain/models/repository/card_api.dart';
import 'package:conecta2peju/utils/helpers.dart';
import 'package:http/http.dart' as http;

@override
Future<ListCards> getCards() async {
  final url = Uri.parse(baseUrl! + 'cards/2');
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  return ListCards.fromJson(responseJson);
}

Future<bool> postLike(int idUser, int idCard, bool status) async {
  final url = Uri.parse(baseUrl! + 'likes/');

  final response = await http.post(url,
      body: jsonEncode({
        "id_user": idUser.toString(),
        "id_card": idCard.toString(),
        "status": status
      }));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> postSave(int idUser, int idCard, bool status) async {
  final url = Uri.parse(baseUrl! + 'saves/');

  final response = await http.post(url,
      body: jsonEncode({
        "id_user": idUser.toString(),
        "id_card": idCard.toString(),
        "status": status
      }));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
