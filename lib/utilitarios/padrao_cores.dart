import 'package:flutter/material.dart';

Color backgroundColor = const Color.fromARGB(238, 238, 100, 90);
Color secondaryOrange = const Color(0xFFF5A342);
Color greyColor = const Color.fromRGBO(240, 241, 245, 1);
Color greyT = const Color.fromARGB(255, 63, 63, 63);
LinearGradient gradiente() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF43E32),
      Color(0xFFF5A342),
    ],
  );
}
