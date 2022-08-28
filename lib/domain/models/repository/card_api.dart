import 'package:conecta2peju/domain/models/card.dart';

abstract class CardApi {
  Future<List<CardPost>> getCards();
}
