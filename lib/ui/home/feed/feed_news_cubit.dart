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
  Future<void> loadCards(int idUser) async {
    loading = false;
    cardList = await getCards(idUser);
    loading = true;

    notifyListeners();
  }

  Future<void> loadCardsSave(int idCategory, int idUser) async {
    ListCards? list;
    loading = false;
    print('CARDS' + idUser.toString());
    final response = await getCardsSave(idCategory, idUser);

    if (response[0] == true) {
      list = response[1];
    } else {
      message = 'Cards No Found';
    }
    cardsSave = list;
    loading = true;
    notifyListeners();
  }

  Future<void> loadCardsCreate(int idCategory, int idUser) async {
    ListCards? list;
    loading = false;
    final response = await getCardsCreate(idCategory, idUser);

    if (response[0] == true) {
      list = response[1];
    } else {
      message = 'Cards No Found';
    }
    cardsCreate = list;
    loading = true;
    notifyListeners();
  }

  Future<void> loadCardsLike(int idCategory, int idUser) async {
    ListCards? list;
    loading = false;
    final response = await getCardsLike(idCategory, idUser);

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
      if (status == 0) {
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
      if (status == 0) {
        status = 1;
      } else {
        status = 0;
      }
      cardList!.cards![index].isSave = status;
    }

    notifyListeners();
  }

  Future<dynamic> addCard(
    int idUser,
    int idCategory,
    String content,
  ) async {
    final response = await postCard(idUser, idCategory, content);
    return response;
  }
}
