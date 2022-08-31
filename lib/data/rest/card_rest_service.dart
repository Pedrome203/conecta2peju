import 'dart:convert';

import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/utils/helpers.dart';
import 'package:http/http.dart' as http;

@override
Future<ListCards> getCards() async {
  final url = Uri.parse(baseUrl! + 'cards/2');
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  return ListCards.fromJson(responseJson);
}

Future<dynamic> getCardsLike(int idCategory) async {
  final url = Uri.parse(baseUrl! + 'likes/2/' + idCategory.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<dynamic> getCardsSave(int idCategory) async {
  final url = Uri.parse(baseUrl! + 'saves/2/' + idCategory.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<dynamic> getCardsCreate(int idCategory) async {
  final url = Uri.parse(baseUrl! + 'create_card/2/' + idCategory.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
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

Future<bool> postCard(int idUser, int idCategory, String content) async {
  final url = Uri.parse(baseUrl! + 'likes/');

  final response = await http.post(url,
      body: jsonEncode({
        "content": content,
        "id_user": idUser.toString(),
        "id_category": idCategory.toString()
      }));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
