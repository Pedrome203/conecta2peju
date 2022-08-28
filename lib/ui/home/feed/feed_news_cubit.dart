// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:conecta2peju/data/rest/card_rest_service.dart';

import 'package:conecta2peju/domain/models/list_cards.dart';

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

  Future<void> addLike(int index, int idUser, int idCard, int status) async {
    bool sendStatus;
    if (status == 1) {
      status = 0;
      sendStatus = false;
      cardList!.cards![index].countLike--;
    } else {
      status = 1;
      sendStatus = true;
      cardList!.cards![index].countLike++;
    }
    cardList!.cards![index].isLike = status;
    final response = await postLike(idUser, idCard, sendStatus);
    if (response == false) {
      if (status == 1) {
        status = 1;
        cardList!.cards![index].countLike++;
      } else {
        status = 0;
        cardList!.cards![index].countLike--;
      }
      cardList!.cards![index].isLike = status;
    }

    notifyListeners();
  }

  Future<void> addSave(int index, int idUser, int idCard, int status) async {
    bool sendStatus;
    if (status == 1) {
      status = 0;
      sendStatus = false;
    } else {
      status = 1;
      sendStatus = true;
    }
    cardList!.cards![index].isSave = status;
    final response = await postSave(idUser, idCard, sendStatus);
    if (response == false) {
      if (status == 1) {
        status = 1;
      } else {
        status = 0;
      }
      cardList!.cards![index].isSave = status;
    }

    notifyListeners();
  }
}
