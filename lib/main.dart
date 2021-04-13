import 'package:flutter/material.dart';
import 'package:sample_api/pages/index.dart';
import 'package:sample_api/theme/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primary
    ),
    home: IndexPage(),
  ));
}
