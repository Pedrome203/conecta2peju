import 'package:flutter/material.dart';

Widget primaryButton(BuildContext context,
    {required void Function()? onPressed,
    required String text,
    IconData? iconData,
    Color colorButton = Colors.white,
    Color colorText = Colors.white,
    Color? colorBorder}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: ElevatedButton.icon(
      icon: iconData == null ? Container() : Icon(iconData, color: colorText),
      label: Text(text,
          style: TextStyle(
              color: colorText, fontSize: 16.0, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        primary: colorButton,
        onPrimary: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: colorButton)),
      ),
      onPressed: onPressed,
    ),
  );
}
