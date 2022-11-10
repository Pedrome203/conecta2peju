class Auth {
  Auth({
    required this.id,
    required this.token,
  });

  final int id;
  final String token;

  factory Auth.fromJson(Map<String, dynamic> json) =>
      Auth(id: json["id"], token: json["token"]);
}
