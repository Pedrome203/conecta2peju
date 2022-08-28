import 'dart:convert';

List<CardPost> cardFromJson(String str) =>
    List<CardPost>.from(json.decode(str).map((x) => CardPost.fromJson(x)));

class CardPost {
  CardPost(
      {required this.id,
      required this.name,
      required this.content,
      required this.userId,
      required this.isLike,
      required this.isSave,
      required this.countLike});

  final int id;
  final String name;
  final String content;
  final int userId;
  final int isLike;
  final int isSave;
  final int countLike;

  factory CardPost.fromJson(Map<String, dynamic> json) => CardPost(
        id: json["id"],
        name: json["user_id__name"],
        content: json["content"],
        userId: json["user_id"],
        isLike: json["isLike"],
        isSave: json["isSave"],
        countLike: json["countLike"],
      );
}
