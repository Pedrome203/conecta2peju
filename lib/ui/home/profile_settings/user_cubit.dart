// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:conecta2peju/data/rest/user_rest_service.dart';

import 'package:conecta2peju/domain/models/list_cards.dart';
import 'package:conecta2peju/domain/models/list_users.dart';
import 'package:conecta2peju/domain/models/user.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider();
  bool? loading = true;
  User? user;
  int? status;

  ListCards? cardsCreate;
  ListUsers? friends;
  String? message;

  Future<void> loadDataUser(int idUser, int idStalker) async {
    ListCards? list;
    loading = true;

    final response = await getUserData(idUser, idStalker);

    if (response[0] == true) {
      list = response[1];
      friends = response[2];
      user = response[3];
      status = response[4];
    } else {
      message = 'Cards No Found';
    }
    cardsCreate = list;
    loading = false;
    notifyListeners();
  }

  Future<dynamic> addFriendRequest(
    int idUserS,
    int idUserR,
    int statusR,
  ) async {
    final response = await postFriendRequest(idUserS, idUserR, statusR);
    if (response) {
      status = 1;
      notifyListeners();
    }

    return response;
  }
}
