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
  print(responseJson);
  return ListCards.fromJson(responseJson);
}
