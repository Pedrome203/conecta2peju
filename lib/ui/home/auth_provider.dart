// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:conecta2peju/data/rest/user_rest_service.dart';

import 'package:conecta2peju/domain/models/user.dart';

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();
  bool? loading = true;
  User? user;

  Future<void> authUser(int idUser) async {
    loading = true;

    final response = await getUserData(idUser, idUser);

    if (response[0] == true) {
      user = response[3];
      print(user!.id);
    }
    loading = false;
    notifyListeners();
  }
}
