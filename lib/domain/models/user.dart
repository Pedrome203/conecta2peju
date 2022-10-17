class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.englishLevel,
    required this.idFirebase,
    required this.image,
  });

  final int id;
  final String name;
  final String email;
  final int englishLevel;
  final String idFirebase;
  final String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["idUser"],
      name: json["name"],
      email: json["email"],
      englishLevel: json["english_level_id"],
      idFirebase: json["id_firebase"],
      image: json["image"]);
}

final listFriends = <User>[];
