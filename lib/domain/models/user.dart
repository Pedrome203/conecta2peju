class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.englishLevel,
    required this.idFirebase,
    required this.image,
    required this.username,
  });

  final int id;
  final String name;
  final String email;
  final int englishLevel;
  final String idFirebase;
  final String image;
  final String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["idUser"],
      name: json["name"],
      email: json["email"],
      englishLevel: json["english_level_id"],
      idFirebase: json["id_firebase"],
      image: json["image"],
      username: json["username"]);
}

final listFriends = <User>[];
