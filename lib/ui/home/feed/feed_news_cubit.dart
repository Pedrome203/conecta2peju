// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:conecta2peju/data/rest/card_rest_service.dart';

import 'package:conecta2peju/domain/models/list_cards.dart';

import 'package:flutter/material.dart';

class FeedNewsProvider extends ChangeNotifier {
  FeedNewsProvider();
  bool? loading = false;
  ListCards? cardList;
  ListCards? cardsSave;
  ListCards? cardsCreate;
  ListCards? cardsLike;
  String? message;
  Future<void> loadCards() async {
    loading = false;
    cardList = await getCards();
    loading = true;

    notifyListeners();
  }

  Future<void> loadCardsSave(int idCategory) async {
    ListCards? list;
    loading = false;
    final response = await getCardsSave(idCategory);
    print(response[0]);
    if (response[0] == true) {
      list = response[1];
    } else {
      print('NULL');
      message = 'Cards No Found';
    }
    cardsSave = list;
    loading = true;
    notifyListeners();
  }

  Future<void> loadCardsCreate(int idCategory) async {
    ListCards? list;
    loading = false;
    final response = await getCardsCreate(idCategory);

    if (response[0] == true) {
      list = response[1];
    } else {
      message = 'Cards No Found';
    }
    cardsCreate = list;
    loading = true;
    notifyListeners();
  }

  Future<void> loadCardsLike(int idCategory) async {
    ListCards? list;
    loading = false;
    final response = await getCardsLike(idCategory);

    if (response[0] == true) {
      list = response[1];
    } else {
      message = 'Cards No Found';
    }
    cardsLike = list;
    loading = true;
    notifyListeners();
  }

  Future<void> addLike(int index, int idUser, int idCard, int status) async {
    bool sendStatus;
    if (status == 1) {
      status = 0;
      sendStatus = false;
      cardList!.cards![index].countLike =
          cardList!.cards![index].countLike! - 1;
    } else {
      status = 1;
      sendStatus = true;
      cardList!.cards![index].countLike =
          cardList!.cards![index].countLike! + 1;
    }
    cardList!.cards![index].isLike = status;
    final response = await postLike(idUser, idCard, sendStatus);
    if (response == false) {
      if (status == 1) {
        status = 1;
        cardList!.cards![index].countLike =
            cardList!.cards![index].countLike! + 1;
      } else {
        status = 0;
        cardList!.cards![index].countLike =
            cardList!.cards![index].countLike! - 1;
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
