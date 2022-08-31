// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:conecta2peju/data/rest/user_rest_service.dart';

import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/domain/models/user.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider();
  bool? loading = false;
  ListCards? cardsCreate;
  String? message;
  List<User>? friends;

  Future<void> loadAllCardsCreate() async {
    ListCards? list;
    loading = false;
    friends = listFriends;

    final response = await getAllCardsCreate();

    if (response[0] == true) {
      list = response[1];
    } else {
      message = 'Cards No Found';
    }
    cardsCreate = list;
    loading = true;
    notifyListeners();
  }
}
