import 'package:flutter/material.dart';

class VakinhaAppbar extends AppBar {
  VakinhaAppbar({
    Key? key,
    double elevation = 2.0,
  }) : super(
    key: key,
    backgroundColor: Colors.white,
    elevation: elevation,
    centerTitle: true,
    title: Image.asset(
      'assets/images/logo.png',
      width: 80.0,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}