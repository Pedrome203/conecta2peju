import 'dart:convert';

import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/utils/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@override
Future<ListCards> getCards(int idUser) async {
  final url = Uri.parse(baseUrl! + 'cards/' + idUser.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  return ListCards.fromJson(responseJson);
}

Future<dynamic> getRecommendations(int idUser) async {
  final url = Uri.parse(
      'https://conecta2-peju.herokuapp.com/ia/suggestion/' + idUser.toString());
  final response = await http.get(url);
  if (response.statusCode != 200) {
    return [false];
  } else {
    final responseJson = json.decode(response.body);
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<dynamic> getCardsLike(int idCategory, int idUser) async {
  final url = Uri.parse(
      baseUrl! + 'likes/' + idUser.toString() + '/' + idCategory.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<dynamic> getCardsSave(int idCategory, int idUser) async {
  final url = Uri.parse(
      baseUrl! + 'saves/' + idUser.toString() + '/' + idCategory.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<dynamic> getCardsCreate(int idCategory, int idUser) async {
  final url = Uri.parse(baseUrl! +
      'create_card/' +
      idUser.toString() +
      '/' +
      idCategory.toString());
  final response = await http.get(url);

  final responseJson = json.decode(response.body);

  if (responseJson['message'] == 'NO FOUND') {
    return [false];
  } else {
    return [true, ListCards.fromJson(responseJson)];
  }
}

Future<bool> postLike(int idUser, int idCard, bool status) async {
  final url = Uri.parse(baseUrl! + 'likeset/');
  final pref = await SharedPreferences.getInstance();
  final response = await http.post(url,
      headers: <String, String>{
        'Authorization': 'Token ' + pref.getString('token')!,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "id_user": idUser.toString(),
        "id_card": idCard.toString(),
        "status": status
      }));
  print(response.statusCode);
  print(idUser);
  print(idCard);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> postSave(int idUser, int idCard, bool status) async {
  final url = Uri.parse(baseUrl! + 'saveset/');
  final pref = await SharedPreferences.getInstance();
  final response = await http.post(url,
      headers: <String, String>{
        'Authorization': 'Token ' + pref.getString('token')!,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
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
  final url = Uri.parse(baseUrl! + 'cardset/');
  final pref = await SharedPreferences.getInstance();
  final response = await http.post(url,
      headers: <String, String>{
        'Authorization': 'Token ' + pref.getString('token')!,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
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
