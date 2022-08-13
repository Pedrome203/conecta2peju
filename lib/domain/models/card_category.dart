import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryCard {
  const CategoryCard({this.id, this.name, this.icon, this.color});
  final int? id;
  final String? name;
  final ImageIcon? icon;
  final Color? color;
}

const listCategory = <CategoryCard>[
  CategoryCard(
      id: 1,
      name: 'Grammar',
      icon: ImageIcon(
        AssetImage("assets/images/grammar-icon.png"),
        color: Color.fromARGB(211, 59, 58, 58),
        size: 120,
      ),
      color: Color.fromARGB(27, 136, 15, 192)),
  CategoryCard(
      id: 2,
      name: 'Greetings',
      icon: ImageIcon(
        AssetImage("assets/images/greeting-icon.png"),
        color: Color.fromARGB(211, 59, 58, 58),
        size: 130,
      ),
      color: Color.fromARGB(27, 243, 48, 9)),
  CategoryCard(
      id: 3,
      name: 'Questions',
      icon: ImageIcon(
        AssetImage("assets/images/questions-icon.png"),
        color: Color.fromARGB(211, 59, 58, 58),
        size: 140,
      ),
      color: Color.fromARGB(27, 251, 255, 23)),
  CategoryCard(
      id: 4,
      name: 'Animals',
      icon: ImageIcon(
        AssetImage("assets/images/animals-icon.png"),
        color: Color.fromARGB(211, 59, 58, 58),
        size: 150,
      ),
      color: Color.fromARGB(27, 62, 192, 15)),
  CategoryCard(
      id: 5,
      name: 'Places',
      icon: ImageIcon(
        AssetImage("assets/images/places-icon.png"),
        color: Color.fromARGB(211, 59, 58, 58),
        size: 120,
      ),
      color: Color.fromARGB(27, 192, 15, 154)),
  CategoryCard(
      id: 6,
      name: 'Other',
      icon: ImageIcon(
        AssetImage("assets/images/other-icon.png"),
        color: Color.fromARGB(211, 59, 58, 58),
        size: 120,
      ),
      color: Color.fromARGB(27, 19, 212, 246)),
];
