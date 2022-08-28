// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:conecta2peju/data/rest/card_rest_service.dart';
import 'package:conecta2peju/domain/models/card.dart';
import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/domain/models/repository/card_api.dart';
import 'package:flutter/material.dart';

class FeedNewsProvider extends ChangeNotifier {
  FeedNewsProvider();
  bool? loading = false;
  ListCards? cardList;

  Future<void> loadCards() async {
    loading = false;
    cardList = await getCards();
    loading = true;
    notifyListeners();
  }
}
