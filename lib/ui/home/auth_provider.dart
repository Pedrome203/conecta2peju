// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:conecta2peju/data/rest/user_rest_service.dart';
import 'package:conecta2peju/domain/models/auth.dart';

import 'package:conecta2peju/domain/models/user.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import '../../domain/models/list_users.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();
  bool? loading = false;
  User? user;
  ListUsers? listFriends;
  List<String> friends = [];
  Auth? auth;
  bool waiting = true;
  bool error = false;

  Future<bool> validate(String email, String password) async {
    final response = await authUserEmail(email, password);
    if (response[0] == true) {
      auth = response[1];
      final prefs = await SharedPreferences.getInstance();
      print(auth!.id.toString());

      await prefs.setInt('id', auth!.id);
      await prefs.setString('token', auth!.token);
      error = false;
      notifyListeners();
      return true;
    } else {
      error = true;
      notifyListeners();
      return false;
    }
  }

  Future<bool> authUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('id') == null) {
      notifyListeners();
      error = true;

      return false;
    } else {
      final response =
          await getUserData(prefs.getInt('id')!, prefs.getInt('id')!);
      if (response[0] == true) {
        error = false;
        user = response[3];
        listFriends = response[2];
        friends = listFriends!.users!.map((user) => user.username).toList();

        loading = true;
        print(user!.id);
        notifyListeners();
        return true;
      } else {
        error = true;
        notifyListeners();
        return false;
      }
    }
  }

  void reset() {
    error = false;
    loading = false;
    waiting = true;
  }
}
