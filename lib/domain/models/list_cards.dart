import 'package:conecta2peju/domain/models/card.dart';

class ListCards {
  final List<CardPost>? cards;

  ListCards({this.cards});

  factory ListCards.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['cards'] as List;

    List<CardPost> dataList = list.map((i) => CardPost.fromJson(i)).toList();

    return ListCards(cards: dataList);
  }
}
