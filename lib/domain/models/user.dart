class User {
  User({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json["id"], name: json["name"], image: json["image"]);
}

final listFriends = <User>[
  User(
    id: 1,
    name: 'Pedro Morales Enríquez',
    image:
        'https://static.wikia.nocookie.net/fma/images/1/1f/Full_metal_5.jpg/revision/latest?cb=20150516013821&path-prefix=es',
  ),
  User(
    id: 1,
    name: 'Ana Ortiz Díaz',
    image:
        'https://malagafotografia.com/wp-content/uploads/2020/05/Aprender-a-sonrei%CC%81r-para-las-fotos.jpg',
  ),
  User(
    id: 1,
    name: 'Miguel Andres Martinez',
    image:
        'https://www.lepetitchateaux.com/wp-content/uploads/2020/11/M.-Amparo.jpg',
  ),
  User(
    id: 1,
    name: 'Joaquín Gomez Meza',
    image: 'https://thumbs.dreamstime.com/b/cara-real-del-hombre-33714577.jpg',
  ),
  User(
    id: 1,
    name: 'José Hernandez Mejía',
    image:
        'https://i0.wp.com/thehappening.com/wp-content/uploads/2017/07/foto-perfil-5.jpg?resize=1024%2C694&ssl=1',
  )
];
